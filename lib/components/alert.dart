import 'package:flutter/material.dart';

showAlert({
  required BuildContext bContext,
  String? title,
  String? content,
}) {
  return showDialog(
    context: bContext,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title ?? "",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(content ?? ""), // Use empty string if null
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Ok"),
          ),
        ],
      );
    },
  );
}

