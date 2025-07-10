import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/message_provider.dart';
import 'package:rucas_exam_project/provider/page_provider.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';
import 'package:rucas_exam_project/provider/text_scale_provider.dart';
import 'package:rucas_exam_project/provider/user_provider.dart';
import 'package:rucas_exam_project/screens/ForgotPassword.dart';
import 'package:rucas_exam_project/screens/exam_screen.dart';
import 'package:rucas_exam_project/screens/home.dart';
import 'package:rucas_exam_project/screens/inbox_screen.dart';
import 'package:rucas_exam_project/screens/list_exam.dart';
import 'package:rucas_exam_project/screens/login.dart';
import 'package:rucas_exam_project/screens/register.dart';
import 'package:rucas_exam_project/screens/promotion_detail.dart';
import 'package:rucas_exam_project/screens/profile_screen.dart';
import 'package:rucas_exam_project/screens/exam_review_screen.dart';
import 'screens/exam_result_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => ExamProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TextScaleProvider()),
        ChangeNotifierProvider(create: (_) => ResultProvider()),
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
      home: AnimatedSplashScreen(
        duration: 2500,
        splash: const SplashContent(),
        nextScreen: const LoginScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        curve: Curves.easeInOutQuint,
        splashIconSize: MediaQuery.of(context).size.height,
        animationDuration: const Duration(milliseconds: 1200),
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/notification': (context) => InboxScreen(),
        '/list-exam': (context) => ListExamScreen(),
        '/ForgotPassword': (context) => ForgotPasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
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
            builder: (context) =>
                PromotionDetail(promotion: settings.arguments as Promotion),
          );
        }
        if (settings.name == '/exam_result') {
          final examId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ExamResultScreen(examId: examId),
          );
        }
        if(settings.name == '/review'){
          final examId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ExamReviewScreen(examId: examId),
          );
        }
        return null;
      },
    );
  }
}