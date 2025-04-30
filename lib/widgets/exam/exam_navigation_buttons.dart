import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class ExamNavigationButtons extends StatelessWidget {
  final AppTheme theme;
  final ExamProvider examProvider;
  final bool isLastQuestion;
  final bool isReviewMode;
  final VoidCallback onFinish;

  const ExamNavigationButtons({
    super.key,
    required this.theme,
    required this.examProvider,
    required this.isLastQuestion,
    required this.isReviewMode,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(theme.mediumSpace),
      decoration: BoxDecoration(
        color: theme.defaultColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol "Sebelumnya"
          _buildPreviousButton(),
          
          // Tombol "Selanjutnya" atau "Selesai" atau "Kembali ke Home"
          if (isReviewMode && isLastQuestion)
            _buildHomeButton(context)
          else
            _buildNextOrFinishButton(),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return ElevatedButton.icon(
      onPressed: examProvider.currentQuestionIndex > 0
          ? () {
              examProvider.previousQuestion();
            }
          : null,
      icon: const Icon(Icons.arrow_back),
      label: const Text('Sebelumnya'),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.backgroundColor,
        foregroundColor: theme.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.mediumRadius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme.mediumSpace,
          vertical: theme.smallSpace,
        ),
      ),
    );
  }

  Widget _buildNextOrFinishButton() {
    return ElevatedButton.icon(
      onPressed: isLastQuestion
          ? onFinish
          : () {
              examProvider.nextQuestion();
            },
      icon: Icon(isLastQuestion ? Icons.check_circle : Icons.arrow_forward),
      label: Text(isLastQuestion ? 'Selesai' : 'Selanjutnya'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isLastQuestion ? Colors.green : theme.primaryColor,
        foregroundColor: theme.defaultColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.mediumRadius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme.mediumSpace,
          vertical: theme.smallSpace,
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        examProvider.resetExam();
        Navigator.pushReplacementNamed(context, '/home');
      },
      icon: const Icon(Icons.home),
      label: const Text('Kembali ke Home'),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.defaultColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.mediumRadius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme.mediumSpace,
          vertical: theme.smallSpace,
        ),
      ),
    );
  }
}