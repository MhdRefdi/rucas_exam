import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/widgets/promotion/promotion_app_bar.dart';
import 'package:rucas_exam_project/widgets/promotion/promotion_info_section.dart';
import 'package:rucas_exam_project/widgets/promotion/promotion_terms_section.dart';

class PromotionDetail extends StatelessWidget {
  final Promotion promotion;

  const PromotionDetail({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Image header with glassmorphism app bar
          PromotionAppBar(promotion: promotion, size: size, theme: theme),

          // Main content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(SpacingConstants.largeBorderRadius),
                  topRight: Radius.circular(SpacingConstants.largeBorderRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promotion info section
                  PromotionInfoSection(promotion: promotion, theme: theme),

                  const SizedBox(height: SpacingConstants.defaultSpacing),

                  // Terms and conditions
                  PromotionTermsSection(promotion: promotion, theme: theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}