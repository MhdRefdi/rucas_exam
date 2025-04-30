import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class UnansweredQuestionsDialog extends StatelessWidget {
  final AppTheme theme;
  final int unansweredCount;
  final List<int> unansweredIndices;
  final ExamProvider examProvider;
  final VoidCallback onFinish;

  const UnansweredQuestionsDialog({
    super.key,
    required this.theme,
    required this.unansweredCount,
    required this.unansweredIndices,
    required this.examProvider,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.mediumRadius),
      ),
      backgroundColor: theme.defaultColor,
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.amber),
          SizedBox(width: theme.smallSpace),
          Text(
            'Peringatan',
            style: TextStyle(
              color: theme.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Anda memiliki $unansweredCount soal yang belum dijawab:',
            style: TextStyle(color: theme.textColor),
          ),
          SizedBox(height: theme.mediumSpace),
          Wrap(
            spacing: theme.smallSpace,
            runSpacing: theme.smallSpace,
            children: unansweredIndices.map((index) {
              return _buildQuestionButton(context, index);
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Kembali',
            style: TextStyle(color: theme.backgroundColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onFinish();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: theme.defaultColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.mediumRadius),
            ),
          ),
          child: const Text('Selesai Ujian'),
        ),
      ],
    );
  }

  Widget _buildQuestionButton(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        examProvider.jumpToQuestion(index);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber.withOpacity(0.2),
          border: Border.all(color: Colors.amber),
        ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}