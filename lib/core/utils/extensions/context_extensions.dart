import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ScaffoldMessengerState get snackbar => ScaffoldMessenger.of(this);

  bool get isMobile => MediaQuery.of(this).size.shortestSide < 600;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenShortestSide => MediaQuery.of(this).size.shortestSide;
}
