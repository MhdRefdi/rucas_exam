import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/widgets/exam/option_item.dart';

class QuestionCard extends StatelessWidget {
  final AppTheme theme;
  final ExamProvider examProvider;

  const QuestionCard({
    super.key,
    required this.theme,
    required this.examProvider,
  });

  @override
  Widget build(BuildContext context) {
    final question = examProvider.currentQuestion;
    final isReviewMode = examProvider.isReviewMode;
    
    if (question == null) {
      return const SizedBox();
    }

    final userAnswer = examProvider.getCurrentQuestionAnswer();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(theme.mediumSpace),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.mediumRadius),
          ),
          color: theme.defaultColor,
          child: Padding(
            padding: EdgeInsets.all(theme.mediumSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.textColor,
                  ),
                ),
                SizedBox(height: theme.largeSpace),
                ...question.options.entries.map((option) {
                  return OptionItem(
                    theme: theme,
                    examProvider: examProvider,
                    question: question,
                    option: option,
                    userAnswer: userAnswer,
                    isReviewMode: isReviewMode,
                  );
                }).toList(),
                if (isReviewMode) _buildSolutionSection(question.solution),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSolutionSection(String solution) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: theme.largeSpace),
        Container(
          padding: EdgeInsets.all(theme.mediumSpace),
          decoration: BoxDecoration(
            color: theme.backgroundColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(theme.mediumRadius),
            border: Border.all(color: theme.primaryColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Penjelasan:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(height: theme.smallSpace),
              Text(
                solution,
                style: TextStyle(color: theme.textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}