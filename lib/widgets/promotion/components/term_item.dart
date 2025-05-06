// lib/widgets/promotion/components/term_item.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';

class TermItem extends StatelessWidget {
  final String text;

  const TermItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingConstants.smallSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, size: 18, color: Colors.green),
          const SizedBox(width: SpacingConstants.smallSpacing),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF424242),
              ),
            ),
          ),
        ],
      ),
    );
  }
}