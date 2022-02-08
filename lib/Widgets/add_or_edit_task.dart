import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Models/task.dart';

class AddOrEditTask extends StatefulWidget {
  final int goalId;
  final bool isAdd;
  final int? taskId;
  final String? oldTaskName;
  final String? oldTaskValue;
  AddOrEditTask(
      {required this.goalId,
      required this.isAdd,
      this.taskId,
      this.oldTaskName,
      this.oldTaskValue});
  @override
  _AddOrEditTaskState createState() => _AddOrEditTaskState();
}

class _AddOrEditTaskState extends State<AddOrEditTask> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  void initState() {
    if (!widget.isAdd) {
      titleController.text = widget.oldTaskName!;
      descController.text = widget.oldTaskValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    GoalNotifier goalNotifier =
        Provider.of<GoalNotifier>(context, listen: false);

    final String buttonText = widget.isAdd ? 'Add Task' : 'Save';

    _onAddOrEditTask() {
      if (titleController.text.isEmpty && descController.text.isEmpty) {
      } else {
        Task currTask;
        if (widget.isAdd) {
          currTask = Task(
              name: titleController.text.toString(),
              value: descController.text.toString(),
              goalId: widget.goalId,
              completed: false);
        } else {
          currTask = widget.goalId == -1
              ? taskNotifier.getTaskFromId(widget.taskId!)
              : goalNotifier.getTaskFromId(widget.taskId!);
          currTask = currTask.copy(
            name: titleController.text.toString(),
            value: descController.text.toString(),
          );
        }

        if (widget.goalId == -1) {
          widget.isAdd
              ? taskNotifier.addTask(currTask)
              : taskNotifier.editTask(currTask);
        } else {
          widget.isAdd
              ? goalNotifier.addTaskforGoal(currTask, widget.goalId)
              : goalNotifier.editTaskforGoal(currTask);
        }

        Navigator.pop(context);
      }
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              creatTextField('New Task', titleController),
              SizedBox(height: 8),
              creatTextField('Write a description', descController),
              SizedBox(height: 8),
              TextButton(
                child: Text(
                  buttonText,
                  style: TextStyle(
                      backgroundColor: Colors.transparent, fontSize: 15),
                ),
                onPressed: () => _onAddOrEditTask(),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget creatTextField(String hintText, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      cursorColor: Colors.black87,
      controller: controller,

      //maxLines: 6,
    );
  }
}
