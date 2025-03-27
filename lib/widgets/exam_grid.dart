import 'package:flutter/material.dart';

class ExamGrid extends StatelessWidget {
  final List<Map<String, dynamic>> exams;

  const ExamGrid({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              exams[index]['icon'], 
              size: 35, 
              color: const Color(0xFF39AAE0), // Bright blue accent
            ),
            const SizedBox(height: 5),
            Text(
              exams[index]['label'],
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF87CEEB), // Sky blue text color
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}