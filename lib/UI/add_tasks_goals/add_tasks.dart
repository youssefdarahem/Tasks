import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Data/task.dart';

class AddTasksPage extends StatelessWidget {
  const AddTasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier notifier = Provider.of<TaskNotifier>(context);
    TextEditingController taskController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(
        decoration: InputDecoration(
          hintText: 'New task',
          border: InputBorder.none,
        ),
        cursorColor: Colors.black87,
        controller: taskController,
      ),
      Divider(
        color: Colors.blue,
        thickness: 0.2,
      ),
      TextField(
        decoration: InputDecoration(
          hintText: 'Write a description',
          border: InputBorder.none,
        ),
        cursorColor: Colors.black87,
        controller: valueController,
        //maxLines: 6,
      ),
      Divider(
        color: Colors.blue,
        thickness: 0.2,
      ),
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.teal,
          onSurface: Colors.grey,
        ),
        onPressed: () {
          if (taskController.text.isEmpty && valueController.text.isEmpty) {
          } else {
            notifier.addTask(Task(
                name: taskController.text.toString(),
                value: valueController.text.toString()));
          }
          Navigator.pop(context);
        },
        child: const Text('Add'),
      ),
    ]);
  }
}
