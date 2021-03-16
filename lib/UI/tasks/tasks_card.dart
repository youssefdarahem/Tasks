import 'package:flutter/material.dart';

class TasksCard extends StatelessWidget {
  final String header;
  final String body;

  TasksCard(this.header, this.body);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 80),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(header),
              SizedBox(
                height: 10,
              ),
              Text(body)
            ],
          ),
        ),
      ),
    );
  }
}
