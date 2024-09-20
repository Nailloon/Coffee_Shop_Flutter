import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  cardTheme: const CardTheme(),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.realBlack),
    titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.realBlack),
    bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.25,
        color: AppColors.realBlack),
    bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.realBlack),
    bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.white),
    titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: AppColors.realBlack),
    labelMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.white),
    labelSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.white),
  ),
);
