import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final Color _defaultColor = Color(0xFFD5D5D5);
  final Color _activeColor = Color(0xFF39AAE0);
  bool _isPasswordVisible = false;

  Color _getLabelColor(FocusNode focusNode) {
    return focusNode.hasFocus ? _activeColor : _defaultColor;
  }

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: _emailFocusNode,
          cursorColor: _getLabelColor(_emailFocusNode),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: _getLabelColor(_emailFocusNode),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: _getLabelColor(_emailFocusNode)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _defaultColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _getLabelColor(_emailFocusNode)),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          focusNode: _passwordFocusNode,
          cursorColor: _getLabelColor(_passwordFocusNode),
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: _getLabelColor(_passwordFocusNode),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: _getLabelColor(_passwordFocusNode),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: _getLabelColor(_passwordFocusNode)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _defaultColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _getLabelColor(_passwordFocusNode)),
            ),
          ),
        ),
        SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Lupa Password?',
              style: TextStyle(
                color: _activeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _activeColor,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          child: Text(
            'Masuk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: _defaultColor, // Warna garis
                thickness: 1, // Ketebalan garis
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ), // Jarak antara garis dan teks
              child: Text(
                "Atau",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Expanded(child: Divider(color: _defaultColor, thickness: 1)),
          ],
        ),
        SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: _defaultColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/register');
          },
          child: Text(
            'Daftar',
            style: TextStyle(color: _defaultColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
