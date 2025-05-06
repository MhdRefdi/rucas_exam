// lib/widgets/promotion/components/promotion_badges.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/widgets/promotion/components/badge.dart';


class PromotionBadges extends StatelessWidget {
  const PromotionBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PromotionBadge(
          text: 'Tawaran Terbatas',
          icon: Icons.timelapse_rounded,
          color: Colors.orange,
        ),
        const SizedBox(width: SpacingConstants.tinySpacing),
        PromotionBadge(
          text: 'Terverifikasi',
          icon: Icons.verified_rounded,
          color: Colors.green,
        ),
      ],
    );
  }
}