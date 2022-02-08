import 'package:flutter/material.dart';

class PreviewTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final int index;
  const PreviewTile({Key? key, required this.title, required this.subTitle,required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(index.toString()),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
