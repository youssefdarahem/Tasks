import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Widgets/no_list_placeholder.dart';
import '../Models/goal.dart';

import 'goal_card.dart';

class GoalsWidget extends StatelessWidget {
  final double height;
  GoalsWidget({required this.height});
  @override
  Widget build(BuildContext context) {
    GoalNotifier goalNotifier = Provider.of<GoalNotifier>(context);

    return Container(
      height: this.height,
      padding: const EdgeInsets.all(8.0),
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Goals",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 8),
          createGoalsListUi(goalNotifier.goalList),
        ],
      ),
    );
  }

  List<Widget> mapToTiles(List<Goal> goals) {
    return goals
        .map((_goal) => GoalCard(
              id: _goal.id!,
              title: _goal.name,
              heightOfParent: height,
            ))
        .toList();
  }

  Widget createGoalsListUi(List<Goal> goals) {
    return goals.isEmpty
        ? Expanded(
            child: Center(
              child: NoListPlaceholder(
                imagePath: "assets/images/goal.png",
                text: 'Let\'s set some goals',
              ),
            ),
          )
        : Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: goals.length,
              itemBuilder: (context, index) {
                return mapToTiles(goals)[index];
              },
            ),
          );
  }
}
