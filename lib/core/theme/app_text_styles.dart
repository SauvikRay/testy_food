import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle brandLogo = TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    color: Colors.white,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.64, // -0.02em
    color: AppColors.onSurface,
  );

  static const TextStyle headlineLargeMobile = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.28, // -0.01em
    color: AppColors.onSurface,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.24, // -0.01em
    color: AppColors.onSurface,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.14, // 0.01em
    color: AppColors.onSurface,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.24, // 0.02em
    color: AppColors.onSurface,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.33, // 0.03em
    color: AppColors.outline,
  );
}
