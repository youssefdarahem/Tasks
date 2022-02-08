import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/finishedGoalsNotifier.dart';

import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Widgets/add_or_edit_task.dart';
import 'package:tasks/Widgets/finished_tasks_tile.dart';
import 'package:tasks/Widgets/progress_indecator.dart';

import '../Models/goal.dart';
import '../Models/task.dart';
import 'package:tasks/Widgets/dialoges.dart';
import 'package:tasks/Widgets/goal_header.dart';

import 'package:tasks/Widgets/task_tile.dart';

class GoalPage extends StatelessWidget {
  static const goalPageRoute = '/goal_page';
  @override
  Widget build(BuildContext context) {
    print('goalscreen is building.....');
    final goalId = ModalRoute.of(context)!.settings.arguments as int;
    GoalNotifier goalNotifier = Provider.of<GoalNotifier>(context);

    List<Task> goalCurrentTasks = [];
    List<Task> goalFinishedTasks = [];
    if (goalNotifier.goalTasksStat == Status.notFetched) {
      goalNotifier.fetchTasksForGoal(goalId);
      goalNotifier.goalTasksStat = Status.fetched;
    }

    Goal goal = goalNotifier.getGoal(goalId);
    if (goal.id == null) {
      goalNotifier.goalTasksStat = Status.notFetched;
    }
    print(goal.id);
    print('name: ${goal.name}');

    if (goal.name != "No goals found") {
      goalCurrentTasks = goalNotifier.getTasksByType(GoalType.current);
      goalFinishedTasks = goalNotifier.getTasksByType(GoalType.finished);
    }

    Widget currentExpantionTaskTiles = createExpantionTile(
        "Current Tasks",
        goalCurrentTasks,
        goalCurrentTasks.length,
        false,
        true,
        goalId,
        context);
    Widget finishedExpantionTaskTiles = createExpantionTile(
        "Finished Tasks",
        goalFinishedTasks,
        goalFinishedTasks.length,
        true,
        false,
        goalId,
        context);

    onDelete() {
      goalNotifier.deleteGoalWithId(goal.id!);
      Navigator.pop(context);
      //print('after poping the screen...');
    }

    onFinish() {
      Goal newGoal = goal.copy(
        finishedDate: DateFormat('dd/MM/yy').format(DateTime.now()).toString(),
        completed: true,
        numOfTasks: goalFinishedTasks.length,
      );
      goalNotifier.moveGoalToFinished(newGoal);
      Provider.of<FinishedGoalsNotifier>(context, listen: false)
          .addGoal(newGoal);
      Navigator.pop(context);
    }

    void startAddNewTask(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return AddOrEditTask(
              goalId: goalId,
              isAdd: true,
            );
          });
    }

    GoalDialoges dialoges = GoalDialoges();

    Future _editNameDialog() async {
      goalNotifier.editGoalTitle(
          await dialoges.showEditDialog(context, goal.name), goalId);
    }

    onEdit() {
      _editNameDialog();
    }

    Widget header = Column(
      children: [
        GoalHeader(
          goalTitle: goal.name,
          onEdit: () => onEdit,
          onDelete: () => onDelete(),
          goalid: goalId,
        ),
        SizedBox(
          height: 20,
        ),
        MyProgressIndecator(
          value: goalNotifier.progressValues[goal.id] ?? 0,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );

    Widget loading = Center(
      child: SpinKitCircle(
        color: Theme.of(context).primaryColor,
      ),
    );

    Widget body = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header,
            Container(
              alignment: Alignment.centerRight,
              //width: 110,
              child: TextButton(
                onPressed: () {
                  if (goalCurrentTasks.isEmpty &&
                      goalFinishedTasks.isNotEmpty) {
                    dialoges.showFinishDialog(context, onFinish);
                  } else {
                    dialoges.showConfermationDialog(
                        context,
                        "You didn't finished All the current Tasks. Are you sure you Want to delete this Goal?",
                        onDelete);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/finish.png',
                        ),
                      ),
                    ),
                    Text(
                      'Finish',
                      style: TextStyle(
                        color: Colors.orangeAccent[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            currentExpantionTaskTiles,
            finishedExpantionTaskTiles,
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Goals"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            goalNotifier.currentGoalTasks = [];
            goalNotifier.goalTasksStat = Status.notFetched;
            Navigator.pop(context);
          },
        ),
      ),
      body: goalNotifier.goalTasksStat == Status.notFetched ? loading : body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTask(context),
        heroTag: null,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> mapToTiles(List<Task> tasks, int goalId) {
    return tasks
        .map((_task) => TaskTile(
              id: _task.id!,
              title: _task.name,
              subTitle: _task.value,
              isForGoal: true,
              goalid: goalId,
            ))
        .toList();
  }

  List<Widget> mapToNoneSlidableTiles(List<Task> tasks, BuildContext context) {
    return tasks.map((_task) => FinishedTaskTile(task: _task)).toList();
  }

  Widget createExpantionTile(String title, List<Task> tasks, int listLength,
      bool finished, bool initiallyExpanded, int goalId, BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      initiallyExpanded: initiallyExpanded,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: listLength,
          itemBuilder: (context, index) {
            if (finished) {
              return mapToNoneSlidableTiles(tasks, context)[index];
            } else {
              return mapToTiles(tasks, goalId)[index];
            }
          },
        ),
      ],
    );
  }
}
