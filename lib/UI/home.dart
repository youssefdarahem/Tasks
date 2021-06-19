import 'package:flutter/material.dart';

import 'package:tasks/UI/tasks/Tasks_page.dart';
import 'package:tasks/UI/goals_ui.dart';
import 'package:tasks/UI/profile_ui.dart';
import 'package:tasks/UI/settings_ui.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _currentIndex = 0;
  List<Widget> _mainPages = [
    TasksPage(),
    Goals(),
    Profile(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: _mainPages[_currentIndex],

      // body: ListView.builder(
      //     itemCount: tasks.length,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Card(
      //           child: ListTile(
      //             title: Text(tasks[index].name),
      //             subtitle: Text(tasks[index].value),
      //           ),
      //         ),
      //       );
      //     }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     creatInputDialoge(context);
      //   },
      //   child: Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: "Tasks",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Goals",
            
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
