import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/Database/tasks_database.dart';

class TaskNotifier extends ChangeNotifier {
  List<Task> _taskList = [];
  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);

  addTask(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  deleteTask(int index) {
    _taskList.removeWhere((_task) => _task.id == taskList[index].id);
    notifyListeners();
  }

  addAll() async{
    List<Task> _tasksFromDatabase = await TasksDatabase.instance.readAllTasks();
    _taskList.addAll(_tasksFromDatabase);
    notifyListeners();
  }
}
