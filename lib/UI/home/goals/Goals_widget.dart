import 'package:flutter/material.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GoalsWidget extends StatelessWidget {
  const GoalsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<String> goals = ["Goal 1", "Goal 2", "Goal 3", "Goal 4", "Goal 5"];

    return Expanded(
      flex: 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,

        //physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            child: Card(
              child: Center(child: Text('Dummy Card Text')),
            ),
          );
        },
      ),
    );
  }
}

Widget goalCard(int id, String title) {
  return Container(
    width: 200,
    child: Card(
      child: Center(child: Text('Dummy Card Text')),
    ),
  );
}
