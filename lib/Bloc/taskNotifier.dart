import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/Database/tasks_database.dart';

enum Status { notFetched, fetched }

class TaskNotifier extends ChangeNotifier {
  List<Task> _taskList = [];
  int listLength = 0;
  Status taskStatus = Status.notFetched;
  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);

  addTask(Task task) async {
    Task taskFromDB = await TasksDatabase.instance.createTask(task);
    _taskList.add(taskFromDB);
    listLength++;
    notifyListeners();
  }

  deleteTask(int index) async{
    await TasksDatabase.instance.deleteTask(taskList[index].id as int);
    _taskList.removeWhere((_task) => _task.id == taskList[index].id);
    listLength--;
    notifyListeners();
  }

  deleteTaskWithId(int id) async {
   await TasksDatabase.instance.deleteTask(id);
    _taskList.removeWhere((_task) => _task.id == id);

    listLength--;
    notifyListeners();
  }

  addAll() async {
    List<Task> _tasksFromDatabase = await TasksDatabase.instance.readAllTasks();
    _taskList.addAll(_tasksFromDatabase);
    listLength = _taskList.length;
    taskStatus = Status.fetched;
    notifyListeners();
  }
}
