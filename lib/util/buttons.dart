import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback callback;

  MyButton({
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: callback,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}
