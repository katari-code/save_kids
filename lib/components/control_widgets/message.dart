import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class Message {
  final String input;
  final BuildContext context;
  final Color color;
  Message({this.input, this.color, this.context});

  void displayMessage() {
    final snackbar = SnackBar(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        content: Text(
          input,
          style: kBubblegum_sans24.copyWith(color: Colors.white),
        ),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
