import 'package:flutter/material.dart';
import 'package:rucas_exam_project/screens/exam.dart';

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
        final exam = exams[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExamScreen(examId: exam['id']),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(exam['icon'], size: 35, color: Colors.blue),
              const SizedBox(height: 5),
              Text(exam['label'], textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }
}
