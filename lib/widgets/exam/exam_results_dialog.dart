import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

import '../../models/result_model.dart';
import '../../provider/result_provider.dart';

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
            Navigator.pop(context);
            widget.examProvider.reviewMode();
          },
          icon: const Icon(Icons.visibility),
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

              // Create map of correct answers for all questions
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

              debugPrint('Exam result saved: ${examResult.toMap()}');
            }

            examProvider.resetExam();
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
