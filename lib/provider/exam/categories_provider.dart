import 'package:flutter/material.dart';
import 'package:rucas_exam_project/data/exam/categories_data.dart';
import 'package:rucas_exam_project/models/exam/category_model.dart';

class ExamCategoriesProvider with ChangeNotifier {
  final List<ExamCategoryData> _examCategories = examCategories;

  List<ExamCategoryData> get categories => _examCategories;
}
