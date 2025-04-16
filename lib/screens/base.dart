import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/provider/page_provider.dart';
import 'package:rucas_exam_project/screens/home.dart';

class BaseScreen extends StatelessWidget {
  final AppTheme theme;

  const BaseScreen({
    super.key,
    this.theme = const AppTheme(),
  });

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    final pageIndex = pageProvider.pageIndex;

    final List<Widget> pages = [
      HomeScreen(
        defaultColor: theme.defaultColor,
        primaryColor: theme.primaryColor,
        backgroundColor: theme.backgroundColor,
        textColor: theme.textColor,
        smallSpace: theme.smallSpace,
        mediumSpace: theme.mediumSpace,
        largeSpace: theme.largeSpace,
        mediumRadius: theme.mediumRadius,
        largeRadius: theme.largeRadius,
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
        backgroundColor: theme.defaultColor,
        currentIndex: pageIndex,
        onTap: (index) {
          pageProvider.setPageIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.backgroundColor,
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
