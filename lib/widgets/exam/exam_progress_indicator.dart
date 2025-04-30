import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class ExamProgressIndicator extends StatelessWidget {
  final AppTheme theme;
  final ExamProvider examProvider;
  final int examLength;

  const ExamProgressIndicator({
    super.key,
    required this.theme,
    required this.examProvider,
    required this.examLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme.smallSpace,
        horizontal: theme.mediumSpace,
      ),
      color: theme.backgroundColor.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pertanyaan ${examProvider.currentQuestionIndex + 1} dari $examLength',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
          SizedBox(height: theme.smallSpace),
          LinearProgressIndicator(
            value: (examProvider.currentQuestionIndex + 1) / examLength,
            backgroundColor: theme.backgroundColor.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ),
        ],
      ),
    );
  }
}