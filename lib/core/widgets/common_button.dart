import 'package:flutter/material.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double width;
  final double height;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width = double.infinity,
    this.height = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    final themeBg = backgroundColor ?? AppColors.primary;
    final themeText = textColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: themeBg,
          foregroundColor: themeText,
          disabledBackgroundColor: themeBg.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: themeText,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: themeText,
                ),
              ),
      ),
    );
  }
}
