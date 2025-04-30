import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/exam_data.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class OptionItem extends StatelessWidget {
  final AppTheme theme;
  final ExamProvider examProvider;
  final Question question;
  final MapEntry<String, String> option;
  final String? userAnswer;
  final bool isReviewMode;

  const OptionItem({
    super.key,
    required this.theme,
    required this.examProvider,
    required this.question,
    required this.option,
    required this.userAnswer,
    required this.isReviewMode,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = userAnswer == option.key;
    final isCorrect = isReviewMode && question.correctAnswer == option.key;
    final isWrong = isReviewMode && isSelected && question.correctAnswer != option.key;

    Color borderColor = isCorrect
        ? Colors.green
        : isWrong
            ? Colors.red
            : isSelected
                ? theme.primaryColor
                : theme.backgroundColor;

    Color fillColor = isCorrect
        ? Colors.green.withOpacity(0.1)
        : isWrong
            ? Colors.red.withOpacity(0.1)
            : isSelected
                ? theme.backgroundColor.withOpacity(0.2)
                : Colors.transparent;

    Color circleColor = isCorrect
        ? Colors.green
        : isWrong
            ? Colors.red
            : isSelected
                ? theme.primaryColor
                : theme.backgroundColor;

    return Padding(
      padding: EdgeInsets.only(bottom: theme.mediumSpace),
      child: InkWell(
        onTap: isReviewMode
            ? null
            : () {
                examProvider.answerQuestion(question.id, option.key);
              },
        borderRadius: BorderRadius.circular(theme.mediumRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.mediumRadius),
            border: Border.all(color: borderColor, width: 2),
            color: fillColor,
          ),
          padding: EdgeInsets.all(theme.mediumSpace),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                ),
                child: Center(
                  child: Text(
                    option.key,
                    style: TextStyle(
                      color: theme.defaultColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: theme.mediumSpace),
              Expanded(
                child: Text(
                  option.value,
                  style: TextStyle(
                    color: theme.textColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (isCorrect)
                const Icon(Icons.check_circle, color: Colors.green)
              else if (isWrong)
                const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}