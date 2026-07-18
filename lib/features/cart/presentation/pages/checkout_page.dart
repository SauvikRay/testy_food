import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPayment = 'Credit Card';

  void _handlePlaceOrder() {
    context.go(AppRoutes.orderSuccess);
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
          onPressed: () => context.go(AppRoutes.cart),
        ),
        title: Text(
          'Checkout',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Delivery Address card
            _buildSectionHeader('Delivery Address'),
            12.height,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primary, size: 28),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alex Harrison',
                          style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                        4.height,
                        Text(
                          '123 Gourmet Blvd, Downtown, New York, NY 10001',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            28.height,

            // 2. Payment Method selection
            _buildSectionHeader('Payment Method'),
            12.height,
            Column(
              children: [
                _buildPaymentTile('Credit Card', Icons.credit_card),
                12.height,
                _buildPaymentTile('PayPal', Icons.paypal),
                12.height,
                _buildPaymentTile('Cash on Delivery', Icons.payments),
              ],
            ),
            28.height,

            // 3. Order summary card
            _buildSectionHeader('Order Summary'),
            12.height,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Column(
                children: [
                  _buildSummaryItem('Classic Wagyu Burger', '1x', '\$18.50'),
                  8.height,
                  _buildSummaryItem('Signature Lava Delight', '2x', '\$19.00'),
                  12.height,
                  const Divider(color: AppColors.outlineVariant),
                  12.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payment',
                        style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$41.00',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.height,

            // 4. Place Order CTA Button
            CommonButton(
              text: 'Place Order • \$41.00',
              onPressed: _handlePlaceOrder,
            ),
            24.height,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.headlineSmall.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPaymentTile(String name, IconData icon) {
    final active = _selectedPayment == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppSpacing.borderRadiusLG,
          border: Border.all(
            color: active ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: active ? AppColors.primary : AppColors.outline, size: 24),
            16.width,
            Text(
              name,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (active)
              const Icon(Icons.check_circle, color: AppColors.primary, size: 20)
            else
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.outline, width: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String name, String qty, String price) {
    return Row(
      children: [
        Text(
          qty,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        12.width,
        Expanded(
          child: Text(
            name,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Text(
          price,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
