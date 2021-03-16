import 'package:flutter/material.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/UI/tasks/tasks_card.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = Task.fetchTasks();
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: []..addAll(cards(tasks)),
          ),
        ),
      ),
    );
  }

  List<Widget> cards(List<Task> tasks) {
    return tasks.map((task) => TasksCard(task.name, task.value)).toList();
  }
}
