import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/home/promotion_banner.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';

class PromotionSection extends StatelessWidget {
  final AppTheme theme = AppTheme();

  PromotionSection({super.key});

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
          bannerHeight: 150,
          bannerWidth: MediaQuery.of(context).size.width - 32,
          onPromotionTap: (promotion) {
            Navigator.pushNamed(context, '/promotion', arguments: promotion);
          },
          promotions: promotions,
        ),
      ],
    );
  }
}
