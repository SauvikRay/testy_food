import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final List<Map<String, dynamic>> faqs = [
    {
      'question': 'How can I track my active order?',
      'answer': 'Go to the Orders tab in the bottom bar, select your active order, and tap the "Track" button to view real-time delivery status.',
      'expanded': false,
    },
    {
      'question': 'What payment methods are supported?',
      'answer': 'We support all major Credit/Debit Cards (Visa, MasterCard), PayPal, Apple Pay, and Cash on Delivery.',
      'expanded': false,
    },
    {
      'question': 'Can I modify or cancel my order?',
      'answer': 'Orders can only be modified or cancelled within 5 minutes of placing them. After the restaurant starts preparation, modifications are locked.',
      'expanded': false,
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
          'Help & Support',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAQs heading
            Text(
              'Frequently Asked Questions',
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.height,

            // FAQ Accordion list
            Column(
              children: faqs.map((faq) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppSpacing.borderRadiusLG,
                    border: Border.all(
                      color: AppColors.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                  child: ExpansionTile(
                    shape: const Border(),
                    title: Text(
                      faq['question'],
                      style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          faq['answer'],
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            28.height,

            // Still need help section
            Text(
              'Still Need Assistance?',
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.height,

            // Call support card
            _buildContactCard(
              title: 'Contact Support Hotline',
              subtitle: 'Available 24/7 for urgent delivery issues.',
              icon: Icons.phone_forwarded_rounded,
              onTap: () {},
            ),
            12.height,

            // Email support card
            _buildContactCard(
              title: 'Email Support Ticket',
              subtitle: 'We typically respond within 2-4 hours.',
              icon: Icons.mail_outline_rounded,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusLG,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppSpacing.borderRadiusLG,
          border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryContainer.withValues(alpha: 0.1),
              child: Icon(icon, color: AppColors.primary),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  4.height,
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.outline),
          ],
        ),
      ),
    );
  }
}
