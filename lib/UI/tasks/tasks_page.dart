import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/taskNotifier.dart';

import 'package:tasks/Data/task.dart';


import 'package:tasks/UI/tasks/tasks_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  //List<Task> _tasks;
  bool fetched = false;

  @override
  Widget build(BuildContext context) {
    TaskNotifier notifier = Provider.of<TaskNotifier>(context);
    if (!fetched) {
      notifier.addAll();
      fetched = true;
    }

    //List<Task> _tasks = notifier.addAll();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //mainAxisSize: MainAxisSize.min,
      children: [
        //FutureProvider(create: (_) => TasksDatabase.instance.readAllTasks(), initialData: []),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: notifier.listLength,

              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return mapToCards(notifier.taskList)[index];

                //return Text("Hello :" + index.toString());
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              creatInputDialoge(context).then((task) {
                if (task == null) return;
                notifier.addTask(task);
              });
            },
          ),
        )
      ],
    );
  }

  List<Widget> mapToCards(List<Task> tasks) {
    return tasks.map((_task) => TasksCard(_task.name, _task.value)).toList();
  }

  Future<Task> creatInputDialoge(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                ),
                TextField(
                  controller: valueController,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("close"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(Task(
                            name: nameController.text.toString(),
                            value: valueController.text.toString()));
                      },
                      child: Text("Add"),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
