import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class ExamGrid extends StatelessWidget {
  const ExamGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<ExamProvider>(context).exams;

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
            Navigator.pushNamedAndRemoveUntil(context, '/exam', (route) => false, arguments: exam.id);
          },

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              exam.icon,
              const SizedBox(height: 5),
              Text(
                exam.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
