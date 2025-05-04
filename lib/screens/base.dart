import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/page_provider.dart';
import 'package:rucas_exam_project/screens/home.dart';
import 'package:rucas_exam_project/screens/list_exam.dart';

class BaseScreen extends StatelessWidget {
  final AppTheme theme;

  const BaseScreen({super.key, this.theme = const AppTheme()});

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    final pageIndex = pageProvider.pageIndex;

    final List<Widget> pages = [
      HomeScreen(
        theme: theme,
        onSeeAllExams: () {
          pageProvider.setPageIndex(1);
        },
      ),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.explore),
          //   label: 'Daftar Ujian',
          // ),
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
