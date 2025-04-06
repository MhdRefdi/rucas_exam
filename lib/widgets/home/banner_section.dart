import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/home/promotion_banner.dart';

class PromotionSection extends StatelessWidget {
  final Color textColor;
  final double mediumSpace;

  const PromotionSection({
    super.key,
    required this.textColor,
    required this.mediumSpace,
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
            color: textColor,
          ),
        ),
        SizedBox(height: mediumSpace),
        BannerPromosi(),
      ],
    );
  }
}
