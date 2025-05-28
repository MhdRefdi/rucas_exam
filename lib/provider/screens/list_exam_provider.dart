import 'package:flutter/material.dart';
import 'package:rucas_exam_project/data/exam/categories_data.dart';
import 'package:rucas_exam_project/models/exam/category_model.dart';

class ListExamScreenProvider with ChangeNotifier {
  ExamCategoryData _selectedExamCategory = examCategories[0];

  ExamCategoryData get selectedExamCategory => _selectedExamCategory;

  set selectedExamCategory(ExamCategoryData newSelectedExam) {
    _selectedExamCategory = newSelectedExam;
    notifyListeners();
  }
}
