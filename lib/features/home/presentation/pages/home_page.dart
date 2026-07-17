import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedNavIndex = 0;
  String _selectedCategory = 'Pizza';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      // Floating Contextual Track Order Action Button
      floatingActionButton: _selectedNavIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 4,
              icon: const Icon(Icons.delivery_dining),
              label: Text(
                'Order tracking',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : null,

      // Custom Scroll View for collapsing AppBar effect
      body: _selectedNavIndex == 0
          ? CustomScrollView(
              slivers: [
                // 1. Collapsible AppBar (floating & snap back)
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,
                  backgroundColor: AppColors.background,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          4.width,
                          Text(
                            'Downtown, NY',
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.expand_more,
                            color: AppColors.onSurface.withValues(alpha: 0.6),
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    // Notification Bell
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none,
                            color: AppColors.onSurfaceVariant,
                          ),
                          onPressed: () {},
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // User profile image
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 8),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                          image: const DecorationImage(
                            image: CachedNetworkImageProvider(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuC1PIOMXv-lFDkpYRbegTrbmEububZ5yoR7gLG8WVWPHE1p8o5IHy_yRYRpMrRVnzdPMnrbRk9FB9pYSftLVO9BoffS4yBwYu4SQ2-xvpf2U50pYyJCNIuaqtDF9WLxeCr1-HzyAu2wjyGs_xsvoUvJq8e49pgSwU-77hVK1nydTxBgIRK_3Q0NCr-bG_8ABw_ZJhYlC3g74e4mjFfxp3cDK_v1w2zaegugB89QBNUYF9uvml4SqcmbHAqjKCMj_gaLyL5XlJTKulFa',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // 2. Greeting Header Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning, Alex!',
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'What are you craving today?',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Pinned Search Bar & Filter Header
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverSearchDelegate(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppSpacing.borderRadiusLG,
                              border: Border.all(
                                color: AppColors.outlineVariant.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                16.width,
                                const Icon(
                                  Icons.search,
                                  color: AppColors.outline,
                                ),
                                16.width,
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Search for food or restaurants',
                                      hintStyle: AppTextStyles.bodyMedium
                                          .copyWith(color: AppColors.outline),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.mic, color: AppColors.primary),
                                16.width,
                              ],
                            ),
                          ),
                        ),
                        16.width,
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: AppSpacing.borderRadiusLG,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.tune, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. Main Scrollable Dashboard Content
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      12.height,
                      
                      // Offer Banner
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 20,
                                top: 20,
                                bottom: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'FLASH SALE',
                                      style: AppTextStyles.labelLarge.copyWith(
                                        color: Colors.white70,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    4.height,
                                    Text(
                                      '50% OFF\non Italian!',
                                      style: AppTextStyles.headlineLargeMobile
                                          .copyWith(
                                            color: Colors.white,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    16.height,
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppColors.primary,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'Order Now',
                                        style: AppTextStyles.labelSmall.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Floating Pizza Image on right
                              Positioned(
                                right: -30,
                                bottom: -30,
                                top: -10,
                                child: Transform.rotate(
                                  angle: -0.15,
                                  child: SizedBox(
                                    width: 220,
                                    child: CommonCachedNetworkImage(
                                      imageUrl:
                                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAnH6fy7YzqI-L_MAVW8Zlzt9ndPbJPjaFHQ-smxVYneBJEJkSzxCpWssRMsWFgu2P_dErCoLCQDAEcXA52goVWuJe0YEklBf9pIb2gtyJ5AwoC3G0h0Al9g89CRwQbinnrD1IDUPOi2_9dw0UgGAUTnxfmpkydSFEhUyzyAwivmrFUx9Y_XU9f_NBP_MJYwhgfZwFQD5GdOr9GoqwH4FLTrf4KdLfDRQBEg1CTV1LbPYO_Mk-dZe0BaQXaGIC5fvfw7TbYGqaRzMsZ',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      24.height,

                      // Categories Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: AppTextStyles.headlineSmall.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.height,
                      SizedBox(
                        height: 96,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          clipBehavior: Clip.none,
                          children: [
                            _buildCategoryItem('Pizza', Icons.local_pizza),
                            _buildCategoryItem('Burger', Icons.lunch_dining),
                            _buildCategoryItem('Chinese', Icons.ramen_dining),
                            _buildCategoryItem('Dessert', Icons.icecream),
                            _buildCategoryItem('Drinks', Icons.local_bar),
                            _buildCategoryItem('Bakery', Icons.bakery_dining),
                          ],
                        ),
                      ),
                      24.height,

                      // Popular Restaurants Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Popular Restaurants',
                              style: AppTextStyles.headlineSmall.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'View All',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.height,
                      SizedBox(
                        height: 236,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          clipBehavior: Clip.none,
                          children: [
                            _buildRestaurantCard(
                              name: 'The Golden Truffle',
                              rating: '4.8',
                              time: '20-30 min',
                              categories: 'European • Fine Dining • \$\$\$',
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuD6ZEcIwkG5YQe0tASRrchXkZjxgT70y73F2WLNXBy7T_LiPCK2T_hz4wwFtGCknqtRlKbd_JfyXO2rlGgqcA-Oq4uTkZjdXLj6l5FGtwURklNa8LIgCSkFL0W6Xio0yP-5DYC6AS2HSY9wRxffxd-t4ig4KqCo_5o6Y-tY71ynlZCRj8o7Umx44jr9doWsm0QXDI05X_-WCPxlesMSCe_2AlTuRoVw8sjZHoTRskqC3hmzT_Odt6eFF53iTdeygBASIAPwZYHfMikI',
                            ),
                            16.width,
                            _buildRestaurantCard(
                              name: 'Sushiko Urban',
                              rating: '4.5',
                              time: '15-25 min',
                              categories: 'Japanese • Sushi • \$\$',
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCk71WN9fK3PlSKqQ5_f91QTSZ3Z3pZR92jSo0FJrropNsWvUcAs8_6OSnFai9IHQM3fP4c3NgFUMuzuJRyAWfzLoZs18_9G2gsNIR5P0VbeSAFBSKVzjy01tm5woEXk3z3UQO15Qth0jaXIh7CoI21Da7CqmAZGcM0B5pLBGyQO21c6BMX9lWRlsuBCN-pdCuFGE_v1uLAZLWsUS7OTOEqS87JmOTaVMsgZ0BDNUoMN4X1tpwwb2L-peBVD0SM3xPmKNlkL7xB9kYd',
                            ),
                          ],
                        ),
                      ),
                      24.height,

                      // Recommended for you Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Recommended for You',
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      16.height,
                      
                      // Recommendations Bento/Grid-list style
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.8,
                          children: [
                            _buildGridFoodItem(
                              name: 'Classic Wagyu Burger',
                              price: '\$18.50',
                              rating: '4.9',
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAx7qWbnrecqMf0mtjbBV2gDGNE1UOG64xVzoMaP4chs4dhIBFXP7ef1cwqGDGayjkqEs9F5HJd2C0K7SCV-65WMENqCCOuTx2SrYCBIFO4wkq7cxRu6Ka9egABUZI0XbptOiAYAwchlUVHqD9lyyjLf2FqrFh0sEfD-pQRWEs5fNZlNs1InBYgAw9aJ6HvP5T6E41qQ0EVzTj2W1EZLwRw98VcPzk-Vc2C2q3HVf2VoB8xC-Fse08s7q1iWJWGN2F14a_PgDdf6_BJ',
                            ),
                            _buildGridFoodItem(
                              name: 'Modern Greek Salad',
                              price: '\$12.00',
                              rating: '4.7',
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuB4zc4EFdiLhhT_XDDM0JvYf0gHwH5Lz6-iBpKaL5-nrHS8BECDnSJjWe6cFIrZxw0aALv5W5QvTSJkZnpeKogGA_eKhDlz5218veK58SHUUafPasXAKWpSOg4MYw-PZbeYBwbADwY7uz79ppEwxAu95rejxYSi_-OPwJ3p7E69BKkeRM42AdgZFvnYJbykmYmACW5cJJoqc7v9x4NeT0IY2urTAotww5AWMtjBdUe-D2mjr0xa6aMT8fwS7swpYEhHyj2lSUkqsC1P',
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      
                      // Full-width Recommended item
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildFullWidthFoodItem(
                          name: 'Signature Lava Delight',
                          description:
                              'Rich Belgian chocolate with a warm flowing center served with fresh berries.',
                          price: '\$9.50',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDLvTwhucmZgHjg3i4xW3WEiuTUstjDYpNIAWV7P834zrRA571PVrSMKQ5dy6sXHbaq0pajIXyZDdUbfGssfD2RJp1yuL7cuTQfJpkGwZpMKMjs6o-MYCyclqyROYPRaJSPYJdc48VDCM0KToJll4RILQfxkmWe3tqn47Mm-5Io2AkZ2qBkRxZDbzOrYVEtYoG3N2opYVVAdT5cMotfHCTo8a_Hj_rbzbrM7vuvwAvmx3IHgqd5uGLULnru20S28hm5rIxBi6CsoCb6',
                        ),
                      ),
                      80.height,
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                'Dummy Feature Screen',
                style: TextStyle(fontFamily: 'Inter', fontSize: 16),
              ),
            ),

      // Fixed Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedNavIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.outline,
            backgroundColor: Colors.white.withValues(alpha: 0.85),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: AppColors.primary,
            ),
            unselectedLabelStyle: AppTextStyles.labelSmall.copyWith(
              fontSize: 11,
              color: AppColors.outline,
            ),
            onTap: (int index) {
              setState(() {
                _selectedNavIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Category Item Widget
  Widget _buildCategoryItem(String title, IconData icon) {
    final active = _selectedCategory == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: active
                    ? AppColors.primaryFixed
                    : AppColors.surfaceVariant.withValues(alpha: 0.4),
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(
                  color: active ? AppColors.primary : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: active ? AppColors.primary : AppColors.outline,
                size: 26,
              ),
            ),
            4.height,
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
                color: active ? AppColors.primary : AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Restaurant Card Widget
  Widget _buildRestaurantCard({
    required String name,
    required String rating,
    required String time,
    required String categories,
    required String imageUrl,
  }) {
    return Container(
      width: 280,
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
          // Image block
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: CommonCachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Rating Badge
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
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
              // Duration Badge
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.height,
                Row(
                  children: [
                    const Icon(
                      Icons.restaurant,
                      size: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                    4.width,
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
    );
  }

  // Grid Food Item Widget
  Widget _buildGridFoodItem({
    required String name,
    required String price,
    required String rating,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CommonCachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          8.height,
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelLarge,
          ),
          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 12),
                  4.width,
                  Text(rating, style: AppTextStyles.labelSmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Full Width Food Item Widget
  Widget _buildFullWidthFoodItem({
    required String name,
    required String description,
    required String price,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 100,
              height: 100,
              child: CommonCachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.labelLarge.copyWith(fontSize: 15),
                    ),
                    4.height,
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer.withValues(
                          alpha: 0.15,
                        ),
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
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
    );
  }
}

// Custom Sliver Delegate for the search header that pins at the top of the screen
class _SliverSearchDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverSearchDelegate({required this.child});

  @override
  double get minExtent => 72.0;

  @override
  double get maxExtent => 72.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverSearchDelegate oldDelegate) => false;
}
