import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';
import 'package:testy_food/core/widgets/animate_in.dart';

class Particle {
  double x; // percentage of screen width (0.0 to 1.0)
  double y; // percentage of screen height (0.0 to 1.0)
  double size;
  Color color;
  double speed;
  double wobbleSpeed;
  double wobbleRange;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
    required this.wobbleSpeed,
    required this.wobbleRange,
  });
}

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> with TickerProviderStateMixin {
  late final AnimationController _badgeController;
  late final AnimationController _particlesController;
  late final List<Particle> _particles;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _particlesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _particles = List.generate(25, (index) => _generateRandomParticle(true));

    // Play animations
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _badgeController.forward();
        HapticFeedback.mediumImpact();
      }
    });
  }

  Particle _generateRandomParticle(bool randomY) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.primaryContainer,
      AppColors.secondaryContainer,
      Colors.amber,
      Colors.cyan,
      Colors.purpleAccent,
    ];
    return Particle(
      x: _random.nextDouble(),
      y: randomY ? _random.nextDouble() * 1.2 : 1.2,
      size: _random.nextDouble() * 6 + 5,
      color: colors[_random.nextInt(colors.length)].withValues(alpha: _random.nextDouble() * 0.4 + 0.4),
      speed: _random.nextDouble() * 0.08 + 0.04,
      wobbleSpeed: _random.nextDouble() * 3 + 1,
      wobbleRange: _random.nextDouble() * 12 + 4,
    );
  }

  @override
  void dispose() {
    _badgeController.dispose();
    _particlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.onSurface),
            onPressed: () => context.go(AppRoutes.home),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background celebratory particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particlesController,
              builder: (context, child) {
                for (final particle in _particles) {
                  particle.y -= particle.speed * 0.1;
                  if (particle.y < -0.1) {
                    final newP = _generateRandomParticle(false);
                    particle.x = newP.x;
                    particle.y = newP.y;
                    particle.size = newP.size;
                    particle.color = newP.color;
                    particle.speed = newP.speed;
                    particle.wobbleSpeed = newP.wobbleSpeed;
                    particle.wobbleRange = newP.wobbleRange;
                  }
                }
                return CustomPaint(
                  painter: _ParticlesPainter(
                    particles: _particles,
                    controllerValue: _particlesController.value,
                  ),
                );
              },
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Elastic badge entrance
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _badgeController,
                      curve: Curves.elasticOut,
                    ),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryContainer.withValues(alpha: 0.1),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 4,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 56,
                        ),
                      ),
                    ),
                  ),
                  32.height,

                  // Message
                  AnimateIn(
                    delay: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Text(
                          'Order Confirmed!',
                          style: AppTextStyles.headlineLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        12.height,
                        Text(
                          'Your payment was processed successfully. The kitchen is already whipping up your gourmet order!',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  32.height,

                  // Details card
                  AnimateIn(
                    delay: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSpacing.borderRadiusLG,
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow('Estimated Delivery', '20-30 Mins'),
                          12.height,
                          const Divider(color: AppColors.outlineVariant),
                          12.height,
                          _buildDetailRow('Order ID', '#FL-8490'),
                          12.height,
                          _buildDetailRow('Payment Mode', 'Credit Card'),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Bottom actions
                  AnimateIn(
                    delay: const Duration(milliseconds: 700),
                    child: Column(
                      children: [
                        CommonButton(
                          text: 'Track Order',
                          onPressed: () => context.go(AppRoutes.orderTracking),
                        ),
                        12.height,
                        TextButton(
                          onPressed: () => context.go(AppRoutes.home),
                          child: Text(
                            'Back to Home',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double controllerValue;

  _ParticlesPainter({required this.particles, required this.controllerValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      paint.color = p.color;
      final wobble = math.sin(controllerValue * 2 * math.pi * p.wobbleSpeed) * p.wobbleRange;
      final px = (p.x * size.width) + wobble;
      final py = p.y * size.height;
      if (p.size.toInt() % 2 == 0) {
        canvas.drawCircle(Offset(px, py), p.size / 2, paint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(px, py), width: p.size, height: p.size * 1.4),
            Radius.circular(p.size * 0.2),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) => true;
}
