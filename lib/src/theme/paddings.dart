import 'package:flutter/material.dart';

sealed class OurPaddings {
  static const screenPadding = EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0);
  static const betweenRightPadding = EdgeInsets.only(right: 8.0);
  static const columnPadding = EdgeInsets.only(bottom: 12.0);
  static const smallCardPadding = EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0);
}