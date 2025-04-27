import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/provider/exam_provider.dart';

class ExamResultsDialog extends StatelessWidget {
  final AppTheme theme;
  final Map<String, dynamic> results;
  final ExamProvider examProvider;

  const ExamResultsDialog({
    super.key,
    required this.theme,
    required this.results,
    required this.examProvider,
  });

  @override
  Widget build(BuildContext context) {
    final correct = results['correct'] ?? 0;
    final total = results['total'] ?? 0;
    final percentage = results['percentage'] ?? 0.0;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.mediumRadius),
      ),
      backgroundColor: theme.defaultColor,
      title: Text(
        'Hasil Ujian',
        style: TextStyle(
          color: theme.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildScoreCircle(percentage),
          SizedBox(height: theme.mediumSpace),
          Text(
            'Jawaban benar: $correct dari $total',
            style: TextStyle(fontSize: 18, color: theme.textColor),
          ),
          SizedBox(height: theme.mediumSpace),
          Text(
            _getFeedbackMessage(percentage),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            examProvider.reviewMode();
          },
          icon: const Icon(Icons.visibility),
          label: const Text('Review Jawaban'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.backgroundColor,
            foregroundColor: theme.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.mediumRadius),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            examProvider.resetExam();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          },
          icon: const Icon(Icons.home),
          label: const Text('Kembali ke Home'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: theme.defaultColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.mediumRadius),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCircle(double percentage) {
    Color circleColor = percentage >= 70
        ? Colors.green
        : percentage >= 50
            ? Colors.amber
            : Colors.red;

    return Container(
      padding: EdgeInsets.all(theme.largeSpace),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor.withOpacity(0.1),
        border: Border.all(
          color: circleColor,
          width: 3,
        ),
      ),
      child: Text(
        '${percentage.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: circleColor,
        ),
      ),
    );
  }

  String _getFeedbackMessage(double percentage) {
    if (percentage >= 70) {
      return 'Selamat! Hasil yang sangat baik.';
    } else if (percentage >= 50) {
      return 'Cukup baik, tetapi masih bisa ditingkatkan.';
    } else {
      return 'Perlu belajar lebih giat.';
    }
  }
}