import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/Home/greeting_section.dart';
import 'package:rucas_exam_project/widgets/home/promotion_section.dart';
import 'package:rucas_exam_project/widgets/home/exam_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onSeeAllExams;

  const HomeScreen({super.key, this.onSeeAllExams});

  @override
  Widget build(BuildContext context) {
    final theme = const AppTheme();

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
                    _buildLearningProgressCard(theme),
                    SizedBox(height: theme.largeSpace),
                    _buildRecentActivityCard(theme),
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

  Widget _buildLearningProgressCard(AppTheme theme) {
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
                'Progress Belajar Minggu Ini',
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
                  '78%',
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
            value: 0.78,
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
                value: '12',
                icon: Icons.check_circle_outline,
                color: Colors.green,
              ),
              _buildProgressItem(
                theme: theme,
                label: 'Berlangsung',
                value: '3',
                icon: Icons.play_circle_outline,
                color: Colors.orange,
              ),
              _buildProgressItem(
                theme: theme,
                label: 'Tersisa',
                value: '5',
                icon: Icons.pending_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ],
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

  Widget _buildRecentActivityCard(AppTheme theme) {
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
                onPressed: () {},
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
          _buildActivityItem(
            theme: theme,
            title: 'Ujian Matematika Dasar',
            subtitle: 'Selesai dengan skor 85',
            time: '2 jam lalu',
            icon: Icons.assignment_turned_in,
            iconColor: Colors.green,
          ),
          Divider(height: 16, color: theme.textColor.withOpacity(0.1)),
          _buildActivityItem(
            theme: theme,
            title: 'Belajar Fisika - Gerak Lurus',
            subtitle: 'Progress 60% selesai',
            time: '5 jam lalu',
            icon: Icons.play_circle_filled,
            iconColor: Colors.blue,
          ),
          Divider(height: 16, color: theme.textColor.withOpacity(0.1)),
          _buildActivityItem(
            theme: theme,
            title: 'Latihan Soal Kimia',
            subtitle: 'Mencoba 15 soal',
            time: '1 hari lalu',
            icon: Icons.quiz,
            iconColor: Colors.orange,
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
        Text(
          time,
          style: TextStyle(
            fontSize: 11,
            color: theme.textColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}