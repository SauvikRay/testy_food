import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushNotifications = true;
  bool _emailOffers = false;
  bool _darkMode = false;

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
          'Settings',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Preferences'),
          12.height,
          Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusLG,
              side: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  activeTrackColor: AppColors.primaryFixed,
                  activeThumbColor: AppColors.primary,
                  title: Text(
                    'Push Notifications',
                    style: AppTextStyles.labelLarge,
                  ),
                  subtitle: Text(
                    'Receive active order tracking and promo alerts.',
                    style: AppTextStyles.bodyMedium,
                  ),
                  value: _pushNotifications,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                ),
                const Divider(height: 1, color: AppColors.outlineVariant),
                SwitchListTile(
                  activeTrackColor: AppColors.primaryFixed,
                  activeThumbColor: AppColors.primary,
                  title: Text(
                    'Email Promotions',
                    style: AppTextStyles.labelLarge,
                  ),
                  subtitle: Text(
                    'Receive discount coupons via email.',
                    style: AppTextStyles.bodyMedium,
                  ),
                  value: _emailOffers,
                  onChanged: (val) => setState(() => _emailOffers = val),
                ),
                const Divider(height: 1, color: AppColors.outlineVariant),
                SwitchListTile(
                  activeTrackColor: AppColors.primaryFixed,
                  activeThumbColor: AppColors.primary,
                  title: Text(
                    'Dark Mode Mock',
                    style: AppTextStyles.labelLarge,
                  ),
                  value: _darkMode,
                  onChanged: (val) => setState(() => _darkMode = val),
                ),
              ],
            ),
          ),
          28.height,

          _buildSectionHeader('Account & Privacy'),
          12.height,
          Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusLG,
              side: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                _buildSettingsTile('Change Password', Icons.lock_outline),
                const Divider(height: 1, color: AppColors.outlineVariant),
                _buildSettingsTile(
                  'Terms of Service',
                  Icons.description_outlined,
                ),
                const Divider(height: 1, color: AppColors.outlineVariant),
                _buildSettingsTile(
                  'Privacy Policy',
                  Icons.privacy_tip_outlined,
                ),
              ],
            ),
          ),
          28.height,

          // Version listing
          Center(
            child: Text(
              'Vibrant Gourmet • Version 1.0.0 (Build 8490)',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.outline,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: AppTextStyles.headlineSmall.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.onSurfaceVariant),
      title: Text(
        title,
        style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.outline),
      onTap: () {},
    );
  }
}
