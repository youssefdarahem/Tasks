import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import 'package:tasks/UI/add_tasks_goals/add_page.dart';



import 'UI/home/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskNotifier(),
        ),
        
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add_task_page': (context) => AddPage(),
      },
    );
  }
}
