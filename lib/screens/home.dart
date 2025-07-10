import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/result_model.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';
import 'package:rucas_exam_project/widgets/Home/greeting_section.dart';
import 'package:rucas_exam_project/widgets/home/promotion_section.dart';
import 'package:rucas_exam_project/widgets/home/exam_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onSeeAllExams;

  const HomeScreen({super.key, this.onSeeAllExams});

  @override
  Widget build(BuildContext context) {
    final theme = const AppTheme();
    final resultProvider = Provider.of<ResultProvider>(context, listen: true);
    final recentResults = resultProvider.results.isNotEmpty
        ? resultProvider.results
            .take(3)
            .toList()
            .reversed
            .toList() // Get latest 3 results
        : [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/icon-background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              GreetingSection(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.mediumSpace,
                  vertical: theme.largeSpace,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.defaultColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.largeRadius),
                    topRight: Radius.circular(theme.largeRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.textColor.withOpacity(0.1),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExamSection(onSeeAll: onSeeAllExams),
                    SizedBox(height: theme.largeSpace),
                    _buildQuickActionsSection(theme),
                    SizedBox(height: theme.largeSpace),
                    _buildLearningProgressCard(theme, resultProvider),
                    SizedBox(height: theme.largeSpace),
                    _buildRecentActivityCard(context, theme, resultProvider.results),
                    SizedBox(height: theme.largeSpace),
                    PromotionSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aksi Cepat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.textColor,
          ),
        ),
        SizedBox(height: theme.smallSpace),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                theme: theme,
                icon: Icons.quiz_outlined,
                title: 'Latihan Soal',
                subtitle: 'Kerjakan soal harian',
                color: Colors.blue,
                onTap: () {},
              ),
            ),
            SizedBox(width: theme.smallSpace),
            Expanded(
              child: _buildQuickActionCard(
                theme: theme,
                icon: Icons.school_outlined,
                title: 'Materi Belajar',
                subtitle: 'Akses semua materi',
                color: Colors.green,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLearningProgressCard(AppTheme theme, ResultProvider resultProvider) {
    final totalExams = resultProvider.results.length;
    final completedExams = totalExams;
    final averageScore = totalExams > 0
        ? resultProvider.results
                .fold(0.0, (sum, result) => sum + result.scorePercentage) /
            totalExams
        : 0;

    return Container(
      padding: EdgeInsets.all(theme.mediumSpace),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withOpacity(0.1),
            theme.primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(theme.mediumRadius),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress Belajar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${averageScore.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.defaultColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: theme.smallSpace),
          LinearProgressIndicator(
            value: totalExams > 0 ? (completedExams / (completedExams + 5)) : 0,
            backgroundColor: theme.primaryColor.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            minHeight: 6,
          ),
          SizedBox(height: theme.smallSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressItem(
                theme: theme,
                label: 'Selesai',
                value: '$completedExams',
                icon: Icons.check_circle_outline,
                color: Colors.green,
              ),
              _buildProgressItem(
                theme: theme,
                label: 'Rata-rata',
                value: '${averageScore.toStringAsFixed(1)}%',
                icon: Icons.star_rate,
                color: Colors.amber,
              ),
              _buildProgressItem(
                theme: theme,
                label: 'Total',
                value: '$totalExams',
                icon: Icons.library_books,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard(
      BuildContext context, AppTheme theme, List<ExamResult> recentResults) {
    return Container(
      padding: EdgeInsets.all(theme.mediumSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktivitas Terbaru',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/activity');
                },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: theme.smallSpace),
          if (recentResults.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Belum ada aktivitas ujian',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.textColor.withOpacity(0.6),
                ),
              ),
            )
          else
            Column(
              children: [
                ...recentResults.map((result) {
                  final timeAgo = _getTimeAgo(result.dateTaken);
                  return Column(
                    children: [
                      _buildActivityItem(
                        theme: theme,
                        title: result.examTitle,
                        subtitle:
                            '${result.correctAnswers}/${result.totalQuestions} jawaban benar',
                        time: timeAgo,
                        icon: result.scorePercentage >= 70
                            ? Icons.check_circle
                            : Icons.warning,
                        iconColor: _getScoreColor(result.scorePercentage),
                        score: result.scorePercentage,
                      ),
                      if (result != recentResults.last)
                        Divider(
                            height: 16,
                            color: theme.textColor.withOpacity(0.1)),
                    ],
                  );
                }).toList(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required AppTheme theme,
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color iconColor,
    double? score,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        SizedBox(width: theme.smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.textColor.withOpacity(0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (score != null)
              Text(
                '${score.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(score),
                ),
              ),
            Text(
              time,
              style: TextStyle(
                fontSize: 11,
                color: theme.textColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

 

  Widget _buildQuickActionCard({
    required AppTheme theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(theme.mediumRadius),
      child: Container(
        padding: EdgeInsets.all(theme.mediumSpace),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(theme.mediumRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: theme.smallSpace),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.textColor,
              ),
            ),
            SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: theme.textColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _buildProgressItem({
    required AppTheme theme,
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: theme.textColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
