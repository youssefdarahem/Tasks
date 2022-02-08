import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Widgets/no_list_placeholder.dart';

import '../Models/task.dart';

import 'package:tasks/Widgets/task_tile.dart';

class TasksWidget extends StatelessWidget {
  final double height;

  TasksWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

    Widget taskListUi = createTaskListUi(
        taskNotifier.listLength, taskNotifier.taskList, context, mediaQuery);

    return taskListUi;
  }

  Widget createTaskListUi(int listLenght, List<Task> tasks,
      BuildContext context, MediaQueryData mediaQuery) {
    return Container(
      height: this.height,
      padding: const EdgeInsets.all(8.0),
      //color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            "Today's Tasks",
            style: Theme.of(context).textTheme.headline1,
          ),
          listLenght == 0
              ? Expanded(
                  child: Center(
                    child: NoListPlaceholder(
                      imagePath: 'assets/images/notebook.png',
                      text: 'No tasks.. Let\'s add some',
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listLenght,
                    
                    itemBuilder: (context, index) {
                      return mapToTiles(tasks)[index];
                    },
                  ),
                ),
        ],
      ),
    );
  }

  List<Widget> mapToTiles(List<Task> tasks) {
    return tasks
        .map((_task) => TaskTile(
              id: _task.id!,
              title: _task.name,
              subTitle: _task.value,
              isForGoal: false,
              goalid: -1,
            ))
        .toList();
  }
}
