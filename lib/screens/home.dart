import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/Home/greeting_section.dart';
import 'package:rucas_exam_project/widgets/Home/search_section.dart';
import 'package:rucas_exam_project/widgets/home/promotion_section.dart';
import 'package:rucas_exam_project/widgets/home/exam_section.dart';

class HomeScreen extends StatelessWidget {
  final AppTheme theme;
  final VoidCallback? onSeeAllExams;

  const HomeScreen({
    super.key,
    this.theme = const AppTheme(),
    this.onSeeAllExams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: theme.defaultColor),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: theme.defaultColor),
            onPressed: () {
              Navigator.of(context).pushNamed('/notification');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/icon-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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
                      SearchSection(),
                      SizedBox(height: theme.largeSpace),
                      ExamSection(onSeeAll: onSeeAllExams),
                      SizedBox(height: theme.largeSpace),
                      PromotionSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
