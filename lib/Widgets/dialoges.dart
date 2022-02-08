import 'package:flutter/material.dart';

class GoalDialoges {
  //final Function onDelete;

  //GoalDialoges({required this.onDelete});

  Future<String> showEditDialog(BuildContext context, String oldTitle) async {
    String? newGoalTilte = await showDialog(
        context: context,
        builder: (BuildContext context) {
          final TextEditingController goalTitleController =
              TextEditingController();
          goalTitleController.text = oldTitle;
          return SimpleDialog(
            title: const Text("Edit Goal Title"),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: TextField(
                    controller: goalTitleController,
                    maxLength: 30,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, goalTitleController.text.toString());
                },
                child: Text("Save"),
              )
            ],
          );
        });
    if (newGoalTilte == null) {
      newGoalTilte = 'null';
    }

    return newGoalTilte;
  }

  void showFinishDialog(BuildContext context, Function onFinish) {
    Widget okButton = TextButton(
      child: Text("Finish"),
      onPressed: () {
        Navigator.pop(context);
        onFinish();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Congrates",
      ),
      content: Text(
        "congratulations you completed your Goal.",
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> showConfermationDialog(BuildContext context, String lead, Function onDelete) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Delete Goal"),
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Text(
                    "$lead",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      onDelete();
                    },
                    child: const Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("No"),
                  ),
                ],
              )
            ],
          );
        });
  }
}
