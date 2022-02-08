import 'dart:collection';

import 'package:flutter/material.dart';
import '../Models/task.dart';
import 'package:tasks/Database/tasks_database.dart';

enum Status { notFetched, fetched }
enum GeneralStatus { connectingToDB, connected }

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];

  int listLength = 0;

  bool isAddTaskCalledForGoal = false;
  Status taskStatus = Status.notFetched;
  GeneralStatus generalStatus = GeneralStatus.connectingToDB;
  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);

  Task getTaskFromId(int id) {
    return _taskList.firstWhere((task) => task.id == id);
  }

  TaskNotifier() {
    addAllTasks();
  }

  connectToDb() async {
    await TasksDatabase.instance.database;
    generalStatus = GeneralStatus.connected;
    notifyListeners();
  }

  addTask(Task task) async {
    Task taskFromDB = await TasksDatabase.instance.createTask(task);

    _taskList.add(taskFromDB);
    listLength++;

    notifyListeners();
  }

  editTask(Task task) async {
    await TasksDatabase.instance.updateTask(task);
    int index = _taskList.indexWhere((_task) => _task.id == task.id);
    _taskList[index] = task;
    notifyListeners();
  }

  deleteTask(int index) async {
    await TasksDatabase.instance.deleteTask(taskList[index].id as int);
    _taskList.removeWhere((_task) => _task.id == taskList[index].id);
    listLength--;
    notifyListeners();
  }

  deleteTaskWithId(int id) async {
    int index;
    for (index = 0; index < listLength; index++) {
      if (_taskList[index].id == id) break;
    }
    await TasksDatabase.instance.deleteTask(id);
    _taskList.removeWhere((_task) => _task.id == id);

    listLength--;
    notifyListeners();
  }

  addAllTasks() async {
    List<Task> _tasksFromDatabase =
        await TasksDatabase.instance.readTasksWithoutGoals();
    if (_tasksFromDatabase == []) return;
    _taskList.addAll(_tasksFromDatabase);

    listLength = _taskList.length;
    print("listLenght: $listLength");
    taskStatus = Status.fetched;
    notifyListeners();
  }
}
