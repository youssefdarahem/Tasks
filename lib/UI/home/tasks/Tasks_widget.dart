import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Data/task.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier notifier = Provider.of<TaskNotifier>(context);
    if (notifier.taskStatus == Status.notFetched) {
      notifier.addAll();
    }

    
    return Expanded(
      flex:2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Tasks:"),
            ListView.builder(
              shrinkWrap: true,
              itemCount: notifier.listLength,

              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return mapToTiles(notifier.taskList, notifier)[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget taskTile(int id, String title, String subTitle, TaskNotifier notifier) {
  onDone() {
    print("$id :  $title  Done");
    notifier.deleteTaskWithId(id);
  }

  return Slidable(
    key: Key(title),
    dismissal: SlidableDismissal(
      child: SlidableDrawerDismissal(),
      onDismissed: (type) {
        onDone();
      },
    ),
    actionPane: SlidableScrollActionPane(),
    actions: [
      IconSlideAction(
        caption: 'Done',
        color: Colors.blue,
        icon: Icons.done,
        onTap: () {
          onDone();
        },
      ),
    ],
    actionExtentRatio: 1 / 5,
    child: ListTile(
     

      title: Text(title),
      subtitle: Text(subTitle),
    ),
  );
}

List<Widget> mapToTiles(List<Task> tasks, TaskNotifier notifier) {
  return tasks
      .map((_task) =>
          taskTile(_task.id as int, _task.name, _task.value, notifier))
      .toList();
}
