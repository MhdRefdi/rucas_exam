import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';

class GreetingSection extends StatelessWidget {
  final AppTheme theme = AppTheme();

  GreetingSection({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.largeSpace, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo, Selamat Datang!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.defaultColor,
            ),
          ),
          SizedBox(height: theme.smallSpace),
          Text(
            "Siap untuk belajar hari ini?",
            style: TextStyle(fontSize: 16, color: theme.defaultColor),
          ),
          SizedBox(height: theme.largeSpace),
        ],
      ),
    );
  }
}
