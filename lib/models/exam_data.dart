import 'package:flutter/material.dart';
import 'package:rucas_exam_project/models/question_model.dart';

class ExamData {
  final String id;
  final String title;
  final List<Question> questions;
  final Icon icon;

  ExamData({
    required this.id,
    required this.title,
    required this.icon,
    required this.questions,
  });

}