import 'package:flutter/material.dart';
import 'package:rucas_exam_project/screens/home.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int pageIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    Text("Daftar ujian"),
    Text("Hasil ujian"),
    Text("Akun saya")
  ];

  @override
  Widget build(BuildContext context) {
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
