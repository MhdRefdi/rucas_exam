// lib/widgets/promotion/promotion_terms_section.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/widgets/promotion/components/term_item.dart';
import 'package:rucas_exam_project/widgets/promotion/components/claim_button.dart';

class PromotionTermsSection extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const PromotionTermsSection({
    super.key,
    required this.promotion,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(SpacingConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SpacingConstants.largeBorderRadius),
          topRight: Radius.circular(SpacingConstants.largeBorderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: theme.primaryColor),
              const SizedBox(width: SpacingConstants.tinySpacing),
              Text(
                'Syarat & Ketentuan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingConstants.defaultSpacing),
          
          const TermItem(text: 'Berlaku hingga akhir bulan'),
          const TermItem(text: 'Tidak dapat digabungkan dengan promosi lain'),
          const TermItem(text: 'Berlaku untuk pengguna baru dan lama'),
          const TermItem(text: 'Terbatas satu penggunaan per akun'),

          const SizedBox(height: 40),

          // Call to action button
          ClaimButton(promotion: promotion, theme: theme),

          const SizedBox(height: SpacingConstants.defaultSpacing),
        ],
      ),
    );
  }
}