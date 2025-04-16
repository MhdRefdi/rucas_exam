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
  FocusNode _focusNode = FocusNode();
  late Color _activeColor;

  @override
  void initState() {
    super.initState();
    _activeColor = const Color(0xFFD5D5D5); // default color before focus
    _focusNode.addListener(() {
      setState(() {
        _activeColor = _focusNode.hasFocus
            ? widget.theme.primaryColor
            : const Color(0xFFD5D5D5);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
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
              decoration: BoxDecoration(
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
                  child: LoginForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
