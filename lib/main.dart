import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/goalNotifier.dart';
import 'package:tasks/Bloc/privewGoalNotifier.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/Screens/finished_goals_screen.dart';
import 'package:tasks/Screens/preview_finished_goal.dart';
import 'Bloc/finishedGoalsNotifier.dart';
import 'Screens/goal_screen.dart';
import 'Screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoalNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => FinishedGoalsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreviewGoalNotifier(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks & Goals',
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'Quicksand',
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              fontSize: 15, color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              headline2: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              button: TextStyle(
                color: Colors.purple,
                //backgroundColor: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'OpenSans',
              ),
              bodyText2: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[400],
                fontSize: 18,
              ),
              bodyText1: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              subtitle1: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                color: Colors.purple,
                fontSize: 14,
              ),
            ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .bodyText2,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        GoalPage.goalPageRoute: (context) => GoalPage(),
        FinishedGoals.finishedGoalsPageRoute: (context) => FinishedGoals(),
        GoalPreview.finishedGoalPageRoute: (context) => GoalPreview(),
      },
    );
  }
}
