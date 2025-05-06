// lib/widgets/promotion/components/success_dialog.dart

import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';


class SuccessDialog extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const SuccessDialog({
    super.key,
    required this.promotion,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(SpacingConstants.defaultPadding),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SpacingConstants.defaultPadding),
              topRight: Radius.circular(SpacingConstants.defaultPadding),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(SpacingConstants.defaultSpacing),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green[600],
                  size: 48,
                ),
              ),
              const SizedBox(height: SpacingConstants.defaultSpacing + 4),
              const Text(
                'Promosi Diterima!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: SpacingConstants.smallSpacing),
              Text(
                'Anda telah berhasil mengklaim ${promotion.title}. Diskon akan diterapkan pada pembelian Anda berikutnya.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: SpacingConstants.defaultPadding),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SpacingConstants.borderRadius),
                  ),
                ),
                child: const Text(
                  'Lanjutkan Belanja',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
  }
}