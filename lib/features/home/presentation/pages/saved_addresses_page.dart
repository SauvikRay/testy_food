import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/animate_in.dart';
import 'package:testy_food/core/widgets/common_button.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  final List<Map<String, dynamic>> addresses = [
    {
      'label': 'Home',
      'address': '123 Gourmet Blvd, Downtown, New York, NY 10001',
      'icon': Icons.home_rounded,
      'isDefault': true,
    },
    {
      'label': 'Office',
      'address': '505 Wall Street, Financial Dist, New York, NY 10005',
      'icon': Icons.work_rounded,
      'isDefault': false,
    },
    {
      'label': 'Gym',
      'address': '84 Fitlife Ave, Central Park West, New York, NY 10024',
      'icon': Icons.fitness_center_rounded,
      'isDefault': false,
    },
  ];

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
          'Saved Addresses',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final addr = addresses[index];
          return AnimateIn(
            delay: Duration(milliseconds: 80 * index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(
                  color: addr['isDefault']
                      ? AppColors.primary
                      : AppColors.outlineVariant.withValues(alpha: 0.3),
                  width: addr['isDefault'] ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: addr['isDefault']
                        ? AppColors.primaryContainer.withValues(alpha: 0.1)
                        : AppColors.outlineVariant.withValues(alpha: 0.2),
                    child: Icon(
                      addr['icon'],
                      color: addr['isDefault'] ? AppColors.primary : AppColors.outline,
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              addr['label'],
                              style: AppTextStyles.labelLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (addr['isDefault']) ...[
                              8.width,
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Default',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        6.height,
                        Text(
                          addr['address'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: AppColors.outline),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonButton(
              text: 'Add New Address',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
