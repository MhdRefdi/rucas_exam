import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/login_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginCard(),
      ),
    );
  }
}
