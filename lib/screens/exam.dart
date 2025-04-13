import 'package:flutter/material.dart';

class ExamScreen extends StatelessWidget {
  final String examId;

  const ExamScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ujian: ${examId.toUpperCase()}'),
        backgroundColor: Color(0xFF39AAE0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman ujian untuk mata pelajaran: $examId',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
