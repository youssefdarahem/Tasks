import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/finishedGoalsNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Models/goal.dart';
import 'package:tasks/Widgets/app_drawer.dart';
import 'package:tasks/Widgets/finished_goal_card.dart';
import 'package:tasks/Widgets/no_list_placeholder.dart';
//import 'package:tasks/Widgets/loading_screen.dart';

class FinishedGoals extends StatelessWidget {
  static const finishedGoalsPageRoute = '/finished_page';
  final DateTime now = DateTime.now();
  //bool isInit = false;

  @override
  Widget build(BuildContext context) {
    FinishedGoalsNotifier finishedGoalsNotifier =
        Provider.of<FinishedGoalsNotifier>(context);
    //List<Goal> _goals = [];
    Status status = finishedGoalsNotifier.finishedGoalsStatus;
    // if (!isInit) {
    //   finishedGoalsNotifier.fetchFinishedGoals();
    //   isInit = true;
    // } else {
    //   _goals = finishedGoalsNotifier.finishedGoals;
    // }
    if (status == Status.notFetched) {
      finishedGoalsNotifier.fetchFinishedGoals();
    }

    final List<Goal> _goals = finishedGoalsNotifier.finishedGoals;

    Widget loading = Center(
      child: SpinKitCircle(
        color: Theme.of(context).primaryColor,
      ),
    );

    Widget body = Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: _goals.length,
        itemBuilder: (BuildContext ctx, index) {
          return FinishedGoalCard(
              id: _goals[index].id ?? -1,
              title: _goals[index].name,
              numOfFinishedTasks: _goals[index].numOfFinishedTasks ?? 0,
              finishedDate: _goals[index].finishedDate ?? 'Not avaliable');
        },
      ),
    );

    if (status == Status.fetched && _goals.isEmpty) {
      //if (isInit && _goals.isEmpty) {
      body = Center(
        child: NoListPlaceholder(
            imagePath: 'assets/images/goal.png',
            text: 'You didn\'t finish any goals yet !'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Finished Goals'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      //body: isInit ? body : loading,
      body: status == Status.notFetched ? loading : body,
    );
  }
}
