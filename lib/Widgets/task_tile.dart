import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';

import '../Models/task.dart';

import './add_or_edit_task.dart';

class TaskTile extends StatelessWidget {
  final int id;
  final String title;
  final String subTitle;
  final bool isForGoal;
  final int goalid;

  const TaskTile(
      {Key? key,
      required this.id,
      required this.title,
      required this.subTitle,
      required this.isForGoal,
      required this.goalid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);
    GoalNotifier goalNotifier = Provider.of<GoalNotifier>(context);

    onDone() {
      print("$id :  $title  Done");
      if (isForGoal) {
        goalNotifier.moveTaskToFinished(
            Task(
                id: id,
                name: title,
                value: subTitle,
                completed: true,
                goalId: goalid),
            goalid);
      } else {
        taskNotifier.deleteTaskWithId(id);
      }
    }

    onDelete() {
      if (isForGoal) {
        goalNotifier.deleteTask(id,goalid);
      } else {
        taskNotifier.deleteTaskWithId(id);
      }
    }

    void startTaskEdit() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          Task oldTask = goalid == -1
              ? taskNotifier.getTaskFromId(id)
              : goalNotifier.getTaskFromId(id);
          return AddOrEditTask(
            goalId: goalid,
            isAdd: false,
            taskId: id,
            oldTaskName: oldTask.name,
            oldTaskValue: oldTask.value,
          );
        },
      );
    }

    return Slidable(
      //controller: SlidableController(),
      key: ValueKey(id.toString()),
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (type) {
          if (type == SlideActionType.primary) {
            onDone();
          } else {
            onDelete();
          }
        },
      ),
      actionPane: SlidableScrollActionPane(),
      actions: [
        IconSlideAction(
          caption: 'Done',
          color: Theme.of(context).primaryColorLight,
          icon: Icons.done,
          onTap: () {
            onDone();
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () {
            onDelete();
          },
        ),
      ],
      actionExtentRatio: 1 / 5,

      child: ListTile(
        
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: InkWell(
          customBorder: CircleBorder(),
          child: Icon(
            Icons.edit,
            color: Colors.lightBlue[300],
          ),
          onTap: () => startTaskEdit(),
        ),
      ),
    );
  }
}
