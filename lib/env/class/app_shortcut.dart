import 'package:flutter/material.dart';

class AppShortcut {
  final ThemeData theme;
  final TextTheme text;
  final ColorScheme color;
  final MediaQueryData query;

  AppShortcut({
    required this.theme,
    required this.text,
    required this.color,
    required this.query,
  });

  factory AppShortcut.of(BuildContext context) {
    var theme = Theme.of(context);
    var text = theme.textTheme;
    var color = theme.colorScheme;
    var query = MediaQueryData.fromView(View.of(context));

    return AppShortcut(theme: theme, text: text, color: color, query: query);
  }
}
