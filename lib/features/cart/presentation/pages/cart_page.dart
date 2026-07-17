import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Classic Wagyu Burger',
      'size': 'Medium',
      'price': 18.50,
      'quantity': 1,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAx7qWbnrecqMf0mtjbBV2gDGNE1UOG64xVzoMaP4chs4dhIBFXP7ef1cwqGDGayjkqEs9F5HJd2C0K7SCV-65WMENqCCOuTx2SrYCBIFO4wkq7cxRu6Ka9egABUZI0XbptOiAYAwchlUVHqD9lyyjLf2FqrFh0sEfD-pQRWEs5fNZlNs1InBYgAw9aJ6HvP5T6E41qQ0EVzTj2W1EZLwRw98VcPzk-Vc2C2q3HVf2VoB8xC-Fse08s7q1iWJWGN2F14a_PgDdf6_BJ',
    },
    {
      'name': 'Signature Lava Delight',
      'size': 'Standard',
      'price': 9.50,
      'quantity': 2,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDLvTwhucmZgHjg3i4xW3WEiuTUstjDYpNIAWV7P834zrRA571PVrSMKQ5dy6sXHbaq0pajIXyZDdUbfGssfD2RJp1yuL7cuTQfJpkGwZpMKMjs6o-MYCyclqyROYPRaJSPYJdc48VDCM0KToJll4RILQfxkmWe3tqn47Mm-5Io2AkZ2qBkRxZDbzOrYVEtYoG3N2opYVVAdT5cMotfHCTo8a_Hj_rbzbrM7vuvwAvmx3IHgqd5uGLULnru20S28hm5rIxBi6CsoCb6',
    },
  ];

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  double get deliveryFee => 3.50;
  double get tax => subtotal * 0.08;
  double get total => subtotal + deliveryFee + tax;

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
          'Shopping Cart',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // List of cart items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _buildCartItemCard(item, index),
                      );
                    },
                  ),
                ),

                // Calculation breakdown panel
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
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
                    children: [
                      _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                      8.height,
                      _buildSummaryRow('Delivery Fee', '\$${deliveryFee.toStringAsFixed(2)}'),
                      8.height,
                      _buildSummaryRow('Tax (8%)', '\$${tax.toStringAsFixed(2)}'),
                      16.height,
                      const Divider(color: AppColors.outlineVariant),
                      16.height,
                      _buildSummaryRow(
                        'Total',
                        '\$${total.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                      24.height,
                      CommonButton(
                        text: 'Proceed to Checkout',
                        onPressed: () => context.go(AppRoutes.checkout),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.shopping_basket_outlined,
              color: AppColors.primary,
              size: 72,
            ),
          ),
          24.height,
          Text(
            'Your Cart is Empty',
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          8.height,
          Text(
            'Add items from your favorite restaurants',
            style: AppTextStyles.bodyMedium,
          ),
          24.height,
          CommonButton(
            width: 200,
            text: 'Browse Menu',
            onPressed: () => context.go(AppRoutes.home),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(Map<String, dynamic> item, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 72,
              height: 72,
              child: CommonCachedNetworkImage(
                imageUrl: item['imageUrl'],
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
                  item['name'],
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.height,
                Text(
                  'Size: ${item['size']}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                8.height,
                Text(
                  '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          16.width,

          // Quantity Adjuster
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 20),
                onPressed: () {
                  setState(() {
                    item['quantity']++;
                  });
                },
              ),
              Text(
                '${item['quantity']}',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: AppColors.primary, size: 20),
                onPressed: () {
                  setState(() {
                    if (item['quantity'] > 1) {
                      item['quantity']--;
                    } else {
                      cartItems.removeAt(index);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
              : AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              : AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
