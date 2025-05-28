import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/exam/categories_data.dart';
import 'package:rucas_exam_project/models/exam/category_model.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/provider/exam/categories_provider.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/screens/list_exam_provider.dart';
import 'package:rucas_exam_project/screens/list_exam/list_exam_card.dart';

class ListExamTab extends StatelessWidget {
  const ListExamTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final examProvider = Provider.of<ExamProvider>(context);
    final listExamScreenProvider = Provider.of<ListExamScreenProvider>(context);
    final examCategoriesProvider = Provider.of<ExamCategoriesProvider>(context);
    final List<ExamData> exams = examProvider.getExamByCategory(
      listExamScreenProvider.selectedExamCategory,
    );

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(
        context,
      ).copyWith(scrollbars: false, overscroll: false),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                elevation: 2,
                value: listExamScreenProvider.selectedExamCategory.id,
                hint: Text(
                  "Pilih Kategori Ujian",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade700,
                ),
                items:
                    examCategoriesProvider.categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  listExamScreenProvider.selectedExamCategory = examCategories
                      .firstWhere((category) => category.id == val);
                },
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          SizedBox(height: 15),

          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                return ListExamCard(
                  exam: exams[index],
                  actions: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed:
                            () => Navigator.of(
                              context,
                            ).pushNamed('/exam', arguments: exams[index].id),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.amber,
                          foregroundColor: theme.defaultColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        child: Text("Mulai"),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, _) => SizedBox(height: 10),
              itemCount: exams.length,
            ),
          ),
        ],
      ),
    );
  }
}
