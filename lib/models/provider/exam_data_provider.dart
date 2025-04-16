import 'package:flutter/material.dart';
import 'package:rucas_exam_project/data/exam_data.dart';

class ExamDataProvider with ChangeNotifier {
  final List<ExamData> _exams = questionBank;

  List<ExamData> get exams => _exams;

  ExamData? getExamById(String id) {
    try {
      return _exams.firstWhere((exam) => exam.id == id);
    } catch (e) {
      return null;
    }
  }

  void addExam(ExamData exam) {
    _exams.add(exam);
    notifyListeners();
  }

  void removeExam(String id) {
    _exams.removeWhere((exam) => exam.id == id);
    notifyListeners();
  }
}
