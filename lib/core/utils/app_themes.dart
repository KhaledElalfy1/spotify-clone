import 'package:client/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor:AppColors.backgroundColor, 
  );
}
