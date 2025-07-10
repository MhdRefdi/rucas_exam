import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/result_model.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();
    final resultProvider = Provider.of<ResultProvider>(context);
    final results = resultProvider.results;

    return Scaffold(
      backgroundColor: theme.defaultColor,
      appBar: AppBar(
        title: const Text(
          'Riwayat Ujian',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.defaultColor,
      ),
      body: results.isEmpty
          ? _buildEmptyState(context, theme)
          : Column(
              children: [
                // Header statistics
                _buildStatisticsHeader(resultProvider, theme),
                // Results list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    itemCount: results.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final result = results.reversed.toList()[index];
                      return _buildResultCard(result, theme, index == 0);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatisticsHeader(ResultProvider resultProvider, AppTheme theme) {
    final totalExams = resultProvider.results.length;
    final averageScore = totalExams > 0
        ? resultProvider.results
                .fold(0.0, (sum, result) => sum + result.scorePercentage) /
            totalExams
        : 0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.defaultColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.textColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.assignment_turned_in,
            iconColor: Colors.green,
            title: 'Total Ujian',
            count: '$totalExams',
            theme: theme,
          ),
          Container(width: 1, height: 40, color: Colors.grey[300]),
          _buildStatItem(
            icon: Icons.star_rate,
            iconColor: Colors.amber,
            title: 'Rata-rata',
            count: '${averageScore.toStringAsFixed(1)}%',
            theme: theme,
          ),
          Container(width: 1, height: 40, color: Colors.grey[300]),
          _buildStatItem(
            icon: Icons.flag,
            iconColor: Colors.orange,
            title: 'Ditandai',
            count: '${resultProvider.results.fold(0, (sum, result) => sum + result.flaggedQuestions)}',
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String count,
    required AppTheme theme,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.textColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: theme.textColor.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(ExamResult result, AppTheme theme, bool isLatest) {
    final dateFormatted = "${result.dateTaken.day}/${result.dateTaken.month}/${result.dateTaken.year}";
    final timeFormatted = "${result.dateTaken.hour}:${result.dateTaken.minute.toString().padLeft(2, '0')}";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.defaultColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.textColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: isLatest
            ? Border.all(color: theme.primaryColor.withOpacity(0.3), width: 1)
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getScoreColor(result.scorePercentage).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              result.scorePercentage >= 70
                  ? Icons.check_circle
                  : result.scorePercentage >= 50
                      ? Icons.warning
                      : Icons.error,
              color: _getScoreColor(result.scorePercentage),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.examTitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "${result.correctAnswers}/${result.totalQuestions} jawaban benar",
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 12, color: theme.textColor.withOpacity(0.5)),
                    const SizedBox(width: 4),
                    Text(
                      dateFormatted,
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.textColor.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time,
                        size: 12, color: theme.textColor.withOpacity(0.5)),
                    const SizedBox(width: 4),
                    Text(
                      timeFormatted,
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.textColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getScoreColor(result.scorePercentage)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${result.scorePercentage.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(result.scorePercentage),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              if (isLatest)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Terbaru',
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppTheme theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 64,
            color: theme.textColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum Ada Riwayat Ujian',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.textColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Setelah mengerjakan ujian, hasilnya akan muncul di sini',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: theme.textColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/list-exam');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.defaultColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Mulai Ujian Sekarang'),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }
}