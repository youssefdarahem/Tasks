import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Models/goal.dart';
import 'package:tasks/Screens/main_screen.dart';
import 'package:tasks/Widgets/add_or_edit_task.dart';
import 'package:tasks/Widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  void startAddNewTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return AddOrEditTask(
            goalId: -1,
            isAdd: true,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    print('homePage is building....');
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);
    GoalNotifier goalNotifier =
        Provider.of<GoalNotifier>(context, listen: false);
    Widget currentScreen = Center(
      child: SpinKitCubeGrid(
        color: Colors.lightBlueAccent[100],
      ),
    );
    PreferredSizeWidget appBar = AppBar(
      centerTitle: true,
      title: const Text(
        "Tasks & Goals",
      ),
    );

    double taskWidgetHight = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        0.7;
    double goalWidgetHight = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        0.3;

    if (taskNotifier.generalStatus == GeneralStatus.connectingToDB) {
      taskNotifier.connectToDb();
    }

    switch (taskNotifier.generalStatus) {
      case GeneralStatus.connectingToDB:
        currentScreen = Center(
          child: SpinKitCircle(
            color: Colors.lightBlueAccent[100],
          ),
        );
        break;

      case GeneralStatus.connected:
        currentScreen = MainScreen(
          taskWidgetHeight: taskWidgetHight,
          goalWidgetHeight: goalWidgetHight,
        );
        break;
    }

    return Scaffold(
      appBar: appBar,
      body: currentScreen,
      drawer: AppDrawer(),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        iconTheme: IconThemeData(size: 35),
        activeIcon: Icons.close,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add_task_sharp),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: "add Task",
            labelBackgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.white),
            onTap: () {
              startAddNewTask(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            labelStyle: TextStyle(color: Colors.white),
            foregroundColor: Colors.white,
            labelBackgroundColor: Theme.of(context).colorScheme.secondary,
            label: "add goal",
            onTap: () {
              print(DateFormat('dd/MM/yy').format(DateTime.now()).toString());
              goalNotifier.addGoal(
                Goal(
                  name: "New Goal",
                  completed: false,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
