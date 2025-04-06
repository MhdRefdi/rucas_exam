import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/Home/greeting_section.dart';
import 'package:rucas_exam_project/widgets/Home/search_section.dart';
import 'package:rucas_exam_project/widgets/home/banner_section.dart';
import 'package:rucas_exam_project/widgets/home/exam_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color defaultColor = Colors.white;
  final Color primaryColor = const Color(0xFF39AAE0);
  final Color backgroundColor = const Color(0xFF87CEEB);
  final Color textColor = const Color(0xFF2C3E50);
  final double smallSpace = 8.0;
  final double mediumSpace = 16.0;
  final double largeSpace = 24.0;
  final double mediumRadius = 16.0;
  final double largeRadius = 30.0;

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