import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';
import 'package:testy_food/core/widgets/animated_pressable.dart';
import 'package:testy_food/core/widgets/animate_in.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> restaurants = [
      {
        'name': 'The Golden Truffle',
        'rating': '4.8',
        'time': '20-30 min',
        'categories': 'European • Fine Dining • \$\$\$',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD6ZEcIwkG5YQe0tASRrchXkZjxgT70y73F2WLNXBy7T_LiPCK2T_hz4wwFtGCknqtRlKbd_JfyXO2rlGgqcA-Oq4uTkZjdXLj6l5FGtwURklNa8LIgCSkFL0W6Xio0yP-5DYC6AS2HSY9wRxffxd-t4ig4KqCo_5o6Y-tY71ynlZCRj8o7Umx44jr9doWsm0QXDI05X_-WCPxlesMSCe_2AlTuRoVw8sjZHoTRskqC3hmzT_Odt6eFF53iTdeygBASIAPwZYHfMikI',
      },
      {
        'name': 'Sushiko Urban',
        'rating': '4.5',
        'time': '15-25 min',
        'categories': 'Japanese • Sushi • \$\$',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCk71WN9fK3PlSKqQ5_f91QTSZ3Z3pZR92jSo0FJrropNsWvUcAs8_6OSnFai9IHQM3fP4c3NgFUMuzuJRyAWfzLoZs18_9G2gsNIR5P0VbeSAFBSKVzjy01tm5woEXk3z3UQO15Qth0jaXIh7CoI21Da7CqmAZGcM0B5pLBGyQO21c6BMX9lWRlsuBCN-pdCuFGE_v1uLAZLWsUS7OTOEqS87JmOTaVMsgZ0BDNUoMN4X1tpwwb2L-peBVD0SM3xPmKNlkL7xB9kYd',
      },
      {
        'name': 'Le Bistro Paris',
        'rating': '4.7',
        'time': '25-35 min',
        'categories': 'French • Bistro • \$\$\$',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCIeQEEtyJKFl8E2AwTP4hUtQX8uPOIhoi_W8FjqIM0uL85epds_s6qR7-GQotEf5Ul8lIqOelwS5VMlIWYxxhTa0LmmWf1oIGhemmRiyPsmxBbub2zKCnxX_Rrxm9WhvfVR3TtMJZ70kaV09VXWJJyDdwkuP-gUemozF4z7WceRa9mNEPJ3MnJzqtpzz5NxWdZun5Lf_CHIKWxxcdDyabN31P4aJWkSLYR8gO0-BgBBpaqdAntaBP8D09KLgMgLWhqo1DtOQ__Z6SV',
      },
      {
        'name': 'Wok & Roll',
        'rating': '4.3',
        'time': '10-20 min',
        'categories': 'Asian • Chinese • \$',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA_DhVp9zQwd_euE6Pk-e8PimKBAF7Je7WUEfct24i0Kvbp6oolz8VTLMLPcmNGME3ZDqB2xbBg9ptuUWFjfl_-n0lRZXq3pNjTPgat0p5SjGJjOh3RRwoRjh9ULJb3DOIpG58o4xiOpgpAdXOa_l2wMAfN2-6EU_ZJSqKsW4es6JDKDZe16JMh1L0uOrGkhjFziThgeBzZvaJFZtVGWoqwehmeWcZ51nNDhyenzcdDGKtH8NWviOr7Lwc-UHO8nxIP6zHZ5bFSqBOo',
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
          'All Restaurants',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final rest = restaurants[index];
          return AnimateIn(
            delay: Duration(milliseconds: index * 100),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildListCard(
                context: context,
                name: rest['name'],
                rating: rest['rating'],
                time: rest['time'],
                categories: rest['categories'],
                imageUrl: rest['imageUrl'],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListCard({
    required BuildContext context,
    required String name,
    required String rating,
    required String time,
    required String categories,
    required String imageUrl,
  }) {
    return AnimatedPressable(
      onTap: () => context.go(AppRoutes.restaurantDetails),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppSpacing.borderRadiusLG,
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Hero(
                      tag: 'restaurant-cover-$name',
                      child: CommonCachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        4.width,
                        Text(
                          rating,
                          style: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      time,
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  6.height,
                  Row(
                    children: [
                      const Icon(
                        Icons.restaurant,
                        size: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                      6.width,
                      Expanded(
                        child: Text(
                          categories,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium,
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
  }
}
