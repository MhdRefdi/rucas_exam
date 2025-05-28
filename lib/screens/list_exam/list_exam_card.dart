import 'package:flutter/material.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/screens/list_exam/exam_description.dart';

class ListExamCard extends StatelessWidget {
  final ExamData exam;
  final Widget? actions;

  const ListExamCard({super.key, required this.exam, this.actions});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: exam.banner,
            ),
            SizedBox(height: 20),
            Text(
              exam.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                ExamDescription(
                  icon: Icons.date_range,
                  title: "Tanggal",
                  description: exam.date,
                ),
                SizedBox(width: 40),
                ExamDescription(
                  icon: Icons.lock_clock_rounded,
                  title: "Tanggal",
                  description: exam.time,
                ),
              ],
            ),
            SizedBox(height: 15),
            if (actions != null) actions!,
          ],
        ),
      ),
    );
  }
}
