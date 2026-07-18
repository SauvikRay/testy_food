import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/routes/route_transition.dart';
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
import 'features/home/presentation/pages/offers_page.dart';
import 'features/home/presentation/pages/notifications_page.dart';
import 'features/home/presentation/pages/saved_addresses_page.dart';
import 'features/home/presentation/pages/payment_methods_page.dart';
import 'features/home/presentation/pages/help_support_page.dart';
import 'features/home/presentation/pages/settings_page.dart';
import 'features/search/presentation/pages/search_screen.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/cart/presentation/pages/checkout_page.dart';
import 'features/cart/presentation/pages/order_success_page.dart';
import 'features/cart/presentation/pages/order_tracking_page.dart';
import 'features/cart/presentation/pages/order_history_page.dart';
import 'features/cart/presentation/pages/rate_review_page.dart';
import 'features/main/presentation/pages/main_layout.dart';
import 'features/main/presentation/pages/error_page.dart';
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
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const OnboardingPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const RegisterScreen(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: const HomePage(),
          ),
          routes: [
            GoRoute(
              path: 'restaurants',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const RestaurantListPage(),
              ),
            ),
            GoRoute(
              path: 'restaurant-details',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const RestaurantDetailsPage(),
              ),
            ),
            GoRoute(
              path: 'food-details',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const FoodDetailsPage(),
              ),
            ),
            GoRoute(
              path: 'offers',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const OffersPage(),
              ),
            ),
            GoRoute(
              path: 'notifications',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const NotificationsPage(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.search,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: const SearchScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.cart,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: const CartPage(),
          ),
          routes: [
            GoRoute(
              path: 'checkout',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const CheckoutPage(),
              ),
            ),
            GoRoute(
              path: 'success',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const OrderSuccessPage(),
              ),
            ),
            GoRoute(
              path: 'tracking',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const OrderTrackingPage(),
              ),
            ),
            GoRoute(
              path: 'history',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const OrderHistoryPage(),
              ),
            ),
            GoRoute(
              path: 'rate-review',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const RateReviewPage(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.wishlist,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: const WishlistPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: const ProfilePage(),
          ),
          routes: [
            GoRoute(
              path: 'addresses',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const SavedAddressesPage(),
              ),
            ),
            GoRoute(
              path: 'payments',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const PaymentMethodsPage(),
              ),
            ),
            GoRoute(
              path: 'help',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const HelpSupportPage(),
              ),
            ),
            GoRoute(
              path: 'settings',
              pageBuilder: (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: const SettingsPage(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.errorPage,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: const ErrorPage(),
          ),
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
      debugShowCheckedModeBanner: false,
      title: 'Vibrant Gourmet',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
