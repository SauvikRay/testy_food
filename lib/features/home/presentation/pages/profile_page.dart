import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'My Profile',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            24.height,
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuC1PIOMXv-lFDkpYRbegTrbmEububZ5yoR7gLG8WVWPHE1p8o5IHy_yRYRpMrRVnzdPMnrbRk9FB9pYSftLVO9BoffS4yBwYu4SQ2-xvpf2U50pYyJCNIuaqtDF9WLxeCr1-HzyAu2wjyGs_xsvoUvJq8e49pgSwU-77hVK1nydTxBgIRK_3Q0NCr-bG_8ABw_ZJhYlC3g74e4mjFfxp3cDK_v1w2zaegugB89QBNUYF9uvml4SqcmbHAqjKCMj_gaLyL5XlJTKulFa',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.height,
            Text(
              'Alex Harrison',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            4.height,
            Text(
              'alex.harrison@gourmet.com',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            32.height,

            // Profile actions list
            Material(
              color: Colors.white,
              borderRadius: AppSpacing.borderRadiusLG,
              clipBehavior: Clip.antiAlias,
              // shape: RoundedRectangleBorder(
              //   borderRadius: AppSpacing.borderRadiusLG,
              //   side: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
              // ),
              child: Column(
                children: [
                  _buildProfileTile(Icons.shopping_bag_outlined, 'My Orders'),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  _buildProfileTile(
                    Icons.favorite_border,
                    'Favorites',
                    onTap: () => context.go(AppRoutes.wishlist),
                  ),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  _buildProfileTile(
                    Icons.location_on_outlined,
                    'Delivery Addresses',
                  ),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  _buildProfileTile(Icons.payment_outlined, 'Payment Methods'),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  _buildProfileTile(
                    Icons.logout,
                    'Log Out',
                    color: AppColors.primary,
                    onTap: () => context.go(AppRoutes.login),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(
    IconData icon,
    String title, {
    Color? color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.onSurfaceVariant),
      title: Text(
        title,
        style: AppTextStyles.labelLarge.copyWith(
          color: color ?? AppColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.outline),
      onTap: onTap,
    );
  }
}
