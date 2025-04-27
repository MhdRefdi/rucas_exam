import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/home/promotion_banner.dart';

class PromotionSection extends StatelessWidget {
  final AppTheme theme = AppTheme();


   PromotionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Promosi Terbaru",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.textColor,
          ),
        ),
        SizedBox(height: theme.mediumSpace),
        BannerPromosi(
          banners: [
            {'image': 'banners/th.jpg', 'title': 'Diskon 50% untuk Ujian!'},
            {'image': 'banners/1.png', 'title': 'Paket Belajar Premium!'},
            {
              'image': 'banners/2.png',
              'title': 'Try Out Nasional Segera Dimulai!',
            },
          ],
          bannerHeight: 140,
          bannerWidth: 320,
          spacing: 12,
          borderRadius: 16,
          gradientColor: Colors.black45,
        ),
      ],
    );
  }
}
