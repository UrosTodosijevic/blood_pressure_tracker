import 'package:flutter/material.dart';

class NoEntriesMessage extends StatelessWidget {
  const NoEntriesMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'No Entries Yet',
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    );
  }
}
