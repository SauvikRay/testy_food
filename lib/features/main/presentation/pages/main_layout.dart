import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

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
            currentIndex: selectedIndex,
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
            onTap: (int index) => _onItemTapped(index, context),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
