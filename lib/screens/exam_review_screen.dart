import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/models/result_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80,
                  color: widget.theme.defaultColor,
                ),
                const SizedBox(height: 20),
                Text(
                  'Exam atau hasil tidak ditemukan!',
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.theme.defaultColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 20),
                  label: const Text('Kembali', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.theme.defaultColor,
                    foregroundColor: widget.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                ),
              ],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar custom
          _buildCustomAppBar(context, exam),
          
          // Score display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Nilai Akhir: ${_latestResult!.scorePercentage.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          // Performance stats
          _buildPerformanceHeader(
            context,
            _latestResult!.correctAnswers,
            _latestResult!.totalQuestions,
            _latestResult!.scorePercentage,
            _latestResult!.flaggedQuestions,
          ),

          // Progress indicator
          _buildProgressIndicator(exam.questions.length),

          // Main question card
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _ReviewQuestionCard(
                      theme: widget.theme,
                      question: currentQuestion,
                      userAnswer: userAnswer,
                      correctAnswer: correctAnswer,
                      isCorrect: isCorrect,
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(context, exam),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context, exam) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          IconButton(
            icon: Icon(Icons.arrow_back, 
                color: widget.theme.defaultColor, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Ujian',
                  style: TextStyle(
                    color: widget.theme.defaultColor.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  exam.title,
                  style: TextStyle(
                    color: widget.theme.defaultColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.home, 
                color: widget.theme.defaultColor, size: 24),
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
    );
  }

  Widget _buildProgressIndicator(int totalQuestions) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.theme.primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '${_currentQuestionIndex + 1}',
              style: TextStyle(
                color: widget.theme.defaultColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / totalQuestions,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.theme.primaryColor,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'dari $totalQuestions',
            style: TextStyle(
              color: widget.theme.textColor.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, exam) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentQuestionIndex > 0
                    ? widget.theme.primaryColor
                    : Colors.grey.withOpacity(0.3),
                foregroundColor: _currentQuestionIndex > 0
                    ? widget.theme.defaultColor
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _currentQuestionIndex > 0
                  ? () => _jumpToQuestion(_currentQuestionIndex - 1)
                  : null,
              icon: const Icon(Icons.arrow_back, size: 20),
              label: const Text('Sebelumnya', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentQuestionIndex < exam.questions.length - 1
                    ? widget.theme.primaryColor
                    : Colors.grey.withOpacity(0.3),
                foregroundColor: _currentQuestionIndex < exam.questions.length - 1
                    ? widget.theme.defaultColor
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _currentQuestionIndex < exam.questions.length - 1
                  ? () => _jumpToQuestion(_currentQuestionIndex + 1)
                  : null,
              icon: const Icon(Icons.arrow_forward, size: 20),
              label: const Text('Selanjutnya', style: TextStyle(fontSize: 16)),
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.check_circle,
                'Benar',
                '$correctCount',
                Colors.green,
                true,
                iconSize: 20,
              ),
              _buildStatItem(
                Icons.cancel,
                'Salah',
                '${totalQuestions - correctCount}',
                Colors.red,
                true,
                iconSize: 20,
              ),
              _buildStatItem(
                Icons.flag,
                'Ditandai',
                '$flaggedCount',
                Colors.orange,
                true,
                iconSize: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.score,
                'Nilai',
                '${scorePercentage.toStringAsFixed(1)}%',
                Colors.blue,
                true,
                iconSize: 20,
              ),
              _buildStatItem(
                Icons.history,
                'Percobaan',
                '$attemptsCount',
                Colors.blue,
                false,
                iconSize: 18,
              ),
              if (_latestResult!.rating != null && _latestResult!.rating! > 0)
                _buildStatItem(
                  Icons.star,
                  'Rating',
                  '${_latestResult!.rating}/10',
                  Colors.amber,
                  false,
                  iconSize: 18,
                )
              else
                const SizedBox(width: 80),
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
    bool isMainStat, {
    double iconSize = 16,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: iconSize),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: isMainStat ? 14 : 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: isMainStat ? 11 : 10,
            color: widget.theme.textColor.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textColor,
              ),
            ),
          ),
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
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
                color: bgColor,
              ),
              child: ListTile(
                dense: false,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                minLeadingWidth: 24,
                leading: Text(
                  optionKey,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                    fontSize: 16,
                  ),
                ),
                title: Text(
                  optionText,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                trailing: icon != null 
                    ? Icon(icon, color: iconColor, size: 20)
                    : null,
              ),
            );
          }).toList(),
          if (question.solution != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Pembahasan: ${question.solution!}',
                style: TextStyle(
                  color: theme.textColor.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}