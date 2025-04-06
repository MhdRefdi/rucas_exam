import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  final Color textColor;
  final Color defaultColor;
  final double smallSpace;
  final double largeSpace;

  const GreetingSection({
    super.key,
    required this.textColor,
    required this.defaultColor,
    required this.smallSpace,
    required this.largeSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: largeSpace, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo, Selamat Datang!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: defaultColor,
            ),
          ),
          SizedBox(height: smallSpace),
          Text(
            "Siap untuk belajar hari ini?",
            style: TextStyle(fontSize: 16, color: defaultColor),
          ),
          SizedBox(height: largeSpace),
        ],
      ),
    );
  }
}
