import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/animate_in.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final List<Map<String, dynamic>> offersList = [
    {
      'code': 'WELCOME50',
      'discount': '50% OFF',
      'title': 'Welcome Discount',
      'description': 'Applicable on your first gourmet order from selected restaurants.',
      'expiry': 'Expires in 3 days',
      'copied': false,
    },
    {
      'code': 'FREEFOOD',
      'discount': 'FREE DELIVERY',
      'title': 'Midweek Treat',
      'description': 'Get free delivery on orders above \$30.00 this Wednesday.',
      'expiry': 'Expires in 1 day',
      'copied': false,
    },
    {
      'code': 'TRUFFLELOVE',
      'discount': '20% OFF',
      'title': 'European Delights',
      'description': 'Enjoy discounts at European and Italian partners.',
      'expiry': 'Expires in 5 days',
      'copied': false,
    },
  ];

  void _copyToClipboard(int index, String code) {
    Clipboard.setData(ClipboardData(text: code));
    setState(() {
      offersList[index]['copied'] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Promo code "$code" copied to clipboard!'),
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          offersList[index]['copied'] = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: Text(
          'Promos & Offers',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offersList.length,
        itemBuilder: (context, index) {
          final offer = offersList[index];
          final isCopied = offer['copied'] as bool;
          return AnimateIn(
            delay: Duration(milliseconds: 80 * index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ticket Cutout Look Left side
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.confirmation_num_outlined, color: AppColors.primary, size: 28),
                        8.height,
                        Text(
                          offer['discount'],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.width,
    
                  // Content Details right side
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer['title'],
                          style: AppTextStyles.labelLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        4.height,
                        Text(
                          offer['description'],
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        12.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              offer['expiry'],
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // Copy Promo Code Badge button
                            GestureDetector(
                              onTap: () => _copyToClipboard(index, offer['code']),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isCopied
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : AppColors.primaryFixed,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isCopied ? Colors.green : AppColors.primary,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  isCopied ? 'Copied!' : offer['code'],
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: isCopied ? Colors.green : AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
