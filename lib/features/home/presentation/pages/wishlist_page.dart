import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> wishItems = [
      {
        'name': 'Classic Wagyu Burger',
        'price': '\$18.50',
        'rating': '4.9',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAx7qWbnrecqMf0mtjbBV2gDGNE1UOG64xVzoMaP4chs4dhIBFXP7ef1cwqGDGayjkqEs9F5HJd2C0K7SCV-65WMENqCCOuTx2SrYCBIFO4wkq7cxRu6Ka9egABUZI0XbptOiAYAwchlUVHqD9lyyjLf2FqrFh0sEfD-pQRWEs5fNZlNs1InBYgAw9aJ6HvP5T6E41qQ0EVzTj2W1EZLwRw98VcPzk-Vc2C2q3HVf2VoB8xC-Fse08s7q1iWJWGN2F14a_PgDdf6_BJ',
      },
      {
        'name': 'Modern Greek Salad',
        'price': '\$12.00',
        'rating': '4.7',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4zc4EFdiLhhT_XDDM0JvYf0gHwH5Lz6-iBpKaL5-nrHS8BECDnSJjWe6cFIrZxw0aALv5W5QvTSJkZnpeKogGA_eKhDlz5218veK58SHUUafPasXAKWpSOg4MYw-PZbeYBwbADwY7uz79ppEwxAu95rejxYSi_-OPwJ3p7E69BKkeRM42AdgZFvnYJbykmYmACW5cJJoqc7v9x4NeT0IY2urTAotww5AWMtjBdUe-D2mjr0xa6aMT8fwS7swpYEhHyj2lSUkqsC1P',
      },
    ];

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
          'Your Wishlist',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: wishItems.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishItems.length,
              itemBuilder: (context, index) {
                final item = wishItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => context.go(AppRoutes.foodDetails),
                    child: Container(
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
                                12.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['price'],
                                      style: AppTextStyles.labelLarge.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 14),
                                        4.width,
                                        Text(
                                          item['rating'],
                                          style: AppTextStyles.labelSmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 64, color: AppColors.outline),
          16.height,
          Text(
            'No favorites saved yet',
            style: AppTextStyles.headlineSmall,
          ),
        ],
      ),
    );
  }
}
