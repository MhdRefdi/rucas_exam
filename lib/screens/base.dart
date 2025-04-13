import 'package:flutter/material.dart';
import 'package:rucas_exam_project/screens/home.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int pageIndex = 0;

  // Styling yang akan dikirim ke halaman
  final Color defaultColor = Colors.white;
  final Color primaryColor = const Color(0xFF39AAE0);
  final Color backgroundColor = const Color(0xFF87CEEB);
  final Color textColor = const Color(0xFF2C3E50);
  final double smallSpace = 8.0;
  final double mediumSpace = 16.0;
  final double largeSpace = 24.0;
  final double mediumRadius = 16.0;
  final double largeRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        defaultColor: defaultColor,
        primaryColor: primaryColor,
        backgroundColor: backgroundColor,
        textColor: textColor,
        smallSpace: smallSpace,
        mediumSpace: mediumSpace,
        largeSpace: largeSpace,
        mediumRadius: mediumRadius,
        largeRadius: largeRadius,
      ),
      const Center(child: Text("Daftar ujian")),
      const Center(child: Text("Hasil ujian")),
      const Center(child: Text("Akun saya")),
    ];

    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.cyan,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Daftar Ujian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Hasil ujian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Akun saya',
          ),
        ],
      ),
    );
  }
}
