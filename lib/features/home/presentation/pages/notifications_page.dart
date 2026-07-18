import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';

import 'package:testy_food/core/widgets/animate_in.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Order Out for Delivery',
        'message': 'Driver Marco Kelly is on his way with your Golden Truffle burger order.',
        'time': 'Just now',
        'icon': Icons.delivery_dining,
        'color': AppColors.primary,
        'unread': true,
      },
      {
        'title': '50% Flash Sale Italian Cuisines',
        'message': 'Get 50% discount codes instantly on selected Italian categories.',
        'time': '2 hours ago',
        'icon': Icons.local_offer,
        'color': Colors.orange,
        'unread': true,
      },
      {
        'title': 'Support Chat Resolved',
        'message': 'Your inquiry regarding previous Sushiko order has been marked solved.',
        'time': 'Yesterday',
        'icon': Icons.chat_bubble_outline_rounded,
        'color': Colors.green,
        'unread': false,
      },
      {
        'title': 'Payment Method Added',
        'message': 'Visa ending in 8490 successfully added to payment wallet.',
        'time': '3 days ago',
        'icon': Icons.credit_card,
        'color': Colors.blue,
        'unread': false,
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
          'Notifications',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          final isUnread = notif['unread'] as bool;
          return AnimateIn(
            delay: Duration(milliseconds: 80 * index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUnread ? Colors.white : Colors.white.withValues(alpha: 0.7),
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(
                  color: isUnread
                      ? AppColors.primaryContainer.withValues(alpha: 0.2)
                      : AppColors.outlineVariant.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.01),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon indicator
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (notif['color'] as Color).withValues(alpha: 0.1),
                    ),
                    child: Icon(notif['icon'], color: notif['color'], size: 20),
                  ),
                  16.width,
    
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notif['title'],
                                style: AppTextStyles.labelLarge.copyWith(
                                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              notif['time'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.outline,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        6.height,
                        Text(
                          notif['message'],
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
