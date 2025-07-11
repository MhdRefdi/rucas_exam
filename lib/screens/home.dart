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
    final resultProvider = Provider.of<ResultProvider>(context);
    final recentResults = resultProvider.results.isNotEmpty
        ? resultProvider.results.take(3).toList().reversed.toList()
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
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExamSection(onSeeAll: onSeeAllExams),
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

  Widget _buildLearningProgressCard(AppTheme theme, ResultProvider resultProvider) {
    final totalExams = resultProvider.results.length;
    final completedExams = totalExams;
    final averageScore = totalExams > 0
        ? resultProvider.results.fold(0.0, (sum, result) => sum + result.scorePercentage) / totalExams
        : 0;

    return Container(
      padding: EdgeInsets.all(theme.mediumSpace),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.mediumRadius),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress Belajar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textColor)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${averageScore.toStringAsFixed(1)}%',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: theme.smallSpace),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: totalExams > 0 ? (completedExams / (completedExams + 5)) : 0,
              minHeight: 6,
              backgroundColor: theme.primaryColor.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            ),
          ),
          SizedBox(height: theme.smallSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressItem(theme, 'Selesai', '$completedExams', Icons.check_circle_outline, Colors.green),
              _buildProgressItem(theme, 'Rata-rata', '${averageScore.toStringAsFixed(1)}%', Icons.star_rate, Colors.amber),
              _buildProgressItem(theme, 'Total', '$totalExams', Icons.library_books, Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard(BuildContext context, AppTheme theme, List<ExamResult> recentResults) {
    return Container(
      padding: EdgeInsets.all(theme.mediumSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Aktivitas Terbaru',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textColor)),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/activity');
                },
                icon: Icon(Icons.arrow_forward_ios, size: 12, color: theme.primaryColor),
                label: Text('Lihat Semua',
                    style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: theme.smallSpace),
          if (recentResults.isEmpty)
            Column(
              children: [
                Icon(Icons.inbox, size: 48, color: theme.textColor.withOpacity(0.2)),
                SizedBox(height: 8),
                Text(
                  'Belum ada aktivitas ujian',
                  style: TextStyle(fontSize: 14, color: theme.textColor.withOpacity(0.6)),
                ),
              ],
            )
          else
            ...recentResults.map((result) {
              final timeAgo = _getTimeAgo(result.dateTaken);
              return Column(
                children: [
                  _buildActivityItem(
                    theme: theme,
                    title: result.examTitle,
                    subtitle: '${result.correctAnswers}/${result.totalQuestions} jawaban benar',
                    time: timeAgo,
                    icon: result.scorePercentage >= 70 ? Icons.check_circle : Icons.warning,
                    iconColor: _getScoreColor(result.scorePercentage),
                    score: result.scorePercentage,
                  ),
                  if (result != recentResults.last)
                    Divider(height: 16, color: theme.textColor.withOpacity(0.1)),
                ],
              );
            }),
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
          padding: EdgeInsets.all(8),
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
              Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: 2),
              Text(subtitle,
                  style: TextStyle(fontSize: 12, color: theme.textColor.withOpacity(0.6)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (score != null)
              Text('${score.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _getScoreColor(score))),
            Text(time, style: TextStyle(fontSize: 11, color: theme.textColor.withOpacity(0.5))),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressItem(AppTheme theme, String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textColor)),
        Text(label, style: TextStyle(fontSize: 10, color: theme.textColor.withOpacity(0.6))),
      ],
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} bulan lalu';
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
}
