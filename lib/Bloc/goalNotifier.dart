import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Data/goal.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/Database/tasks_database.dart';

class GoalNotifier extends ChangeNotifier {
  List<Goal> _goalList = [];
  int listLength = 0;
  Status goalStatus = Status.notFetched;

  UnmodifiableListView<Goal> get goalList => UnmodifiableListView(_goalList);

  addGoal(Goal goal) async {
    Goal goalFromDB = await TasksDatabase.instance.createGoal(goal);
    _goalList.add(goalFromDB);
    listLength++;
    notifyListeners();
  }

  deleteGoal(int index) async {
    await TasksDatabase.instance.deleteGoal(goalList[index].id as int);
    _goalList.removeWhere((_task) => _task.id == goalList[index].id);
    listLength--;
    notifyListeners();
  }

  deleteGoalWithId(int id) async {
    await TasksDatabase.instance.deleteGoal(id);
    _goalList.removeWhere((_task) => _task.id == id);

    listLength--;
    notifyListeners();
  }

  addAllGoals() async {
    List<Goal> _goalsFromDatabase = await TasksDatabase.instance.readAllGoals();
    _goalList.addAll(_goalsFromDatabase);
    listLength = _goalList.length;
    _goalList.forEach((goal) async {
      List<Task> _tasksFromDatabase =
          await TasksDatabase.instance.readTaskWithGoalId(goal.id as int);
      if (_tasksFromDatabase.isNotEmpty) {
        goal = goal.copy(tasks: _tasksFromDatabase);
      }
      goalStatus = Status.fetched;
    });
    notifyListeners();
  }
}
