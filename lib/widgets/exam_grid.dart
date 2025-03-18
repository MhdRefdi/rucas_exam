import 'package:flutter/material.dart';

class ExamGrid extends StatelessWidget {
  final List<Map<String, dynamic>> exams;

  ExamGrid({required this.exams});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(exams[index]['icon'], size: 35, color: Color(0xFF795548)),
            SizedBox(height: 5),
            Text(
              exams[index]['label'],
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
