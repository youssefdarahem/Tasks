import 'package:flutter/material.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/UI/tasks/Tasks_ui.dart';
import 'package:tasks/UI/goals_ui.dart';
import 'package:tasks/UI/profile_ui.dart';
import 'package:tasks/UI/settings_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  creatInputDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                ),
                Row(
                  children: [
                    FlatButton(
                      onPressed: () {},
                      child: Text("close"),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text("Add"),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  int _currentIndex = 0;
  List<Widget> _mainPages = [
    Tasks(),
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
            title: Text("Tasks"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            title: Text("Goals"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
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
