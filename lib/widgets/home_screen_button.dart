import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  HomeScreenButton({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      child: Text(
        text,
        style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
      ),
      onPressed: onPressed,
    );
  }
}
