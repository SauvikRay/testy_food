import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_button.dart';
import 'package:testy_food/core/widgets/common_text_field.dart';

class RateReviewPage extends StatefulWidget {
  const RateReviewPage({super.key});

  @override
  State<RateReviewPage> createState() => _RateReviewPageState();
}

class _RateReviewPageState extends State<RateReviewPage> {
  int _restaurantRating = 0;
  int _courierRating = 0;
  final _commentController = TextEditingController();
  final List<String> tags = ['Delicious Food', 'Quick Delivery', 'Warm Meal', 'Polite Courier', 'Generous Portions'];
  final List<String> selectedTags = [];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  void _handleSubmitReview() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your feedback helps us improve.'),
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        context.go(AppRoutes.home);
      }
    });
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
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: Text(
          'Rate Your Experience',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Restaurant Rating Block
            _buildRatingCard(
              title: 'How was the food?',
              subtitle: 'The Golden Truffle',
              rating: _restaurantRating,
              onRatingChanged: (val) => setState(() => _restaurantRating = val),
            ),
            20.height,

            // 2. Courier Rating Block
            _buildRatingCard(
              title: 'How was the delivery?',
              subtitle: 'Courier Agent Marco',
              rating: _courierRating,
              onRatingChanged: (val) => setState(() => _courierRating = val),
            ),
            24.height,

            // 3. Feedback Tags Selection
            Text(
              'What went exceptionally well?',
              style: AppTextStyles.headlineSmall.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            12.height,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return GestureDetector(
                  onTap: () => _toggleTag(tag),
                  child: Chip(
                    backgroundColor: isSelected ? AppColors.primaryFixed : Colors.white,
                    label: Text(tag),
                    labelStyle: AppTextStyles.labelSmall.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.outlineVariant,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            24.height,

            // 4. Custom Comments input
            Text(
              'Additional Comments',
              style: AppTextStyles.headlineSmall.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            12.height,
            CommonTextField(
              controller: _commentController,
              hintText: 'Tell us what you loved or how we can improve...',
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
            ),
            40.height,

            // 5. Submit Button
            CommonButton(
              text: 'Submit Feedback',
              onPressed: _handleSubmitReview,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCard({
    required String title,
    required String subtitle,
    required int rating,
    required ValueChanged<int> onRatingChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.borderRadiusLG,
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          4.height,
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
          16.height,
          // Star indicators row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              final isFilled = rating >= starIndex;
              return GestureDetector(
                onTap: () => onRatingChanged(starIndex),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                    color: isFilled ? Colors.amber : AppColors.outline,
                    size: 38,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
