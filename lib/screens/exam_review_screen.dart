import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/models/result_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';
import 'package:rucas_exam_project/widgets/exam/exam_navigation_buttons.dart';
import 'package:rucas_exam_project/widgets/exam/question_navigation.dart';

import '../models/question_model.dart';

class ExamReviewScreen extends StatefulWidget {
  final String examId;
  final AppTheme theme;

  const ExamReviewScreen({
    super.key,
    required this.examId,
    this.theme = const AppTheme(),
  });

  @override
  State<ExamReviewScreen> createState() => _ExamReviewScreenState();
}

class _ExamReviewScreenState extends State<ExamReviewScreen> {
  late ExamResult? _latestResult;
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultProvider = Provider.of<ResultProvider>(context, listen: false);
      _latestResult = resultProvider.getLatestResultForExam(widget.examId);
      setState(() {});
    });
  }

  void _jumpToQuestion(int index) {
    setState(() {
      _currentQuestionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultProvider = Provider.of<ResultProvider>(context);
    final examProvider = Provider.of<ExamProvider>(context);
    final exam = examProvider.getExamById(widget.examId);

    if (exam == null || _latestResult == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text('Exam or result not found!'),
        ),
      );
    }

    final currentQuestion = exam.questions[_currentQuestionIndex];
    final userAnswer = _latestResult!.userAnswers[currentQuestion.id];
    final correctAnswer = _latestResult!.correctAnswer[currentQuestion.id];
    final isCorrect = userAnswer == correctAnswer;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review Ujian: ${exam.title}',
          style: TextStyle(color: widget.theme.defaultColor),
        ),
        backgroundColor: widget.theme.primaryColor,
        iconTheme: IconThemeData(color: widget.theme.defaultColor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Performance header
          _buildPerformanceHeader(
            context,
            _latestResult!.correctAnswers,
            _latestResult!.totalQuestions,
            _latestResult!.scorePercentage,
            _latestResult!.flaggedQuestions,
          ),
          
          // Main question card
          Expanded(
            child: _ReviewQuestionCard(
              theme: widget.theme,
              question: currentQuestion,
              userAnswer: userAnswer,
              correctAnswer: correctAnswer,
              isCorrect: isCorrect,
            ),
          ),
          
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.theme.primaryColor,
                  ),
                  onPressed: _currentQuestionIndex > 0
                      ? () => _jumpToQuestion(_currentQuestionIndex - 1)
                      : null,
                  child: Text(
                    'Sebelumnya',
                    style: TextStyle(color: widget.theme.defaultColor),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.theme.primaryColor,
                  ),
                  onPressed: _currentQuestionIndex < exam.questions.length - 1
                      ? () => _jumpToQuestion(_currentQuestionIndex + 1)
                      : null,
                  child: Text(
                    'Selanjutnya',
                    style: TextStyle(color: widget.theme.defaultColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceHeader(
    BuildContext context,
    int correctCount,
    int totalQuestions,
    double scorePercentage,
    int flaggedCount,
  ) {
    final resultProvider = Provider.of<ResultProvider>(context, listen: false);
    final attemptsCount = resultProvider.getTotalAttemptsForExam(widget.examId);
    final averageScore = resultProvider.getAverageScoreForExam(widget.examId);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: widget.theme.primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: widget.theme.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.check_circle,
                'Benar',
                '$correctCount',
                Colors.green,
              ),
              _buildStatItem(
                Icons.cancel,
                'Salah',
                '${totalQuestions - correctCount}',
                Colors.red,
              ),
              _buildStatItem(
                Icons.flag,
                'Ditandai',
                '$flaggedCount',
                Colors.orange,
              ),
              _buildStatItem(
                Icons.score,
                'Nilai',
                '${scorePercentage.toStringAsFixed(1)}%',
                _getScoreColor(scorePercentage),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.history,
                'Percobaan',
                '$attemptsCount',
                Colors.blue,
              ),
              _buildStatItem(
                Icons.assessment,
                'Rata-rata',
                '${averageScore.toStringAsFixed(1)}%',
                Colors.purple,
              ),
              if (_latestResult!.rating != null && _latestResult!.rating! > 0)
                _buildStatItem(
                  Icons.star,
                  'Rating',
                  '${_latestResult!.rating}/10',
                  Colors.amber,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: widget.theme.textColor.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }
}

class _ReviewQuestionCard extends StatelessWidget {
  final AppTheme theme;
  final Question question;
  final String? userAnswer;
  final String? correctAnswer;
  final bool isCorrect;

  const _ReviewQuestionCard({
    required this.theme,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            question.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // Options
          Column(
            children: question.options.entries.map((entry) {
              final optionKey = entry.key;
              final optionText = entry.value;
              final isUserAnswer = userAnswer == optionKey;
              final isActuallyCorrect = correctAnswer == optionKey;
              
              Color borderColor = Colors.grey;
              Color bgColor = Colors.transparent;
              IconData? icon;
              Color iconColor = Colors.transparent;

              if (isUserAnswer && isActuallyCorrect) {
                borderColor = Colors.green;
                bgColor = Colors.green.withOpacity(0.1);
                icon = Icons.check_circle;
                iconColor = Colors.green;
              } else if (isUserAnswer && !isActuallyCorrect) {
                borderColor = Colors.red;
                bgColor = Colors.red.withOpacity(0.1);
                icon = Icons.cancel;
                iconColor = Colors.red;
              } else if (isActuallyCorrect) {
                borderColor = Colors.green;
                bgColor = Colors.green.withOpacity(0.1);
                icon = Icons.check_circle;
                iconColor = Colors.green;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                  color: bgColor,
                ),
                child: ListTile(
                  leading: Text(
                    '$optionKey.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.textColor,
                    ),
                  ),
                  title: Text(optionText),
                  trailing: Icon(icon, color: iconColor),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          
          // Explanation (if available)
          if (question.solution != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Penjelasan:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  question.solution!,
                  style: TextStyle(color: theme.textColor),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

enum AnswerStatus {
  unanswered,
  correct,
  incorrect,
}