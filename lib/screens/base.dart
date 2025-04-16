import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/models/provider/page_provider.dart';
import 'package:rucas_exam_project/screens/home.dart';

class BaseScreen extends StatelessWidget {
   BaseScreen({super.key});

  final Color defaultColor = Colors.white;
  final Color primaryColor = Color(0xFF39AAE0);
  final Color backgroundColor = Color(0xFF87CEEB);
  final Color textColor = Color(0xFF2C3E50);
  final double smallSpace = 8.0;
  final double mediumSpace = 16.0;
  final double largeSpace = 24.0;
  final double mediumRadius = 16.0;
  final double largeRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    final pageIndex = pageProvider.pageIndex;

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
        onSeeAllExams: () {
          pageProvider.setPageIndex(1);
        },
      ),
      const Center(child: Text("Daftar ujian")),
      const Center(child: Text("Hasil ujian")),
      const Center(child: Text("Akun saya")),
    ];

    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: defaultColor,
        currentIndex: pageIndex,
        onTap: (index) {
          pageProvider.setPageIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: backgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Daftar Ujian'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Hasil ujian'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Akun saya'),
        ],
      ),
    );
  }
}
