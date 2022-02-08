import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Screens/goal_screen.dart';
import 'package:tasks/Widgets/progress_indecator.dart';

class GoalCard extends StatelessWidget {
  final int id;
  final String title;
  final double heightOfParent;

  const GoalCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.heightOfParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoalNotifier goalNotifier = Provider.of<GoalNotifier>(context);
    return Container(
      width: 160,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, GoalPage.goalPageRoute, arguments: id);
        },
        child: SingleChildScrollView(
          child: Container(
            height: heightOfParent * 0.7,
            child: Card(
              key: ValueKey(id.toString()),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    MyProgressIndecator(
                      value: goalNotifier.progressValues[id]!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
