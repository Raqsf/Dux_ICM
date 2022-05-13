import 'package:flutter/material.dart';

import '../constants/assets_path.dart';

Future<bool?> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String actionName,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(/* AppLocalizations.of(context)!. */ "cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(actionName),
        ),
      ],
    ),
  );
}
