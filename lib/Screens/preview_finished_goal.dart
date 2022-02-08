import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/finishedGoalsNotifier.dart';
import 'package:tasks/Bloc/privewGoalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Models/goal.dart';
import 'package:tasks/Widgets/preview_tile.dart';

class GoalPreview extends StatelessWidget {
  static const finishedGoalPageRoute = '/finished_goal_page';

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;

    FinishedGoalsNotifier finishedGoalNotifier =
        Provider.of<FinishedGoalsNotifier>(context, listen: false);
    PreviewGoalNotifier previewGoalNotifier =
        Provider.of<PreviewGoalNotifier>(context);

    final Goal goal = finishedGoalNotifier.getGoalwithId(id);

    if (previewGoalNotifier.tasksStat == Status.notFetched) {
      previewGoalNotifier.fetchTasksForGoal(id);
      previewGoalNotifier.tasksStat = Status.fetched;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Goal Preview'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            previewGoalNotifier.reset();

            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(goal.name),
                IconButton(
                  onPressed: () {
                    finishedGoalNotifier.deletefinishedGoal(id);
                    previewGoalNotifier.reset();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 10),
                Text('Finish Date: ${goal.finishedDate}'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.task,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 10),
                Text('Number of Tasks : ${goal.numOfFinishedTasks}'),
              ],
            ),
            SizedBox(height: 20),
            Text('Tasks :'),
            previewGoalNotifier.tasksStat == Status.notFetched
                ? Text('Loading...')
                : Expanded(
                    child: ListView.builder(
                      itemCount: previewGoalNotifier.tasksOfFinishedGoal.length,
                      itemBuilder: (context, index) {
                        return PreviewTile(
                          index: index + 1,
                          title: previewGoalNotifier
                              .tasksOfFinishedGoal[index].name,
                          subTitle: previewGoalNotifier
                              .tasksOfFinishedGoal[index].value,
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
