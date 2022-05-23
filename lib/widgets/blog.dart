import 'package:flutter/material.dart';

class BlogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('this is a blog.',
            style: Theme.of(context).textTheme.bodyText1));
  }
}
