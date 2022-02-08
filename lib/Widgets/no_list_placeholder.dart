import 'package:flutter/material.dart';

class NoListPlaceholder extends StatelessWidget {
  final String imagePath;
  final String text;

  NoListPlaceholder({required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 150,
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                imagePath,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
