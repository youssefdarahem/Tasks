import 'package:flutter/material.dart';
import 'package:tasks/UI/home/goals/Goals_widget.dart';
import 'package:tasks/UI/home/tasks/Tasks_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello User",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text("Goals :"),
            GoalsWidget(),
            SizedBox(height: 8),
            TasksWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_task_page');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
