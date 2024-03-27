import 'package:flutter/material.dart';

showSnackbar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        content: Text(
          content,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontSize: 16,
          ),
        ),
      ),
    );
}
