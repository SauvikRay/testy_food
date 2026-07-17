import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';
import 'package:testy_food/core/widgets/common_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  void _skip() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Atmospheric Blobs
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Main Layout
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 64),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _buildPage1(),
                    _buildPage2(),
                    _buildPage3(),
                  ],
                ),
              ),
              _buildBottomBar(),
            ],
          ),

          // Top Header (Skip / Title)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                            ),
                            child: const Icon(
                              Icons.chevron_left,
                              color: AppColors.onSurface,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              padding: AppSpacing.edgeXS,
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer.withValues(alpha: 0.2),
                                borderRadius: AppSpacing.borderRadiusDefault,
                              ),
                              child: const Icon(
                                Icons.electric_moped,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            8.width,
                            Text(
                              'FlashDash',
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                  if (_currentPage < 2)
                    TextButton(
                      onPressed: _skip,
                      child: Text(
                        'Skip',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
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

  // Page 1: Fresh Food Delivered Fast
  Widget _buildPage1() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final floatOffset = math.sin(_animationController.value * 2 * math.pi) * 12.0;
                return Transform.translate(
                  offset: Offset(0, floatOffset),
                  child: Container(
                    width: 280,
                    height: 280,
                    margin: const EdgeInsets.only(top: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppSpacing.borderRadiusXL,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: AppSpacing.borderRadiusXL,
                              child: const CommonCachedNetworkImage(
                                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCIeQEEtyJKFl8E2AwTP4hUtQX8uPOIhoi_W8FjqIM0uL85epds_s6qR7-GQotEf5Ul8lIqOelwS5VMlIWYxxhTa0LmmWf1oIGhemmRiyPsmxBbub2zKCnxX_Rrxm9WhvfVR3TtMJZ70kaV09VXWJJyDdwkuP-gUemozF4z7WceRa9mNEPJ3MnJzqtpzz5NxWdZun5Lf_CHIKWxxcdDyabN31P4aJWkSLYR8gO0-BgBBpaqdAntaBP8D09KLgMgLWhqo1DtOQ__Z6SV',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -16,
                          right: -16,
                          child: Container(
                            padding: AppSpacing.edgeMD,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppSpacing.borderRadiusLG,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.tertiaryContainer,
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: AppColors.onTertiaryContainer,
                                    size: 18,
                                  ),
                                ),
                                8.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Status',
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      'Delivered Fast',
                                      style: AppTextStyles.labelMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: AppTextStyles.headlineLargeMobile,
                  children: [
                    TextSpan(text: 'Fresh Food '),
                    TextSpan(
                      text: 'Delivered Fast',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              16.height,
              Text(
                'Experience the luxury of premium meals from the best city restaurants, delivered to your doorstep in minutes.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 2: Track Orders in Real Time
  Widget _buildPage2() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 380,
                  margin: const EdgeInsets.only(top: 20),
                  child: const Opacity(
                    opacity: 0.5,
                    child: CommonCachedNetworkImage(
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB47TTrQ1efwTp_x4hnMcqyEKNJQcdJz1PZ9_iiRi2V_23PsRpUkjG2svfHDhSdWCZrK_7cDUZ7VGDGNOw8nrAnMWTzgLmP3kHwJli74Kv_1vL1G7XZJzSmX6rXCL0sBcuOkA_oYHftmzeMkSGBPh_lCgffBrRUSn0KsB-3yWLICC3949b6GMVf8iGgxYP0SQKZnsgXyjOJgdQgZHfxoXcHFMdDloZLUa15LT0bVHJTwfREfFztJTyqPy671917aUNTwuP2ol8n_mqr',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CustomPaint(
                  size: const Size(double.infinity, 380),
                  painter: _RoutePainter(),
                ),
                const Positioned(
                  top: 100,
                  left: 80,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.onSurface,
                    child: Icon(Icons.home, color: Colors.white, size: 18),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 100,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final val = _animationController.value;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 24 + (val * 32),
                            height: 24 + (val * 32),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryContainer.withValues(alpha: 1 - val),
                            ),
                          ),
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.electric_moped,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final floatOffset = math.sin(_animationController.value * 2 * math.pi) * 8.0;
                    return Positioned(
                      top: 120,
                      right: 40,
                      child: Transform.translate(
                        offset: Offset(0, floatOffset),
                        child: Container(
                          padding: AppSpacing.edgeSM,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppSpacing.borderRadiusLG,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            border: Border.all(
                              color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primaryFixed,
                                    width: 2,
                                  ),
                                  image: const DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBrWqZh2S5zTKdfsx0wxV47pH1SHH8hYau2ixXSt8ZKdwytZDozKihim2bkLvByPoVfA6P5y6-BfDoEWfsE-qROreHpxlnDze3rUa5dd_SAq3pLyG_BX9GrHdY5sIuYfVGNlXur_NmG-5CUapHBN9_MJDYLVnilT8wbFtscyjbeuQulx__IoJQyqdqZj2-O7ivjdiTNhrhUUJhD_RITzYwzhq8YMjwH7Wje0sz5EqAseJYx5SFprgq5zDsrPP4nEhlBu5AyF18Teivz',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              8.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Marco is nearby',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                  Text(
                                    'Arrival in 4 mins',
                                    style: AppTextStyles.labelSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: AppTextStyles.headlineLargeMobile,
                  children: [
                    TextSpan(text: 'Track Orders in '),
                    TextSpan(
                      text: 'Real Time',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              16.height,
              Text(
                "Watch your meal make its journey to your door. From kitchen to doorbell, you're always in the loop.",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 3: Thousands of Restaurants
  Widget _buildPage3() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              height: 380,
              margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: Row(
                children: [
                  // Left side
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildBentoCard(
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA_DhVp9zQwd_euE6Pk-e8PimKBAF7Je7WUEfct24i0Kvbp6oolz8VTLMLPcmNGME3ZDqB2xbBg9ptuUWFjfl_-n0lRZXq3pNjTPgat0p5SjGJjOh3RRwoRjh9ULJb3DOIpG58o4xiOpgpAdXOa_l2wMAfN2-6EU_ZJSqKsW4es6JDKDZe16JMh1L0uOrGkhjFziThgeBzZvaJFZtVGWoqwehmeWcZ51nNDhyenzcdDGKtH8NWviOr7Lwc-UHO8nxIP6zHZ5bFSqBOo',
                            label: 'Japanese Cuisine',
                          ),
                        ),
                        8.height,
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildBentoCard(
                                  imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDkmvwOBluTpQXvOtOHF19yJQGfUqgLD02UxMykxh9Z27AdXSEY6R_Dsnxf8lU_1dvKi32zNUiPxF15DfGWHVEcAXNIl3tKU8C3OqmIxfj_zzj_yrdFX2gVDIzeZrwlW7_FfszaUBtdhGGPYyCkWwk6OmcE4NO486cv01z4WcDhHTJ1KZk0s2LgxiH3LiQ-NS3ik-NEGTP6GS2lQt2vbB0uvCzGO3gLtv9M_KOhAX4aR954uontQ50A07eCVj_SEvWqB2PCahoH60Zv',
                                ),
                              ),
                              8.width,
                              Expanded(
                                child: _buildBentoCard(
                                  imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA7h9kfXF-ozjKo4UsD3JYAVfYHQjzGvVCQbdnuOfVp18Ulw9pL9rU57cgEw8CM_aC_MmNuOjBagWT2VQWWzh6mo9yg4mDf3XpwEDFrXFv1Ovq0H9Si_m9EejWzk0x63br9iZ2koFghoVOnjox46A6URLTx2DAs_12Bcf6ZZB32COowyfVePRylfUtiM2uFVWIUJ1hYo8NcP8rfYkk7qx3Sdn05UUOHvO_Tw9QNNcJsvNK3c67qeSGeUCaP94TFFSRnAQ8HDfy2i2Y6',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.width,
                  // Right side
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildBentoCard(
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDAcKmWZHzI8TX7idMTkjiv_PGpUolNa8Xn_p-0Fs09_CkKGq_JUCR-Z_2sFyRz1OVU2pM1ZlbaBaYl7VFdbMQRZNIrrtQUFteqBykSdeCbBUnvoaP6PVFGyqkabA-jwokaSY0i-19hTRrZmM1MXGTzpjzyDDlz3MUN7QUYGlRMuEgFo7Ff-VboRKQ3lS1khBwVHS4b1ctHkRyQh2r79MgoQqMdpOVt5xipdtU_yZvwujdOrD9dIeivZRzAnao2tG2FlWEHzJinFOWN',
                          ),
                        ),
                        8.height,
                        Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: AppSpacing.borderRadiusLG,
                          ),
                          child: const Icon(
                            Icons.ramen_dining,
                            color: AppColors.onPrimaryContainer,
                            size: 28,
                          ),
                        ),
                        8.height,
                        Expanded(
                          flex: 2,
                          child: _buildBentoCard(
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCwN1af7jN5iAQatZ9hzBhjX1PU2UzjJGl8ay4WKnhzTR_UXSu3JfU0TtDl3Z3s24---wVUK71duQ5NImoZR35fvLkWHT_r1o4Gfr_maMAKNveFFYAJ45OLolsyqKAQ97RiQcW2B5rzlikWHNmkvNe0iEDayG4bshnan1I-GFHXqdgafoA9JDqrGxbNBfqGf0GabD0L2MFotO6tlHAg9ddxQR1NXder5SGvGs5WNTJHVtBVnsqCYdQn1i7oo93z-4FIkRm-2OPpIZO8',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: AppTextStyles.headlineLargeMobile,
                  children: [
                    TextSpan(text: 'Thousands of '),
                    TextSpan(
                      text: 'Restaurants',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              16.height,
              Text(
                'Explore an endless variety of your favorite cuisines from top-rated local kitchens delivered to your door.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBentoCard({required String imageUrl, String? label}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppSpacing.borderRadiusLG,
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: label != null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: AppSpacing.borderRadiusLG,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(12),
              child: Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }

  // Common Bottom Action & Indicators
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final active = _currentPage == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 24.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: active ? AppColors.primary : AppColors.outlineVariant,
                ),
              );
            }),
          ),
          32.height,
          CommonButton(
            text: _currentPage == 2 ? 'Get Started' : 'Continue',
            onPressed: _nextPage,
          ),
          if (_currentPage == 2) ...[
            12.height,
            TextButton(
              onPressed: _skip,
              child: Text(
                'Already have an account? Log In',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ] else
            48.height,
        ],
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.25, size.height * 0.42)
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.35,
        size.width * 0.72,
        size.height * 0.6,
      );

    const dashWidth = 8.0;
    const dashSpace = 6.0;
    double distance = 0.0;
    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
