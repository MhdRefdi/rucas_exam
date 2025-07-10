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

class _ExamReviewScreenState extends State<ExamReviewScreen>
    with TickerProviderStateMixin {
  late ExamResult? _latestResult;
  int _currentQuestionIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultProvider = Provider.of<ResultProvider>(
        context,
        listen: false,
      );
      _latestResult = resultProvider.getLatestResultForExam(widget.examId);
      setState(() {});
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _jumpToQuestion(int index) {
    _animationController.reset();
    setState(() {
      _currentQuestionIndex = index;
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final resultProvider = Provider.of<ResultProvider>(context);
    final examProvider = Provider.of<ExamProvider>(context);
    final exam = examProvider.getExamById(widget.examId);

    if (exam == null || _latestResult == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                widget.theme.primaryColor.withOpacity(0.8),
                widget.theme.primaryColor.withOpacity(0.6),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: widget.theme.defaultColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Exam atau hasil tidak ditemukan!',
                    style: TextStyle(
                      fontSize: 18,
                      color: widget.theme.defaultColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Kembali'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.theme.defaultColor,
                      foregroundColor: widget.theme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final currentQuestion = exam.questions[_currentQuestionIndex];
    final userAnswer = _latestResult!.userAnswers[currentQuestion.id];
    final correctAnswer = _latestResult!.correctAnswer[currentQuestion.id];
    final isCorrect = userAnswer == correctAnswer;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.theme.primaryColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar custom tetap paling atas
              _buildCustomAppBar(context, exam),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Nilai Akhir: ${_latestResult!.scorePercentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 16, // Sama seperti Benar/Salah
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),

              // Benar, Salah, Ragu
              _buildPerformanceHeader(
                context,
                _latestResult!.correctAnswers,
                _latestResult!.totalQuestions,
                _latestResult!.scorePercentage,
                _latestResult!.flaggedQuestions,
              ),

              // Progress indicator
              _buildProgressIndicator(exam.questions.length),

              // Main question card diperkecil
              Expanded(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              child: _ReviewQuestionCard(
                                theme: widget.theme,
                                question: currentQuestion,
                                userAnswer: userAnswer,
                                correctAnswer: correctAnswer,
                                isCorrect: isCorrect,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Tombol navigasi
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: _buildNavigationButtons(context, exam),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context, exam) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.theme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.theme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.theme.defaultColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: widget.theme.defaultColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Ujian',
                  style: TextStyle(
                    color: widget.theme.defaultColor.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  exam.title,
                  style: TextStyle(
                    color: widget.theme.defaultColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.theme.defaultColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.home, color: widget.theme.defaultColor),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int totalQuestions) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: widget.theme.primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '${_currentQuestionIndex + 1}',
              style: TextStyle(
                color: widget.theme.defaultColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / totalQuestions,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.theme.primaryColor,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'dari $totalQuestions',
            style: TextStyle(
              color: widget.theme.textColor.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, exam) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient:
                    _currentQuestionIndex > 0
                        ? LinearGradient(
                          colors: [
                            widget.theme.primaryColor.withOpacity(0.8),
                            widget.theme.primaryColor,
                          ],
                        )
                        : null,
                color:
                    _currentQuestionIndex > 0
                        ? null
                        : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
                boxShadow:
                    _currentQuestionIndex > 0
                        ? [
                          BoxShadow(
                            color: widget.theme.primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ]
                        : [],
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed:
                    _currentQuestionIndex > 0
                        ? () => _jumpToQuestion(_currentQuestionIndex - 1)
                        : null,
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      _currentQuestionIndex > 0
                          ? widget.theme.defaultColor
                          : Colors.grey,
                ),
                label: Text(
                  'Sebelumnya',
                  style: TextStyle(
                    color:
                        _currentQuestionIndex > 0
                            ? widget.theme.defaultColor
                            : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient:
                    _currentQuestionIndex < exam.questions.length - 1
                        ? LinearGradient(
                          colors: [
                            widget.theme.primaryColor,
                            widget.theme.primaryColor.withOpacity(0.8),
                          ],
                        )
                        : null,
                color:
                    _currentQuestionIndex < exam.questions.length - 1
                        ? null
                        : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
                boxShadow:
                    _currentQuestionIndex < exam.questions.length - 1
                        ? [
                          BoxShadow(
                            color: widget.theme.primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ]
                        : [],
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed:
                    _currentQuestionIndex < exam.questions.length - 1
                        ? () => _jumpToQuestion(_currentQuestionIndex + 1)
                        : null,
                icon: Icon(
                  Icons.arrow_forward,
                  color:
                      _currentQuestionIndex < exam.questions.length - 1
                          ? widget.theme.defaultColor
                          : Colors.grey,
                ),
                label: Text(
                  'Selanjutnya',
                  style: TextStyle(
                    color:
                        _currentQuestionIndex < exam.questions.length - 1
                            ? widget.theme.defaultColor
                            : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PERFORMANCE HEADER - DIPERKECIL
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Row pertama (3 stat)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.check_circle,
                'Benar',
                '$correctCount',
                Colors.green,
                true,
              ),
              _buildStatItem(
                Icons.cancel,
                'Salah',
                '${totalQuestions - correctCount}',
                Colors.red,
                true,
              ),
              _buildStatItem(
                Icons.flag,
                'Ditandai',
                '$flaggedCount',
                Colors.orange,
                true,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Row kedua (3 stat tambahan)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.score,
                'Nilai',
                '${scorePercentage.toStringAsFixed(1)}%',
                Colors.blue,
                true,
              ),
              _buildStatItem(
                Icons.history,
                'Percobaan',
                '$attemptsCount',
                Colors.blue,
                false,
              ),
              if (_latestResult!.rating != null && _latestResult!.rating! > 0)
                _buildStatItem(
                  Icons.star,
                  'Rating',
                  '${_latestResult!.rating}/10',
                  Colors.amber,
                  false,
                )
              else
                // Jika tidak ada rating, placeholder supaya rata
                const SizedBox(width: 64),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String label,
    String value,
    Color color,
    bool isMainStat,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: isMainStat ? 16 : 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isMainStat ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: isMainStat ? 9 : 8,
            color: widget.theme.textColor.withOpacity(0.6),
            fontWeight: FontWeight.w500,
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

// QUESTION CARD - DIPERBESAR DAN TANPA SCROLL
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
    return Container(
      // Card dibesarkan
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(8), // padding luar card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withOpacity(0.1),
                  theme.primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.quiz, color: theme.defaultColor, size: 12),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Pertanyaan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question text
                Text(
                  question.question,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.textColor,
                    height: 1.3,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Options (A-D)
                ...question.options.entries.map((entry) {
                  final optionKey = entry.key;
                  final optionText = entry.value;
                  final isUserAnswer = userAnswer == optionKey;
                  final isActuallyCorrect = correctAnswer == optionKey;

                  Color borderColor = Colors.grey.withOpacity(0.3);
                  Color bgColor = Colors.transparent;
                  IconData? icon;
                  Color iconColor = Colors.transparent;
                  String statusText = '';

                  if (isUserAnswer && isActuallyCorrect) {
                    borderColor = Colors.green;
                    bgColor = Colors.green.withOpacity(0.1);
                    icon = Icons.check_circle;
                    iconColor = Colors.green;
                    statusText = 'Benar';
                  } else if (isUserAnswer && !isActuallyCorrect) {
                    borderColor = Colors.red;
                    bgColor = Colors.red.withOpacity(0.1);
                    icon = Icons.cancel;
                    iconColor = Colors.red;
                    statusText = 'Salah';
                  } else if (isActuallyCorrect) {
                    borderColor = Colors.green;
                    bgColor = Colors.green.withOpacity(0.1);
                    icon = Icons.check_circle;
                    iconColor = Colors.green;
                    statusText = 'Benar';
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: bgColor,
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 0,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          optionKey,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      title: Text(
                        optionText,
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing:
                          icon != null
                              ? Icon(icon, color: iconColor, size: 14)
                              : null,
                      subtitle:
                          statusText.isNotEmpty
                              ? Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: iconColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                              : null,
                    ),
                  );
                }).toList(),

                // Explanation
                if (question.solution != null)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.1),
                          Colors.blue.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      question.solution!,
                      style: TextStyle(
                        color: theme.textColor,
                        fontSize: 9,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AnswerStatus { unanswered, correct, incorrect }
