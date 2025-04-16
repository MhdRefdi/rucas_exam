import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/Home/exam_grid.dart';

class ExamSection extends StatelessWidget {
  final Color textColor;
  final Color defaultColor;
  final Color primaryColor;
  final double mediumSpace;
  final double mediumRadius;
  final VoidCallback? onSeeAll;

  const ExamSection({
    super.key,
    required this.textColor,
    required this.defaultColor,
    required this.primaryColor,
    required this.mediumSpace,
    required this.mediumRadius,
    this.onSeeAll,
  });

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
                color: textColor,
              ),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                "Lihat Selengkapnya",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: mediumSpace),
        Container(
          padding: EdgeInsets.all(mediumSpace),
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadius.circular(mediumRadius),
            border: Border.all(color: textColor.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: textColor.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ExamGrid(
            exams: [
              {'id': 'math', 'icon': Icons.calculate, 'label': 'Matematika'},
              {'id': 'science', 'icon': Icons.science, 'label': 'IPA'},
              {'id': 'biology', 'icon': Icons.biotech, 'label': 'Biologi'},
              {'id': 'physics', 'icon': Icons.speed, 'label': 'Fisika'},
              {'id': 'chemistry', 'icon': Icons.bubble_chart, 'label': 'Kimia'},
              {'id': 'history', 'icon': Icons.history_edu, 'label': 'Sejarah'},
              {'id': 'geography', 'icon': Icons.public, 'label': 'Geografi'},
              {
                'id': 'english',
                'icon': Icons.language,
                'label': 'Bahasa Inggris',
              },
              {
                'id': 'indonesian',
                'icon': Icons.book,
                'label': 'Bahasa Indonesia',
              },
              {
                'id': 'economics',
                'icon': Icons.attach_money,
                'label': 'Ekonomi',
              },
              {'id': 'sociology', 'icon': Icons.group, 'label': 'Sosiologi'},
              {'id': 'civics', 'icon': Icons.gavel, 'label': 'PPKn'},
            ],
          ),
        ),
      ],
    );
  }
}
