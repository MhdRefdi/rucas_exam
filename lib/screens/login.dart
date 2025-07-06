import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  final AppTheme theme;

  const LoginScreen({super.key, this.theme = const AppTheme()});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final message = ModalRoute.of(context)?.settings.arguments as String?;
    if (message != null && message.isNotEmpty) {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/icon-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: Svg('assets/images/wave.svg'),
                  alignment: Alignment.bottomCenter,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  theme.mediumSpace,
                  80,
                  theme.mediumSpace,
                  0,
                ),
                child: Text(
                  "Selamat Datang\nKembali",
                  style: TextStyle(
                    color: theme.defaultColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: theme.defaultColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: theme.mediumSpace),
                  child: const LoginForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
