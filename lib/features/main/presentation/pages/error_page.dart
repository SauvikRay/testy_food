import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  bool _isLoading = false;

  void _handleRetry() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        context.go(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Offline / Error Illustration Box
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryContainer.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.wifi_off_rounded,
                  color: AppColors.primary,
                  size: 64,
                ),
              ),
              32.height,

              // Heading
              Text(
                'Connection Lost',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.height,

              // Message details
              Text(
                'We couldn\'t load the gourmet menu. Please check your internet connection or try again shortly.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const Spacer(),

              // Action CTA
              CommonButton(
                text: 'Retry Connection',
                isLoading: _isLoading,
                onPressed: _handleRetry,
              ),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
}
