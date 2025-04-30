import 'package:flutter/material.dart';

class AppTheme {
  final Color defaultColor;
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final double smallSpace;
  final double mediumSpace;
  final double largeSpace;
  final double mediumRadius;
  final double largeRadius;

  const AppTheme({
    this.defaultColor = Colors.white,
    this.primaryColor = const Color(0xFF39AAE0),
    this.backgroundColor = const Color(0xFF87CEEB),
    this.textColor = const Color(0xFF2C3E50),
    this.smallSpace = 8.0,
    this.mediumSpace = 16.0,
    this.largeSpace = 24.0,
    this.mediumRadius = 16.0,
    this.largeRadius = 30.0,
  });
}
