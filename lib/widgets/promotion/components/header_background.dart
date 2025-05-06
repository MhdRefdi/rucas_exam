// lib/widgets/promotion/components/header_background.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';

class HeaderBackground extends StatelessWidget {
  final Promotion promotion;

  const HeaderBackground({
    super.key,
    required this.promotion,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Hero image
        Hero(
          tag: 'promo-${promotion.id}',
          child: Image.asset(
            promotion.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                ),
              );
            },
          ),
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.6, 0.8, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}