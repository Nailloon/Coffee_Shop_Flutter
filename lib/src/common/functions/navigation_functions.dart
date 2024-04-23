import 'package:flutter/material.dart';

void returnToPreviousScreen(BuildContext context) async {
  Navigator.pop(context);
}

void returnThroughNScreens(BuildContext context, int countOfScreens) async {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= countOfScreens);
}
