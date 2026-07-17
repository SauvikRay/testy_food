import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testy_food/core/routes/app_routes.dart';
import 'package:testy_food/core/theme/app_colors.dart';
import 'package:testy_food/core/theme/app_spacing.dart';
import 'package:testy_food/core/theme/app_text_styles.dart';
import 'package:testy_food/core/widgets/common_text_field.dart';
import 'package:testy_food/core/widgets/common_cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _hasText = false;

  final List<String> recentSearches = [
    'Sushi',
    'Truffle Pasta',
    'Wagyu Burger',
    'Gelato',
  ];

  final List<Map<String, dynamic>> categoriesList = [
    {'name': 'Burgers', 'icon': Icons.lunch_dining},
    {'name': 'Pizza', 'icon': Icons.local_pizza},
    {'name': 'Sushi', 'icon': Icons.ramen_dining},
    {'name': 'Salads', 'icon': Icons.spa},
    {'name': 'Desserts', 'icon': Icons.icecream},
    {'name': 'Drinks', 'icon': Icons.local_bar},
  ];

  final List<Map<String, dynamic>> searchMatches = [
    {
      'name': 'Classic Wagyu Burger',
      'price': '\$18.50',
      'rating': '4.9',
      'restaurant': 'The Golden Truffle',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAx7qWbnrecqMf0mtjbBV2gDGNE1UOG64xVzoMaP4chs4dhIBFXP7ef1cwqGDGayjkqEs9F5HJd2C0K7SCV-65WMENqCCOuTx2SrYCBIFO4wkq7cxRu6Ka9egABUZI0XbptOiAYAwchlUVHqD9lyyjLf2FqrFh0sEfD-pQRWEs5fNZlNs1InBYgAw9aJ6HvP5T6E41qQ0EVzTj2W1EZLwRw98VcPzk-Vc2C2q3HVf2VoB8xC-Fse08s7q1iWJWGN2F14a_PgDdf6_BJ',
    },
    {
      'name': 'Modern Greek Salad',
      'price': '\$12.00',
      'rating': '4.7',
      'restaurant': 'Le Bistro Paris',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4zc4EFdiLhhT_XDDM0JvYf0gHwH5Lz6-iBpKaL5-nrHS8BECDnSJjWe6cFIrZxw0aALv5W5QvTSJkZnpeKogGA_eKhDlz5218veK58SHUUafPasXAKWpSOg4MYw-PZbeYBwbADwY7uz79ppEwxAu95rejxYSi_-OPwJ3p7E69BKkeRM42AdgZFvnYJbykmYmACW5cJJoqc7v9x4NeT0IY2urTAotww5AWMtjBdUe-D2mjr0xa6aMT8fwS7swpYEhHyj2lSUkqsC1P',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _hasText = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Pinned Search Bar row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSpacing.borderRadiusLG,
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          16.width,
                          const Icon(Icons.search, color: AppColors.outline),
                          12.width,
                          Expanded(
                            child: CommonTextField(
                              controller: _searchController,
                              autofocus: true,
                              textInputAction: TextInputAction.search,
                              hintText: 'Search for food or restaurants',
                              hintStyle: AppTextStyles.bodyMedium
                                  .copyWith(color: AppColors.outline),
                              border: InputBorder.none,
                            ),
                          ),
                          if (_hasText)
                            IconButton(
                              icon: const Icon(Icons.close, color: AppColors.outline),
                              onPressed: () => _searchController.clear(),
                            )
                          else
                            const Icon(Icons.mic, color: AppColors.primary),
                          16.width,
                        ],
                      ),
                    ),
                  ),
                  12.width,
                  TextButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Conditionally load Search History OR Results
            Expanded(
              child: _hasText ? _buildSearchResults() : _buildSearchHistory(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Text(
            'Recent Searches',
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          12.height,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: recentSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = search;
                },
                child: Chip(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  label: Text(search, style: AppTextStyles.bodyMedium),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.outlineVariant),
                  ),
                ),
              );
            }).toList(),
          ),
          32.height,
          Text(
            'Popular Categories',
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.height,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categoriesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final cat = categoriesList[index];
              return GestureDetector(
                onTap: () {
                  _searchController.text = cat['name'];
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppSpacing.borderRadiusLG,
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat['icon'], color: AppColors.primary, size: 24),
                      12.width,
                      Text(
                        cat['name'],
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searchMatches.length,
      itemBuilder: (context, index) {
        final match = searchMatches[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: GestureDetector(
            onTap: () => context.go(AppRoutes.foodDetails),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLG,
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: CommonCachedNetworkImage(
                        imageUrl: match['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match['name'],
                          style: AppTextStyles.labelLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        4.height,
                        Text(
                          match['restaurant'],
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        6.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              match['price'],
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                4.width,
                                Text(
                                  match['rating'],
                                  style: AppTextStyles.labelSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
