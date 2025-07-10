import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/models/result_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';

class ExamResultScreen extends StatelessWidget {
  final String examId;

  const ExamResultScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final examProvider = Provider.of<ExamProvider>(context, listen: false);
    final resultProvider = Provider.of<ResultProvider>(context);
    
    final ExamData? exam = examProvider.getExamById(examId);
    final List<ExamResult> results = resultProvider.getResultsForExam(examId);

    if (exam == null || results.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hasil Ujian'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text('Data hasil ujian tidak ditemukan'),
        ),
      );
    }

    // Sort results by date (newest first)
    results.sort((a, b) => b.dateTaken.compareTo(a.dateTaken));
    final latestResult = results.first;

    final wrong = latestResult.totalQuestions - latestResult.correctAnswers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Ujian'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exam Info Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.date_range, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          exam.date,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${exam.duration} menit',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Result Summary
            const Text(
              'Ringkasan Hasil',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Score Card
                Expanded(
                  child: _buildScoreCard(
                    context: context,
                    title: 'Nilai',
                    value: '${latestResult.scorePercentage.toStringAsFixed(1)}%',
                    color: _getScoreColor(latestResult.scorePercentage),
                    icon: Icons.score,
                  ),
                ),
                const SizedBox(width: 12),
                // Correct Answers Card
                Expanded(
                  child: _buildScoreCard(
                    context: context,
                    title: 'Benar',
                    value: '${latestResult.correctAnswers}/${latestResult.totalQuestions}',
                    color: Colors.green,
                    icon: Icons.check_circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Wrong Answers Card
                Expanded(
                  child: _buildScoreCard(
                    context: context,
                    title: 'Salah',
                    value: '$wrong/${latestResult.totalQuestions}',
                    color: Colors.red,
                    icon: Icons.cancel,
                  ),
                ),
                const SizedBox(width: 12),
                // Time Taken Card
                Expanded(
                  child: _buildScoreCard(
                    context: context,
                    title: 'Waktu',
                    value: '${latestResult.dateTaken.minute} menit',
                    color: Colors.blue,
                    icon: Icons.timer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Attempt History
            const Text(
              'Riwayat Percobaan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...results.map((result) => _buildAttemptItem(result)).toList(),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/review',
                        arguments: examId,
                      );
                    },
                    icon: const Icon(Icons.question_answer),
                    label: const Text('Lihat Pembahasan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Retake exam
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/exam',
                        (route) => false,
                        arguments: examId,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Ulangi Ujian'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.primaryColor,
                      side: BorderSide(color: theme.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttemptItem(ExamResult result) {
        final latestResult = result;

    final wrong = latestResult.totalQuestions - latestResult.correctAnswers;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getScoreColor(result.scorePercentage).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${result.scorePercentage.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(result.scorePercentage),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${result.correctAnswers} benar • $wrong salah',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Waktu: ${result.correctAnswers} menit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _formatDate(result.dateTaken),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}