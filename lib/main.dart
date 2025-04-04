import 'package:flutter/material.dart';
import 'package:rucas_exam_project/screens/base.dart';
import 'package:rucas_exam_project/screens/login.dart';
import 'package:rucas_exam_project/screens/notification.dart';
import 'package:rucas_exam_project/screens/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const BaseScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/notification': (context) => const NotificationScreen(),
      },
      home: LoginScreen(),
    );
  }
}
