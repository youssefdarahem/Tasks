import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:tasks/Bloc/taskNotifier.dart';
import '../Models/task.dart';
import '../Models/goal.dart';
import 'package:tasks/Database/tasks_database.dart';

enum GoalType { current, finished }

class GoalNotifier with ChangeNotifier {
  List<Goal> _goalList = [];
  List<Task> currentGoalTasks = [];
  int listLength = 0;
  Status goalStatus = Status.notFetched;
  Status goalTasksStat = Status.notFetched;
  Status progressValuesStat = Status.notFetched;

  //int id = 0;
  //bool isGoingToDelete = false;

  Map<int, double> progressValues = {};

  UnmodifiableListView<Goal> get goalList => UnmodifiableListView(_goalList);

  GoalNotifier() {
    addAllGoals();
  }

  Task getTaskFromId(int id) {
    return currentGoalTasks.firstWhere((task) => task.id == id);
  }

  addGoal(Goal goal) async {
    Goal goalFromDB = await TasksDatabase.instance.createGoal(goal);
    _goalList.add(goalFromDB);
    listLength++;
    progressValues[goalFromDB.id!] = 0.0;
    notifyListeners();
  }

  deleteGoal(int index) async {
    await TasksDatabase.instance.deleteGoal(goalList[index].id as int);
    _goalList.removeWhere((_task) => _task.id == goalList[index].id);
    listLength--;
    notifyListeners();
  }

  //it deletes goal and tasks from db but only goals from app
  //delete tasks should be called after this to delete associate tasks
  deleteGoalWithId(int id) async {
    await TasksDatabase.instance.deleteGoal(id);
    await TasksDatabase.instance.deleteTaskWithGoalId(id);

    _goalList.removeWhere((_task) => _task.id == id);
    listLength--;
    notifyListeners();
    print('this is after notifiying listeneres');

    goalTasksStat = Status.notFetched;
    currentGoalTasks = [];
  }

  deleteTask(int taskId, int goalId) async {
    await TasksDatabase.instance.deleteTask(taskId);
    //int index = getCurrentIndex(id);
    currentGoalTasks.removeWhere((_task) => _task.id == taskId);
    progressValues[goalId] = calculateProgress(
        currentGoalTasks.length, getNumOfFinished(currentGoalTasks));
    notifyListeners();
  }

  moveTaskToFinished(Task task, int id) async {
    await TasksDatabase.instance.updateTask(task);
    currentGoalTasks.removeWhere((_task) => _task.id == task.id);
    currentGoalTasks.add(task);

    progressValues[id] = calculateProgress(
        currentGoalTasks.length, getNumOfFinished(currentGoalTasks));
    notifyListeners();
  }

  moveGoalToFinished(Goal goal) async {
    await TasksDatabase.instance.updateGoal(goal);
    _goalList.removeWhere((_goal) => _goal.id == goal.id);
    currentGoalTasks = [];
    notifyListeners();
  }

  int getNumOfFinished(List<Task> tasks) {
    int numOfFinished = 0;
    tasks.forEach((_task) {
      if (_task.completed == true) {
        numOfFinished++;
      }
    });
    return numOfFinished;
  }

  Future<void> addAllGoals() async {
    List<Goal> _goalsFromDatabase =
        await TasksDatabase.instance.readGoals(false);
    _goalList.addAll(_goalsFromDatabase);
    listLength = _goalList.length;
    if (_goalList.isEmpty) {
      goalStatus = Status.fetched;
      notifyListeners();
      return;
    }

    for (var i = 0; i < listLength; i++) {
      List<Task> _tasksOfGoal =
          await TasksDatabase.instance.readTasksWithGoalId(_goalList[i].id!);
      int numOfFinished = getNumOfFinished(_tasksOfGoal);
      progressValues[_goalList[i].id!] =
          calculateProgress(_tasksOfGoal.length, numOfFinished);
    }

    if (progressValues.isNotEmpty) {
      goalStatus = Status.fetched;
      progressValuesStat = Status.fetched;
    }
    notifyListeners();
  }

  Future<Map<int, double>> getProgressValues() async {
    if (_goalList.isEmpty) return {};
    _goalList.forEach((goal) async {
      List<Task> _tasksOfGoal =
          await TasksDatabase.instance.readTasksWithGoalId(goal.id!);
      int numOfFinished = getNumOfFinished(_tasksOfGoal);
      progressValues[goal.id!] =
          calculateProgress(_tasksOfGoal.length, numOfFinished);
    });
    progressValuesStat = Status.fetched;
    return progressValues;
  }

  double calculateProgress(int total, int finished) {
    if (total == 0) return 0.0;
    return finished / total;
  }

  Goal getGoal(int id) {
    if (_goalList.isEmpty) return Goal(name: "No goals found");
    for (var i = 0; i < listLength; i++) {
      if (_goalList[i].id == id) {
        return _goalList[i];
      }
    }
    return Goal(name: "No goals found");
  }

  int getCurrentIndex(int id) {
    for (var i = 0; i < listLength; i++) {
      if (_goalList[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  Future<void> fetchTasksForGoal(int goalId) async {
    print("the fetch method was called");
    List<Task> tasksFromDb =
        await TasksDatabase.instance.readTasksWithGoalId(goalId);
    if (tasksFromDb.isEmpty) return;
    currentGoalTasks = tasksFromDb;

    notifyListeners();
  }

  List<Task> getTasksByType(GoalType type) {
    List<Task> result = [];
    bool current = !(type == GoalType.current);

    currentGoalTasks.forEach((task) {
      if (task.completed == current) {
        result.add(task);
      }
    });
    return result;
  }

  Future<void> addTaskforGoal(Task task, int id) async {
    Task taskFromDB = await TasksDatabase.instance.createTask(task);
    currentGoalTasks.add(taskFromDB);
    int numOfFinished = getNumOfFinished(currentGoalTasks);
    progressValues[id] =
        calculateProgress(currentGoalTasks.length, numOfFinished);

    notifyListeners();
  }

  Future<void> editTaskforGoal(Task task) async {
    await TasksDatabase.instance.updateTask(task);
    int index = currentGoalTasks.indexWhere((_task) => _task.id == task.id);
    currentGoalTasks[index] = task;
    notifyListeners();
  }

  Future<void> editGoalTitle(String newTitle, int id) async {
    if (newTitle == 'null') return;
    for (var i = 0; i < listLength; i++) {
      if (_goalList[i].id == id) {
        _goalList[i] = _goalList[i].copy(name: newTitle);
        await TasksDatabase.instance.updateGoal(_goalList[i]);
        notifyListeners();
        return;
      }
    }
  }
}
