import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Database/tasks_database.dart';
import 'package:tasks/Models/goal.dart';


class FinishedGoalsNotifier with ChangeNotifier {
  List<Goal> _finishedGoals = [];
  UnmodifiableListView<Goal> get finishedGoals =>
      UnmodifiableListView(_finishedGoals);
  Status finishedGoalsStatus = Status.notFetched;

  Future<void> fetchFinishedGoals() async {
    List<Goal> _goalsFromDatabase =
        await TasksDatabase.instance.readGoals(true);
    _finishedGoals = _goalsFromDatabase;
    finishedGoalsStatus = Status.fetched;
    notifyListeners();
  }

  addGoal(Goal goal) {
    _finishedGoals.add(goal);
  }

  Goal getGoalwithId(int id) {
    return _finishedGoals.firstWhere((_goal) => _goal.id == id);
  }

  deletefinishedGoal(int id) async {
    await TasksDatabase.instance.deleteGoal(id);
    _finishedGoals.removeWhere((_goal) => _goal.id == id);
    notifyListeners();
  }
}
