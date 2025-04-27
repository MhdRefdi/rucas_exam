import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/provider/exam_provider.dart';
import 'package:rucas_exam_project/widgets/exam/exam_progress_indicator.dart';
import 'package:rucas_exam_project/widgets/exam/question_navigation.dart';
import 'package:rucas_exam_project/widgets/exam/question_card.dart';
import 'package:rucas_exam_project/widgets/exam/exam_navigation_buttons.dart';
import 'package:rucas_exam_project/widgets/exam/unanswered_questions_dialog.dart';
import 'package:rucas_exam_project/widgets/exam/exam_results_dialog.dart';

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
        builder: (context) => UnansweredQuestionsDialog(
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
      builder: (context) => ExamResultsDialog(
        theme: widget.theme,
        results: results,
        examProvider: examProvider,
      ),
    );
  }
}