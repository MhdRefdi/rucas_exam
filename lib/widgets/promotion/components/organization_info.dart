// lib/widgets/promotion/components/organization_info.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';

class OrganizationInfo extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const OrganizationInfo({
    super.key,
    required this.promotion,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(SpacingConstants.tinySpacing + 2),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(SpacingConstants.smallSpacing),
          ),
          child: Icon(
            Icons.school_rounded,
            color: theme.primaryColor,
            size: 22,
          ),
        ),
        const SizedBox(width: SpacingConstants.smallSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tawaran Khusus Ruangguru',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
              Text(
                'ID: ${promotion.id} • 500+ Digunakan',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}