// lib/widgets/promotion/components/claim_button.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/widgets/promotion/components/success_dialog.dart';

class ClaimButton extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const ClaimButton({
    super.key,
    required this.promotion,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingConstants.borderRadius),
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.primaryColor.withBlue(
              (theme.primaryColor.blue + 40).clamp(0, 255),
            ),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadius),
          onTap: () => _showSuccessDialog(context),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_offer_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'KLAIM PROMO SEKARANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SuccessDialog(
          promotion: promotion,
          theme: theme,
        );
      },
    );
  }
}