import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/animate_in.dart';
import 'package:testy_food/core/widgets/common_button.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<Map<String, dynamic>> paymentCards = [
    {
      'holder': 'Alex Harrison',
      'number': '•••• •••• •••• 8490',
      'expiry': '09/29',
      'type': 'Visa',
      'color': const Color(0xFF1E1E2C),
      'isDefault': true,
    },
    {
      'holder': 'Alex Harrison',
      'number': '•••• •••• •••• 7301',
      'expiry': '12/28',
      'type': 'Mastercard',
      'color': const Color(0xFF4B1A3F),
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.profile);
            }
          },
        ),
        title: Text(
          'Payment Methods',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: paymentCards.length,
              itemBuilder: (context, index) {
                final card = paymentCards[index];
          return AnimateIn(
            delay: Duration(milliseconds: 80 * index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                color: card['color'] as Color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (card['color'] as Color).withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card['type'],
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      if (card['isDefault'])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Primary',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
    
                  // Number
                  Text(
                    card['number'],
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                  ),
    
                  // Footer Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CARD HOLDER',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white54,
                              fontSize: 9,
                            ),
                          ),
                          4.height,
                          Text(
                            card['holder'],
                            style: AppTextStyles.labelLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EXPIRES',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white54,
                              fontSize: 9,
                            ),
                          ),
                          4.height,
                          Text(
                            card['expiry'],
                            style: AppTextStyles.labelLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonButton(
              text: 'Add New Card',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
