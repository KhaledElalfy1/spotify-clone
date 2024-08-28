import 'package:client/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      border: borderDecoration(),
      enabledBorder: borderDecoration(),
      focusedBorder: borderDecoration(),
      errorBorder: borderDecoration(color: AppColors.errorColor),
    ),
  );

  static OutlineInputBorder borderDecoration(
      {Color color = AppColors.borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
