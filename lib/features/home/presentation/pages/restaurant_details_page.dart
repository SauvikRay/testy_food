import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';
import 'package:testy_food/core/widgets/animated_pressable.dart';
import 'package:testy_food/core/widgets/animate_in.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Classic Wagyu Burger',
      'description': 'Grilled wagyu beef patty, double melted cheddar, special house sauce, buttered brioche.',
      'price': '\$18.50',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAx7qWbnrecqMf0mtjbBV2gDGNE1UOG64xVzoMaP4chs4dhIBFXP7ef1cwqGDGayjkqEs9F5HJd2C0K7SCV-65WMENqCCOuTx2SrYCBIFO4wkq7cxRu6Ka9egABUZI0XbptOiAYAwchlUVHqD9lyyjLf2FqrFh0sEfD-pQRWEs5fNZlNs1InBYgAw9aJ6HvP5T6E41qQ0EVzTj2W1EZLwRw98VcPzk-Vc2C2q3HVf2VoB8xC-Fse08s7q1iWJWGN2F14a_PgDdf6_BJ',
    },
    {
      'name': 'Modern Greek Salad',
      'description': 'Crisp romaine, cucumber, cherry tomatoes, kalamata olives, marinated Greek feta, extra virgin olive oil.',
      'price': '\$12.00',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4zc4EFdiLhhT_XDDM0JvYf0gHwH5Lz6-iBpKaL5-nrHS8BECDnSJjWe6cFIrZxw0aALv5W5QvTSJkZnpeKogGA_eKhDlz5218veK58SHUUafPasXAKWpSOg4MYw-PZbeYBwbADwY7uz79ppEwxAu95rejxYSi_-OPwJ3p7E69BKkeRM42AdgZFvnYJbykmYmACW5cJJoqc7v9x4NeT0IY2urTAotww5AWMtjBdUe-D2mjr0xa6aMT8fwS7swpYEhHyj2lSUkqsC1P',
    },
    {
      'name': 'Signature Lava Delight',
      'description': 'Rich Belgian chocolate with a warm flowing center served with fresh berries.',
      'price': '\$9.50',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDLvTwhucmZgHjg3i4xW3WEiuTUstjDYpNIAWV7P834zrRA571PVrSMKQ5dy6sXHbaq0pajIXyZDdUbfGssfD2RJp1yuL7cuTQfJpkGwZpMKMjs6o-MYCyclqyROYPRaJSPYJdc48VDCM0KToJll4RILQfxkmWe3tqn47Mm-5Io2AkZ2qBkRxZDbzOrYVEtYoG3N2opYVVAdT5cMotfHCTo8a_Hj_rbzbrM7vuvwAvmx3IHgqd5uGLULnru20S28hm5rIxBi6CsoCb6',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Collapsible cover banner
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            leading: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.9),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
                onPressed: () => context.go(AppRoutes.home),
              ),
            ),
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'restaurant-cover-The Golden Truffle',
                child: CommonCachedNetworkImage(
                  imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD6ZEcIwkG5YQe0tASRrchXkZjxgT70y73F2WLNXBy7T_LiPCK2T_hz4wwFtGCknqtRlKbd_JfyXO2rlGgqcA-Oq4uTkZjdXLj6l5FGtwURklNa8LIgCSkFL0W6Xio0yP-5DYC6AS2HSY9wRxffxd-t4ig4KqCo_5o6Y-tY71ynlZCRj8o7Umx44jr9doWsm0QXDI05X_-WCPxlesMSCe_2AlTuRoVw8sjZHoTRskqC3hmzT_Odt6eFF53iTdeygBASIAPwZYHfMikI',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Restaurant Info & Details Panel
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'The Golden Truffle',
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: AppColors.primary, size: 16),
                            4.width,
                            Text(
                              '4.8',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    'European • Fine Dining • Gourmet Plates',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  16.height,
                  const Divider(color: AppColors.outlineVariant),
                  16.height,

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Delivery', '20-30 min', Icons.delivery_dining_outlined),
                      _buildStatColumn('Cost', '\$\$', Icons.monetization_on_outlined),
                      _buildStatColumn('Distance', '1.8 miles', Icons.navigation_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar selector (pins on scroll)
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabsDelegate(
              child: Container(
                color: AppColors.background,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.outline,
                  labelStyle: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: AppTextStyles.labelLarge,
                  tabs: const [
                    Tab(text: 'Appetizers'),
                    Tab(text: 'Main Course'),
                    Tab(text: 'Desserts'),
                    Tab(text: 'Drinks'),
                  ],
                ),
              ),
            ),
          ),

          // List of Menu Items
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = menuItems[index];
                  return AnimateIn(
                    delay: Duration(milliseconds: index * 100),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildMenuItemCard(
                        context: context,
                        name: item['name'],
                        description: item['description'],
                        price: item['price'],
                        imageUrl: item['imageUrl'],
                      ),
                    ),
                  );
                },
                childCount: menuItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        8.height,
        Text(
          value,
          style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        4.height,
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildMenuItemCard({
    required BuildContext context,
    required String name,
    required String description,
    required String price,
    required String imageUrl,
  }) {
    return AnimatedPressable(
      onTap: () => context.go(AppRoutes.foodDetails),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppSpacing.borderRadiusLG,
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Hero(
                  tag: 'food-cover-$name',
                  child: CommonCachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  4.height,
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                  ),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutes.foodDetails),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Add',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
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
  }
}

class _SliverTabsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverTabsDelegate({required this.child});

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SliverTabsDelegate oldDelegate) => false;
}
