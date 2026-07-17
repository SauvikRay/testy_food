import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _floatController;
  late final AnimationController _pulseController;
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    // Fade in logo elements
    _logoController.forward();

    // Navigate to onboarding after 3.8 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryContainer,
              AppColors.primary,
              AppColors.secondary,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Pulsing Ambient Background Blobs
            // AnimatedBuilder(
            //   animation: _pulseController,
            //   builder: (context, child) {
            //     final val = _pulseController.value;
            //     return Stack(
            //       children: [
            //         Positioned(
            //           top: -size.height * 0.1,
            //           left: -size.width * 0.1,
            //           child: Opacity(
            //             opacity: 0.3 + (val * 0.1),
            //             child: Container(
            //               width: 300 + (val * 50),
            //               height: 300 + (val * 50),
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color: AppColors.primaryContainer.withValues(alpha: 0.5),
            //                 gradient: RadialGradient(
            //                   colors: [
            //                     Colors.white.withValues(alpha: 0.4),
            //                     Colors.transparent,
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Positioned(
            //           bottom: -size.height * 0.1,
            //           right: -size.width * 0.1,
            //           child: Opacity(
            //             opacity: 0.3 + (val * 0.1),
            //             child: Container(
            //               width: 300 + (val * 50),
            //               height: 300 + (val * 50),
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 gradient: RadialGradient(
            //                   colors: [
            //                     AppColors.secondaryContainer.withValues(alpha: 0.4),
            //                     Colors.transparent,
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // ),

            // Floating Food Illustration Cards
            _buildFloatingCard(
              top: size.height * 0.12,
              left: size.width * 0.08,
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDegeGxiAWiO4J0ns5cHEO6ZuVxZWmpOIyYR8s7RWr-Q4QyE2_IByctL1BJsXQVh6DaDAyE6-PTor89fAW_WHuPgyrhsZLU0O3vRMvd8dxJ4SG2n8IwcerFFjgOfQlFdtd2gbIxGUK55J7EniyAG8-kzLYG-ic_cFhLm5SliyJYXBCoKA7mmjlAeuIryyRsePEzKNiKX5C1hxRpmPhMVUaQ3l7Y3Cb853DP9wQaKtnwiZCKmpHC7WPOXiZw9Vs-R8iRvCq8MTSi2Wu-',
              delay: 0,
              angle: 0.08,
            ),
            _buildFloatingCard(
              top: size.height * 0.22,
              right: size.width * 0.08,
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCYIvgD4IBZqk5kU6V3Q4nPvsGY_zyN3_kmlDU4vICRIuwa7a811c_zjpPfOL3N8dpHnwQOqWGVeAHk8sF15HKVSq3A5Ydqkwm06Jqtm3Us4UKGg23ascl4lAjCXhFKz684_d3JYE69oV9Icg9Zf93uoJrG_-gawx_qyY-cBiRHx2Z2t7UdM3f9q5w71Or-GMpYCwTe7LQ3qNOwKxbnoA-y2bZBNI17MsOE1nHpQfXRUuA6-6YtWe4Z3bQ_ph3knYl3oYsCsvzsslHs',
              delay: 1.0,
              angle: -0.05,
            ),
            _buildFloatingCard(
              bottom: size.height * 0.22,
              left: size.width * 0.12,
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDEHPTLMnxA_u9H23A57lMGGoptdLrIMJiqelPhXVoWaMdzehSzYS861HojDkGo24Dw8B12wwz1Tv3wVAecmfabvVHVyeih9FFWmba001wpMmOR_KvrcCbLj3s-fXnx_W4ecdJ0LhqUo7adckDLM2u3JQB2HlmAaZEHphEN2NMMEbJozSE6BjcAnSU32LXHizeUihLLkEHriH4kXJ0tReUoMJvszILv_r-fKt9QX6yH5gzVHF2UWm0C0OUztye_v0LXGEoKzIWvwMkd',
              delay: 1.5,
              angle: -0.08,
            ),
            _buildFloatingCard(
              bottom: size.height * 0.14,
              right: size.width * 0.12,
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBMuHxkv8vU5y0ns_7Wlc5WGMuD2urWtSMABZ-1dneRdIb2xcDrdmtBVwwkQnCUudg0LLGbuIsoKC2xInpFP3BFembABrIEzyPut4s7uyrBAdjU6lB2Xgt1yhzLzOHT2Z8-WkV782A1Iuni9kL5qlgHppAn9SVFs6hagZVoQKYMNWEPsu8br6WuCTf5x2a9wew9P-chz8lMxHGTxzyckhiHQP5eneDUjblPUY-duvSF-el_RXZPqF7zIAepxTXMbNfClwbn4Np7i7eS',
              delay: 2.0,
              angle: 0.05,
            ),

            // Central Canvas
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _logoController,
                      curve: Curves.elasticOut,
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        color: AppColors.primary,
                        size: 48,
                      ),
                    ),
                  ),
                  32.height,

                  // Brand Name & Subtitle Fade In
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _logoController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
                    ),
                    child: Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: AppTextStyles.brandLogo,
                            children: [
                              TextSpan(text: 'DELISH'),
                              TextSpan(
                                text: 'DASH',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.height,
                        Text(
                          'Gourmet Dining, Delivered.',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white70,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.height,

                  // Progress Loading bar
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _logoController,
                      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 180,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  widthFactor: _progressController.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        8.height,
                        Text(
                          'Preparing your table'.toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.6),
                            letterSpacing: 2.0,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCard({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required String imageUrl,
    required double delay,
    required double angle,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          final sineVal = math.sin(
            (_floatController.value * 2 * math.pi) + delay,
          );
          final floatOffset = sineVal * 12.0;
          final slideOffset = (sineVal < 0 ? sineVal : 0.0) * 15.0;
          final angleOffset = angle + (sineVal < 0 ? sineVal * 0.15 : 0.0);

          return Transform.translate(
            offset: Offset(slideOffset, floatOffset),
            child: Transform.rotate(
              angle: angleOffset,
              child: Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CommonCachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      color: Colors.white24,
                      child: const Icon(Icons.fastfood, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
