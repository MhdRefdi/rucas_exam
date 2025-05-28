import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/exam/categories_provider.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/screens/list_exam_provider.dart';

class ExamGrid extends StatelessWidget {
  const ExamGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ExamCategoriesProvider>(context).categories;
    final listExamScreenProvider = Provider.of<ListExamScreenProvider>(context);
    final displayCount = categories.length > 3 ? 3 : categories.length;
    final totalCount = displayCount + 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (index == displayCount) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/list-exam');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.grid_view, size: 32, color: Colors.blue),
                SizedBox(height: 5),
                Text(
                  'Semua\nUjian',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ],
            ),
          );
        } else {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              listExamScreenProvider.selectedExamCategory = category;
              Navigator.pushNamed(context, '/list-exam');
            },

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                category.icon,
                const SizedBox(height: 5),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
