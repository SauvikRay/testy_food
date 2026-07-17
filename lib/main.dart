import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/auth/presentation/pages/register_screen.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/pages/restaurant_list_page.dart';
import 'features/home/presentation/pages/restaurant_details_page.dart';
import 'features/home/presentation/pages/food_details_page.dart';
import 'features/home/presentation/pages/wishlist_page.dart';
import 'features/home/presentation/pages/profile_page.dart';
import 'features/search/presentation/pages/search_screen.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/cart/presentation/pages/checkout_page.dart';
import 'features/main/presentation/pages/main_layout.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'restaurants',
              builder: (context, state) => const RestaurantListPage(),
            ),
            GoRoute(
              path: 'restaurant-details',
              builder: (context, state) => const RestaurantDetailsPage(),
            ),
            GoRoute(
              path: 'food-details',
              builder: (context, state) => const FoodDetailsPage(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: AppRoutes.cart,
          builder: (context, state) => const CartPage(),
          routes: [
            GoRoute(
              path: 'checkout',
              builder: (context, state) => const CheckoutPage(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.wishlist,
          builder: (context, state) => const WishlistPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vibrant Gourmet',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
