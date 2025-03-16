import 'package:flutter/material.dart';
import 'package:rucas_exam_project/pages/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
            '/': (context) => Login(),
        },
    );
  }
}
