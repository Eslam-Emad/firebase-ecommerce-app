import 'package:flutter/material.dart';

class Alert {
  static showAlertDialog(
      {BuildContext context, String content, String title, bool isError}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Error"),
              content: Text(content.toString() ?? 'there is something wrong'),
              scrollable: true,
              actions: [
                FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  static showSnackBar(
      {BuildContext context,
      String content,
      GlobalKey<ScaffoldState> key,
      bool isError}) {
    return key.currentState.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}
