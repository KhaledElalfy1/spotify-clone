import 'package:client/core/utils/app_colors.dart';
import 'package:client/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.gradient1,
              AppColors.gradient2,
              // AppColors.gradient3,
            ],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: AppFonts.regular18White,
        ),
      ),
    );
  }
}
