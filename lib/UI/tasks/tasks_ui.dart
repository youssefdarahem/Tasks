import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/Database/tasks_database.dart';
import 'package:tasks/UI/tasks/tasks_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier notifier = Provider.of<TaskNotifier>(context);
    List<Task> _tasks = notifier.addAll();
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: []..addAll(cards(_tasks)),
          ),
        ),
      ),
    );
  }

  List<Widget> cards(List<Task> tasks) {
    return tasks.map((task) => TasksCard(task.name, task.value)).toList();
  }
}
