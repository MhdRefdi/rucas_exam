// lib/widgets/promotion/promotion_info_section.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/widgets/promotion/components/organization_info.dart';
import 'package:rucas_exam_project/widgets/promotion/components/promotion_badges.dart';
import 'package:rucas_exam_project/widgets/promotion/components/promotion_stats.dart';

class PromotionInfoSection extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const PromotionInfoSection({
    super.key,
    required this.promotion,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingConstants.defaultPadding,
        SpacingConstants.defaultPadding + SpacingConstants.tinySpacing,
        SpacingConstants.defaultPadding,
        SpacingConstants.defaultSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization info
          OrganizationInfo(promotion: promotion, theme: theme),

          const SizedBox(height: SpacingConstants.defaultPadding),
          
          // Promotion badges
          const PromotionBadges(),
          
          const SizedBox(height: SpacingConstants.defaultPadding),
          
          // Promotion stats
          PromotionStats(theme: theme),

          const SizedBox(height: SpacingConstants.defaultPadding + 4),

          // About section
          Text(
            'Tentang Promosi Ini',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: SpacingConstants.smallSpacing),
          Text(
            promotion.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}