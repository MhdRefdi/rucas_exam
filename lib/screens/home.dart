import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/Home/greeting_section.dart';
import 'package:rucas_exam_project/widgets/Home/search_section.dart';
import 'package:rucas_exam_project/widgets/home/banner_section.dart';
import 'package:rucas_exam_project/widgets/home/exam_section.dart';

class HomeScreen extends StatelessWidget {
  final Color defaultColor;
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final double smallSpace;
  final double mediumSpace;
  final double largeSpace;
  final double mediumRadius;
  final double largeRadius;

  const HomeScreen({
    super.key,
    required this.defaultColor,
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.smallSpace,
    required this.mediumSpace,
    required this.largeSpace,
    required this.mediumRadius,
    required this.largeRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: defaultColor),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: defaultColor),
            onPressed: () {
              Navigator.of(context).pushNamed('/notification');
            },
          )
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
                GreetingSection(
                  textColor: textColor,
                  defaultColor: defaultColor,
                  smallSpace: smallSpace,
                  largeSpace: largeSpace,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mediumSpace,
                    vertical: largeSpace,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(largeRadius),
                      topRight: Radius.circular(largeRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: textColor.withOpacity(0.1),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchSection(
                        textColor: textColor,
                        primaryColor: primaryColor,
                      ),
                      SizedBox(height: largeSpace),
                      ExamSection(
                        textColor: textColor,
                        defaultColor: defaultColor,
                        primaryColor: primaryColor,
                        mediumSpace: mediumSpace,
                        mediumRadius: mediumRadius,
                      ),
                      SizedBox(height: largeSpace),
                      PromotionSection(
                        textColor: textColor,
                        mediumSpace: mediumSpace,
                      ),
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
