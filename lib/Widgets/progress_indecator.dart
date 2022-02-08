import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class MyProgressIndecator extends StatelessWidget {
  final double value;

  MyProgressIndecator({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: GradientProgressIndicator(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade100,
              Colors.purple.shade400,
            ],

          ),
          value: value,
          
        ),
      ),
    );
  }
}
