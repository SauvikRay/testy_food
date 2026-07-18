import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/animate_in.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> activeOrders = [
    {
      'id': 'FL-8490',
      'restaurant': 'The Golden Truffle',
      'items': 'Classic Wagyu Burger (1x), Signature Lava Delight (2x)',
      'total': '\$41.00',
      'status': 'Out for Delivery',
      'date': 'Today, 11:15 AM',
    }
  ];

  final List<Map<String, dynamic>> pastOrders = [
    {
      'id': 'FL-7301',
      'restaurant': 'Sushiko Urban',
      'items': 'Spider Roll (2x), Edamame (1x)',
      'total': '\$32.50',
      'status': 'Delivered',
      'date': 'Yesterday, 8:40 PM',
    },
    {
      'id': 'FL-6124',
      'restaurant': 'Wok & Roll',
      'items': 'Kung Pao Chicken (1x), Fried Rice (1x)',
      'total': '\$24.00',
      'status': 'Delivered',
      'date': '12 July, 1:15 PM',
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.profile);
            }
          },
        ),
        title: Text(
          'My Orders',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.outline,
          labelStyle: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: AppTextStyles.labelLarge,
          tabs: const [
            Tab(text: 'Active Orders'),
            Tab(text: 'Past Orders'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(activeOrders, isActive: true),
          _buildOrdersList(pastOrders, isActive: false),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders, {required bool isActive}) {
    if (orders.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return AnimateIn(
          delay: Duration(milliseconds: 80 * index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppSpacing.borderRadiusLG,
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order['restaurant'],
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.primaryContainer.withValues(alpha: 0.1)
                            : AppColors.outlineVariant.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status'],
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isActive ? AppColors.primary : AppColors.outline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                8.height,
                Text(
                  order['date'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                12.height,
                const Divider(color: AppColors.outlineVariant),
                12.height,
                Text(
                  'Items:',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                4.height,
                Text(
                  order['items'],
                  style: AppTextStyles.bodyMedium,
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Paid: ${order['total']}',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    if (isActive)
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.orderTracking),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Track'),
                      )
                    else
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () => context.go(AppRoutes.rateReview),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Rate'),
                          ),
                          10.width,
                          ElevatedButton(
                            onPressed: () => context.go(AppRoutes.cart),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Reorder'),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
              Icons.receipt_long_outlined,
              color: AppColors.primary,
              size: 64,
            ),
          ),
          24.height,
          Text(
            'No orders history yet',
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          8.height,
          Text(
            'Your upcoming orders will appear here',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
