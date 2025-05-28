import 'package:flutter/material.dart';
import 'package:rucas_exam_project/models/exam/category_model.dart';
import 'package:rucas_exam_project/models/question_model.dart';

class ExamData {
  final String id;
  final String title;
  final String date;
  final String time;
  final List<Question> questions;
  final Icon icon;
  final Image banner;
  final ExamCategoryData category;

  ExamData({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.icon,
    required this.banner,
    required this.category,
    required this.questions,
  });
}
