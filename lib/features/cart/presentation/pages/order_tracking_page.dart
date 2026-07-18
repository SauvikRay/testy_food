import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final int _activeStep = 2; // Default to "Out for Delivery" state for demonstration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: Text(
          'Track Order',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // 1. Simulated Interactive Map Card
          Expanded(
            child: Stack(
              children: [
                // Custom Painter Map Grid
                Container(
                  color: const Color(0xFFE3EDF7),
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomPaint(
                    painter: _MapGridPainter(),
                  ),
                ),

                // Pulsing scooter icon node
                Positioned(
                  left: 160,
                  top: 220,
                  child: _buildPulsingScooterNode(),
                ),

                // Destination/Home flag node
                Positioned(
                  right: 60,
                  bottom: 120,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Icon(Icons.home_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),

          // 2. Delivery Stepper & Driver details
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Driver card info
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuC1PIOMXv-lFDkpYRbegTrbmEububZ5yoR7gLG8WVWPHE1p8o5IHy_yRYRpMrRVnzdPMnrbRk9FB9pYSftLVO9BoffS4yBwYu4SQ2-xvpf2U50pYyJCNIuaqtDF9WLxeCr1-HzyAu2wjyGs_xsvoUvJq8e49pgSwU-77hVK1nydTxBgIRK_3Q0NCr-bG_8ABw_ZJhYlC3g74e4mjFfxp3cDK_v1w2zaegugB89QBNUYF9uvml4SqcmbHAqjKCMj_gaLyL5XlJTKulFa',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Marco Kelly',
                            style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                          ),
                          4.height,
                          Text(
                            'Delivery Agent • Honda Scooter',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone, color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
                20.height,
                const Divider(color: AppColors.outlineVariant),
                20.height,

                // Timeline status stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStepIndicator('Placed', _activeStep >= 0),
                    _buildStepIndicator('Kitchen', _activeStep >= 1),
                    _buildStepIndicator('Delivery', _activeStep >= 2),
                    _buildStepIndicator('Arrived', _activeStep >= 3),
                  ],
                ),
                28.height,

                // CTA action buttons
                CommonButton(
                  text: 'Review Delivery',
                  onPressed: () => context.go(AppRoutes.rateReview),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingScooterNode() {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.3),
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: const Icon(Icons.delivery_dining, color: Colors.white, size: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String name, bool completed) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: completed ? AppColors.primary : AppColors.outlineVariant,
          child: Icon(
            completed ? Icons.check : Icons.radio_button_unchecked,
            color: completed ? Colors.white : AppColors.outline,
            size: 14,
          ),
        ),
        8.height,
        Text(
          name,
          style: AppTextStyles.labelSmall.copyWith(
            fontWeight: completed ? FontWeight.bold : FontWeight.normal,
            color: completed ? AppColors.onSurface : AppColors.outline,
          ),
        ),
      ],
    );
  }
}

// Custom Painter mapping layout roads grid mockup
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintRoad = Paint()
      ..color = Colors.white
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final paintRoute = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.6)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Drawing roads
    final pathRoads = Path()
      ..moveTo(20, 80)
      ..lineTo(size.width - 20, 80)
      ..moveTo(80, 20)
      ..lineTo(80, size.height - 20)
      ..moveTo(160, 20)
      ..lineTo(160, size.height - 20)
      ..moveTo(20, 220)
      ..lineTo(size.width - 20, 220)
      ..moveTo(20, size.height - 120)
      ..lineTo(size.width - 20, size.height - 120);

    canvas.drawPath(pathRoads, paintRoad);

    // Active route pathway
    final pathActive = Path()
      ..moveTo(80, 80)
      ..lineTo(160, 80)
      ..lineTo(160, 220)
      ..lineTo(size.width - 60, 220)
      ..lineTo(size.width - 60, size.height - 120);

    canvas.drawPath(pathActive, paintRoute);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
