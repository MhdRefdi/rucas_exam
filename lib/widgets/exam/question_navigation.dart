import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/exam_data.dart';
import 'package:rucas_exam_project/models/provider/exam_provider.dart';

class QuestionNavigation extends StatelessWidget {
  final AppTheme theme;
  final ExamProvider examProvider;
  final ExamData exam;

  const QuestionNavigation({
    super.key,
    required this.theme,
    required this.examProvider,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(theme.mediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navigasi Soal:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
          SizedBox(height: theme.smallSpace),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(exam.questions.length, (index) {
                return _buildQuestionButton(index);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionButton(int index) {
    final isCurrentQuestion = examProvider.currentQuestionIndex == index;
    final hasAnswer = examProvider.getQuestionAnswer(
      exam.questions[index].id,
    ) != null;

    return Padding(
      padding: EdgeInsets.only(right: theme.smallSpace),
      child: InkWell(
        onTap: () {
          examProvider.jumpToQuestion(index);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrentQuestion
                ? theme.primaryColor
                : hasAnswer
                    ? theme.backgroundColor.withOpacity(0.5)
                    : theme.backgroundColor.withOpacity(0.2),
            border: Border.all(
              color: isCurrentQuestion
                  ? theme.primaryColor
                  : hasAnswer
                      ? theme.primaryColor
                      : theme.backgroundColor,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isCurrentQuestion
                    ? theme.defaultColor
                    : theme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}