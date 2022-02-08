import 'package:flutter/material.dart';
import 'package:tasks/Widgets/dialoges.dart';

class GoalHeader extends StatelessWidget {
  final String goalTitle;
  final Function onEdit;
  final Function onDelete;

  final int goalid;

  const GoalHeader({
    required this.goalTitle,
    required this.onEdit,
    required this.onDelete,
    required this.goalid,
  });

  @override
  Widget build(BuildContext context) {
    GoalDialoges dialoges = GoalDialoges();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: onEdit(),
            child: Text(
              goalTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () => dialoges.showConfermationDialog(
              context, "Are you sure ?", onDelete),
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
