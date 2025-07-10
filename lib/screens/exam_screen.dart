import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/widgets/exam/exam_progress_indicator.dart';
import 'package:rucas_exam_project/widgets/exam/question_navigation.dart';
import 'package:rucas_exam_project/widgets/exam/question_card.dart';
import 'package:rucas_exam_project/widgets/exam/exam_navigation_buttons.dart';
import 'package:rucas_exam_project/widgets/exam/unanswered_questions_dialog.dart';
import 'package:rucas_exam_project/widgets/exam/exam_results_dialog.dart';

import '../models/exam_model.dart';
import '../models/question_model.dart';
import '../models/result_model.dart';
import '../provider/result_provider.dart';

class ExamScreen extends StatefulWidget {
  final AppTheme theme;
  final String examId;

  const ExamScreen({
    super.key,
    required this.examId,
    this.theme = const AppTheme(),
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  void initState() {
    super.initState();
    // Start exam when screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExamProvider>(
        context,
        listen: false,
      ).startExam(widget.examId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context);
    final exam = examProvider.currentExam;

    // Handle case when exam is not found
    if (exam == null) {
      return _buildExamNotFoundScreen();
    }

    final isLastQuestion = examProvider.isLastQuestion;
    final isReviewMode = examProvider.isReviewMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          exam.title,
          style: TextStyle(color: widget.theme.defaultColor),
        ),
        backgroundColor: widget.theme.primaryColor,
        iconTheme: IconThemeData(color: widget.theme.defaultColor),
        elevation: 0,
      ),
      backgroundColor: widget.theme.defaultColor,
      body: Column(
        children: [
          // Progress indicator
          ExamProgressIndicator(
            theme: widget.theme,
            examProvider: examProvider,
            examLength: exam.questions.length,
          ),

          // Jump to Question section
          QuestionNavigation(
            theme: widget.theme,
            examProvider: examProvider,
            exam: exam,
          ),

          // Question card
          Expanded(
            child: QuestionCard(
              theme: widget.theme,
              examProvider: examProvider,
            ),
          ),

          // Navigation buttons
          ExamNavigationButtons(
            theme: widget.theme,
            examProvider: examProvider,
            isLastQuestion: isLastQuestion,
            isReviewMode: isReviewMode,
            onFinish: () => _checkUnansweredQuestions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildExamNotFoundScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Error',
          style: TextStyle(color: widget.theme.defaultColor),
        ),
        backgroundColor: widget.theme.primaryColor,
      ),
      body: Center(
        child: Text(
          'Exam not found!',
          style: TextStyle(color: widget.theme.textColor),
        ),
      ),
    );
  }

  void _checkUnansweredQuestions(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context, listen: false);
    final exam = examProvider.currentExam;

    if (exam == null) return;

    int unansweredCount = 0;
    List<int> unansweredIndices = [];

    for (int i = 0; i < exam.questions.length; i++) {
      if (examProvider.getQuestionAnswer(exam.questions[i].id) == null) {
        unansweredCount++;
        unansweredIndices.add(i);
      }
    }

    if (unansweredCount > 0) {
      showDialog(
        context: context,
        builder:
            (context) => UnansweredQuestionsDialog(
              theme: widget.theme,
              unansweredCount: unansweredCount,
              unansweredIndices: unansweredIndices,
              examProvider: examProvider,
              onFinish: () => _showResults(context),
            ),
      );
    } else {
      _showResults(context);
    }
  }

  void _showResults(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context, listen: false);
    final results = examProvider.calculateResults();
    final exam = examProvider.currentExam;

    if (exam == null) return;

    showDialog(
      context: context,
      builder:
          (context) => ExamResultsDialog(
            theme: widget.theme,
            results: results,
            examProvider: examProvider,
          ),
    );
  }
}

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

class ExamResultsDialog extends StatefulWidget {
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
  State<ExamResultsDialog> createState() => _ExamResultsDialogState();
}

class _ExamResultsDialogState extends State<ExamResultsDialog> {
  double _rating = 5;
  double _difficulty = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final correct = widget.results['correct'] ?? 0;
    final total = widget.results['total'] ?? 0;
    final percentage = widget.results['percentage'] ?? 0.0;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.theme.mediumRadius),
      ),
      backgroundColor: widget.theme.defaultColor,
      title: Text(
        'Hasil Ujian',
        style: TextStyle(
          color: widget.theme.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildScoreCircle(percentage),
            const SizedBox(height: 16),
            Text(
              'Jawaban benar: $correct dari $total',
              style: TextStyle(fontSize: 18, color: widget.theme.textColor),
            ),
            const SizedBox(height: 16),
            Text(
              _getFeedbackMessage(percentage),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.theme.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Divider(color: widget.theme.textColor.withOpacity(0.3)),
            const SizedBox(height: 12),
            // Feedback UI
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Feedback Ujian',
                style: TextStyle(
                  color: widget.theme.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildSlider(
              label: 'Kepuasan (1–10)',
              value: _rating,
              onChanged: (v) => setState(() => _rating = v),
            ),
            const SizedBox(height: 8),
            _buildSlider(
              label: 'Tingkat Kesulitan (1–10)',
              value: _difficulty,
              onChanged: (v) => setState(() => _difficulty = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Komentar (opsional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            _saveExamResult(context);
            Navigator.pushNamed(context, '/review', 
              arguments: widget.examProvider.currentExam?.id);
          },
          icon: const Icon(Icons.check, color: Colors.black),
          label: const Text('Review Jawaban'),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.theme.backgroundColor,
            foregroundColor: widget.theme.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.theme.mediumRadius),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            _saveExamResult(context);
            widget.examProvider.resetExam();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          },
          icon: const Icon(Icons.home),
          label: const Text('Simpan & Kembali'),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.theme.primaryColor,
            foregroundColor: widget.theme.defaultColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.theme.mediumRadius),
            ),
          ),
        ),
      ],
    );
  }

  // Method untuk menyimpan hasil ujian
  void _saveExamResult(BuildContext context) {
    final resultProvider = Provider.of<ResultProvider>(
      context,
      listen: false,
    );
    final examProvider = Provider.of<ExamProvider>(
      context,
      listen: false,
    );
    final exam = examProvider.currentExam;

    if (exam != null) {
      final results = examProvider.calculateResults();
      final correctAnswersMap = {
        for (var q in exam.questions) q.id: q.correctAnswer,
      };

      final examResult = ExamResult(
        examId: exam.id,
        examTitle: exam.title,
        dateTaken: DateTime.now(),
        correctAnswers: results['correct'] ?? 0,
        totalQuestions: results['total'] ?? 0,
        answeredQuestions: results['answered'] ?? 0,
        flaggedQuestions: results['flagged'] ?? 0,
        scorePercentage: results['percentage'] ?? 0.0,
        userAnswers: examProvider.getUserAnswersForExam(exam.id),
        correctAnswer: correctAnswersMap,
        incorrectQuestionIds: List<String>.from(
          results['incorrectQuestionIds'] ?? [],
        ),
        rating: _rating,
        difficulty: _difficulty,
        comment: _commentController.text,
      );

      resultProvider.addResult(examResult);
    }
  }

  Widget _buildScoreCircle(double percentage) {
    Color circleColor =
        percentage >= 70
            ? Colors.green
            : percentage >= 50
                ? Colors.amber
                : Colors.red;

    return Container(
      padding: EdgeInsets.all(widget.theme.largeSpace),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor.withOpacity(0.1),
        border: Border.all(color: circleColor, width: 3),
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

  Widget _buildSlider({
    required String label,
    required double value,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: widget.theme.textColor)),
        Slider(
          value: value,
          min: 1,
          max: 10,
          divisions: 9,
          label: value.toStringAsFixed(0),
          activeColor: widget.theme.primaryColor,
          onChanged: onChanged,
        ),
      ],
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
    final hasAnswer =
        examProvider.getQuestionAnswer(exam.questions[index].id) != null;

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
            color:
                isCurrentQuestion
                    ? theme.primaryColor
                    : hasAnswer
                    ? theme.backgroundColor.withOpacity(0.5)
                    : theme.backgroundColor.withOpacity(0.2),
            border: Border.all(
              color:
                  isCurrentQuestion
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
                color: isCurrentQuestion ? theme.defaultColor : theme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

