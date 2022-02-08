import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Models/task.dart';

class FinishedTaskTile extends StatelessWidget {
  final Task task;
  const FinishedTaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          task.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          task.value,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => Provider.of<GoalNotifier>(context, listen: false)
              .deleteTask(task.id!, task.goalId!),
        ),
      ),
    );
  }
}
