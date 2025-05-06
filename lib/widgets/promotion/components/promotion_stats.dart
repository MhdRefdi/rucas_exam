import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/promotion/components/stat_item.dart';

class PromotionStats extends StatelessWidget {
  final AppTheme theme;

  const PromotionStats({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacingConstants.defaultSpacing),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(SpacingConstants.defaultSpacing),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const StatItem(
            icon: Icons.verified_user_rounded,
            label: 'Terverifikasi',
            value: '100%',
            iconColor: Colors.green,
          ),
          _buildStatDivider(),
          const StatItem(
            icon: Icons.people_alt_rounded,
            label: 'Pengguna',
            value: '500+',
            iconColor: Colors.blue,
          ),
          _buildStatDivider(),
          const StatItem(
            icon: Icons.thumb_up_alt_rounded,
            label: 'Sukses',
            value: '95%',
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[300]);
  }
}