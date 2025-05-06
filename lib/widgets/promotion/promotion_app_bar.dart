// lib/widgets/promotion/promotion_app_bar.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/widgets/promotion/components/back_button.dart';
import 'package:rucas_exam_project/widgets/promotion/components/header_background.dart';

class PromotionAppBar extends StatelessWidget {
  final Promotion promotion;
  final Size size;
  final AppTheme theme;

  const PromotionAppBar({
    super.key,
    required this.promotion,
    required this.size,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: size.height * 0.45,
      pinned: true,
      backgroundColor: theme.primaryColor,
      elevation: 0,
      stretch: true,
      leading: CustomBackButton(context: context),
      leadingWidth: 45,
      flexibleSpace: FlexibleSpaceBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            promotion.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  color: Colors.black45,
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: HeaderBackground(promotion: promotion),
      ),
    );
  }
}