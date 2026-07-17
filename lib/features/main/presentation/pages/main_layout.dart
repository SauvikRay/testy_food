import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/features/main/presentation/foodapp_tabbar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.home)) {
      return 0;
    }
    if (location.startsWith(AppRoutes.search)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.cart)) {
      return 2;
    }
    if (location.startsWith(AppRoutes.wishlist)) {
      return 3;
    }
    if (location.startsWith(AppRoutes.profile)) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.search);
        break;
      case 2:
        context.go(AppRoutes.cart);
        break;
      case 3:
        context.go(AppRoutes.wishlist);
        break;
      case 4:
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: FoodAppTabBar(
        currentIndex: selectedIndex,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.outline,
        backgroundColor: Colors.white.withValues(alpha: 0.85),
        onTap: (int index) => _onItemTapped(index, context),
        items: [
          FoodAppNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
          FoodAppNavigationBarItem(icon: const Icon(Icons.search), label: 'Search'),
          FoodAppNavigationBarItem(
            icon: const Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          FoodAppNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          FoodAppNavigationBarItem(icon: const Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
