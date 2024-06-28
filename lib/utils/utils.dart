import 'package:flutter/material.dart';

/// Displays a snackbar with the given [text] in the provided [context].
///
/// The [context] parameter is used to access the ScaffoldMessenger to show the snackbar.
/// The [text] parameter is the message to be displayed in the snackbar.
///
/// Example usage:
/// ```dart
/// showSnackBar(context, 'Hello, World!');
/// ```
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
