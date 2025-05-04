import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final Color _defaultColor = Color(0xFFD5D5D5);
  final Color _activeColor = Color(0xFF39AAE0);
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Color _getLabelColor(FocusNode focusNode) {
    return focusNode.hasFocus ? _activeColor : _defaultColor;
  }

  @override
  void initState() {
    super.initState();

    _nameFocusNode.addListener(() {
      setState(() {});
    });
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
    _confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: _nameFocusNode,
          cursorColor: _getLabelColor(_nameFocusNode),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: _getLabelColor(_nameFocusNode),
            ),
            labelText: 'Nama',
            labelStyle: TextStyle(color: _getLabelColor(_nameFocusNode)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _defaultColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _getLabelColor(_nameFocusNode)),
            ),
          ),
        ),
        SizedBox(height: 10),
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
        SizedBox(height: 10),
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
        SizedBox(height: 10),
        TextField(
          focusNode: _confirmPasswordFocusNode,
          cursorColor: _getLabelColor(_confirmPasswordFocusNode),
          obscureText: !_isConfirmPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: _getLabelColor(_confirmPasswordFocusNode),
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: _getLabelColor(_confirmPasswordFocusNode),
            ),
            labelText: 'Ulangi Password',
            labelStyle: TextStyle(
              color: _getLabelColor(_confirmPasswordFocusNode),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _defaultColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _getLabelColor(_confirmPasswordFocusNode),
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
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: Text(
            'Daftar',
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
            backgroundColor: Colors.orange,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              // side: BorderSide(
              //   color: _defaultColor,
              // ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: Text(
            'Masuk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
