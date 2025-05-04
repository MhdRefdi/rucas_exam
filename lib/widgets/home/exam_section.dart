import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/Home/exam_grid.dart';

class ExamSection extends StatelessWidget {
  final AppTheme theme = AppTheme();

  final VoidCallback? onSeeAll;

  ExamSection({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pilihan Ujian",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.textColor,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/list-exam',
                  (route) => false,
                );
              },
              child: Text(
                "Lihat Selengkapnya",
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.mediumSpace),
        Container(
          padding: EdgeInsets.all(theme.mediumSpace),
          decoration: BoxDecoration(
            color: theme.defaultColor,
            borderRadius: BorderRadius.circular(theme.mediumRadius),
            border: Border.all(color: theme.textColor.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: theme.textColor.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ExamGrid(),
        ),
      ],
    );
  }
}
