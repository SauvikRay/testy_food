import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({super.key});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int _quantity = 1;
  String _selectedSize = 'Medium';
  final List<String> _selectedAddons = [];

  final List<Map<String, dynamic>> addonsList = [
    {'name': 'Extra Cheese', 'price': '\$1.50'},
    {'name': 'Avocado Slices', 'price': '\$2.00'},
    {'name': 'Smoked Bacon', 'price': '\$2.50'},
  ];

  void _toggleAddon(String name) {
    setState(() {
      if (_selectedAddons.contains(name)) {
        _selectedAddons.remove(name);
      } else {
        _selectedAddons.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Food cover image
                Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: const CommonCachedNetworkImage(
                        imageUrl:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuAx7qWbnrecqMf0mtjbBV2gDGNE1UOG64xVzoMaP4chs4dhIBFXP7ef1cwqGDGayjkqEs9F5HJd2C0K7SCV-65WMENqCCOuTx2SrYCBIFO4wkq7cxRu6Ka9egABUZI0XbptOiAYAwchlUVHqD9lyyjLf2FqrFh0sEfD-pQRWEs5fNZlNs1InBYgAw9aJ6HvP5T6E41qQ0EVzTj2W1EZLwRw98VcPzk-Vc2C2q3HVf2VoB8xC-Fse08s7q1iWJWGN2F14a_PgDdf6_BJ',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
                          onPressed: () => context.go(AppRoutes.restaurantDetails),
                        ),
                      ),
                    ),
                  ],
                ),

                // 2. Info Panel
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Classic Wagyu Burger',
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Rating
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              4.width,
                              Text(
                                '4.9',
                                style: AppTextStyles.labelLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      12.height,
                      Text(
                        'Premium wagyu beef patty grilled to juicy perfection, layers of double melted cheddar cheese, special Delish sauce, served on toasted artisanal brioche.',
                        style: AppTextStyles.bodyMedium,
                      ),
                      24.height,

                      // 3. Portion Size Selector
                      Text(
                        'Select Portion Size',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      12.height,
                      Row(
                        children: [
                          _buildSizeChip('Small'),
                          12.width,
                          _buildSizeChip('Medium'),
                          12.width,
                          _buildSizeChip('Large'),
                        ],
                      ),
                      24.height,

                      // 4. Custom Add-ons
                      Text(
                        'Add-ons',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.height,
                      Column(
                        children: addonsList.map((addon) {
                          final selected = _selectedAddons.contains(addon['name']);
                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColors.primary,
                            title: Text(addon['name'], style: AppTextStyles.bodyLarge),
                            subtitle: Text(addon['price'], style: AppTextStyles.bodyMedium),
                            value: selected,
                            onChanged: (_) => _toggleAddon(addon['name']),
                          );
                        }).toList(),
                      ),
                      120.height, // Spacer for bottom bar
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 5. Pinned Bottom Counter & Add Button Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
              ),
              child: Row(
                children: [
                  // Quantity adjusters
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.outlineVariant),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: AppColors.primary),
                          onPressed: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '$_quantity',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: AppColors.primary),
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  16.width,

                  // Add button
                  Expanded(
                    child: CommonButton(
                      text: 'Add to Cart • \$${(18.50 * _quantity).toStringAsFixed(2)}',
                      onPressed: () {
                        context.go(AppRoutes.cart);
                      },
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

  Widget _buildSizeChip(String size) {
    final active = _selectedSize == size;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSize = size;
          });
        },
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.primaryFixed : Colors.white,
            borderRadius: AppSpacing.borderRadiusLG,
            border: Border.all(
              color: active ? AppColors.primary : AppColors.outlineVariant,
              width: 1,
            ),
          ),
          child: Text(
            size,
            style: AppTextStyles.labelLarge.copyWith(
              color: active ? AppColors.primary : AppColors.onSurface,
              fontWeight: active ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
