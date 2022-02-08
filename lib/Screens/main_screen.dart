import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Widgets/goals_widget.dart';
import 'package:tasks/Widgets/loading_widget.dart';
import 'package:tasks/Widgets/tasks_widget.dart';


class MainScreen extends StatelessWidget {
  final taskWidgetHeight;
  final goalWidgetHeight;

  MainScreen({required this.taskWidgetHeight, required this.goalWidgetHeight});
  @override
  Widget build(BuildContext context) {
    GoalNotifier goalNotifier = Provider.of<GoalNotifier>(context);
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
        height: taskWidgetHeight + goalWidgetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            goalNotifier.goalStatus == Status.notFetched
                ? LoadingWidget()
                : GoalsWidget(
                    height: goalWidgetHeight,
                  ),
            taskNotifier.taskStatus == Status.notFetched
                ? LoadingWidget()
                : TasksWidget(
                    height: taskWidgetHeight,
                  ),
          ],
        ),
      ),
    );
  }
}
