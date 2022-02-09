import 'package:flutter/material.dart';
import 'package:tasks/Screens/preview_finished_goal.dart';

class FinishedGoalCard extends StatelessWidget {
  final int id;
  final int numOfFinishedTasks;
  final String finishedDate;
  final String title;

  const FinishedGoalCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.numOfFinishedTasks,
      required this.finishedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
          context, GoalPreview.finishedGoalPageRoute,
          arguments: id),
      child: Container(
        key: ValueKey(id.toString()),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: FittedBox(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.task,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 5),
                  FittedBox(
                    child: Text(
                      'Tasks : $numOfFinishedTasks',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 5),
                  Text('$finishedDate'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
