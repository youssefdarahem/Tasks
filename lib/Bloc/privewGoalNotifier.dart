import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Database/tasks_database.dart';
import 'package:tasks/Models/task.dart';

class PreviewGoalNotifier with ChangeNotifier {
  List<Task> _tasksOfFinishedGoal = [];
  Status tasksStat = Status.notFetched;

  UnmodifiableListView<Task> get tasksOfFinishedGoal =>
      UnmodifiableListView(_tasksOfFinishedGoal);

  Future<void> fetchTasksForGoal(int goalId) async {
    print("the fetch method was called");
    List<Task> tasksFromDb =
        await TasksDatabase.instance.readTasksWithGoalId(goalId);
    if (tasksFromDb.isEmpty) return;
    _tasksOfFinishedGoal = tasksFromDb;

    notifyListeners();
  }

  reset() {
    _tasksOfFinishedGoal = [];
    tasksStat = Status.notFetched;
  }

}
