// provider/result_provider.dart
import 'package:flutter/foundation.dart';
import 'package:rucas_exam_project/models/result_model.dart';

class ResultProvider with ChangeNotifier {
  final List<ExamResult> _results = [];

  List<ExamResult> get results => _results;

  void addResult(ExamResult result) {
    _results.add(result);
    notifyListeners();
    // Here you could also add code to persist to local storage
  }

  List<ExamResult> getResultsForExam(String examId) {
    return _results.where((result) => result.examId == examId).toList();
  }

  ExamResult? getLatestResultForExam(String examId) {
    final examResults = getResultsForExam(examId);
    if (examResults.isEmpty) return null;
    examResults.sort((a, b) => b.dateTaken.compareTo(a.dateTaken));
    return examResults.first;
  }

  double getAverageScoreForExam(String examId) {
    final examResults = getResultsForExam(examId);
    if (examResults.isEmpty) return 0;
    final total = examResults.fold(0.0, (sum, result) => sum + result.scorePercentage);
    return total / examResults.length;
  }

  int getTotalAttemptsForExam(String examId) {
    return getResultsForExam(examId).length;
  }


  String? getQuestionById(String examId, String questionId) {
    final result = getLatestResultForExam(examId);
    if (result == null) return null;
    return result.userAnswers[questionId];
  }

  Map<String, int> getQuestionAccuracy(String examId) {
    final examResults = getResultsForExam(examId);
    final Map<String, int> questionStats = {};
    final Map<String, int> questionAttempts = {};

    for (var result in examResults) {
      for (var questionId in result.correctAnswer.keys) {
        questionAttempts[questionId] = (questionAttempts[questionId] ?? 0) + 1;
        if (result.userAnswers[questionId] == result.correctAnswer[questionId]) {
          questionStats[questionId] = (questionStats[questionId] ?? 0) + 1;
        }
      }
    }

    return questionStats;
  }
}