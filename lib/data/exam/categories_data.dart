import 'package:flutter/material.dart';
import 'package:rucas_exam_project/models/exam/category_model.dart';

final List<ExamCategoryData> examCategories = [
  ExamCategoryData(
    id: 1,
    name: "Matematika Dasar",
    icon: Icon(Icons.calculate, size: 35, color: Colors.blue),
  ),
  ExamCategoryData(
    id: 2,
    name: "IPA Umum",
    icon: Icon(Icons.science, color: Colors.blue, size: 35),
  ),
];
