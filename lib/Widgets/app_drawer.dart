import 'package:flutter/material.dart';

import 'package:tasks/Screens/finished_goals_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _createHeader(),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 35,
              color: Colors.orangeAccent[400],
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.headline1,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                'assets/images/finish.png',
              ),
              backgroundColor: Colors.transparent,
              radius: 18,
            ),
            title: Text('Finished Goals',
                style: Theme.of(context).textTheme.headline1),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, FinishedGoals.finishedGoalsPageRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/drawerbackground.jpg'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Tasks & Goals",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
