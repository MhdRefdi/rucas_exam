import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/message_provider.dart';
import 'package:rucas_exam_project/provider/page_provider.dart';
import 'package:rucas_exam_project/provider/text_scale_provider.dart';
import 'package:rucas_exam_project/provider/user_provider.dart';
import 'package:rucas_exam_project/screens/ForgotPassword.dart';
import 'package:rucas_exam_project/screens/activity_page.dart';
import 'package:rucas_exam_project/screens/exam.dart';
import 'package:rucas_exam_project/screens/home.dart';
import 'package:rucas_exam_project/screens/inbox_screen.dart';
import 'package:rucas_exam_project/screens/list_exam.dart';
import 'package:rucas_exam_project/screens/login.dart';
import 'package:rucas_exam_project/screens/register.dart';
import 'package:rucas_exam_project/screens/promotion_detail.dart';
import 'package:rucas_exam_project/screens/profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => ExamProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TextScaleProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/notification': (context) => InboxScreen(),
        '/list-exam': (context) => ListExamScreen(),
        '/ForgotPassword': (context) => ForgotPasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/activity': (context) => const ActivityPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/exam') {
          final examId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ExamScreen(examId: examId),
          );
        }
        if (settings.name == '/promotion') {
          return MaterialPageRoute(
            builder:
                (context) =>
                    PromotionDetail(promotion: settings.arguments as Promotion),
          );
        }
        return null;
      },
    );
  }
}
