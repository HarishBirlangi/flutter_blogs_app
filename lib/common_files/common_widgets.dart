import 'package:flutter/material.dart';

class CommonWidgets {
  Future alertDialogue(BuildContext context, String title, String description) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: [Text(description)],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                return Navigator.pop(context);
              },
              child: const Text('Ok'))
        ],
      ),
    );
  }
}
