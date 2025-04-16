import 'package:flutter/foundation.dart';
import 'package:rucas_exam_project/data/exam_data.dart';

class ExamState extends ChangeNotifier {
  final String examId;
  int currentIndex = 0;
  final Map<String, String> userAnswers = {};
  bool showSolution = false;
  bool examCompleted = false;
  ExamData? selectedExam;

  ExamState({required this.examId}) {
    loadExam();
  }

  void loadExam() {
    selectedExam = questionBank.firstWhere(
      (e) => e.id == examId,
      orElse: () => throw Exception('Exam not found'),
    );
    notifyListeners();
  }

  void answerQuestion(String questionId, String answer) {
    userAnswers[questionId] = answer;
    
    // Check if all questions have been answered
    checkExamCompletion();
    
    notifyListeners();
  }

  void checkExamCompletion() {
    if (selectedExam == null) return;
    
    bool allAnswered = selectedExam!.questions.every(
      (question) => userAnswers.containsKey(question.id)
    );
    
    examCompleted = allAnswered;
  }

  void toggleSolution() {
    showSolution = !showSolution;
    notifyListeners();
  }

  void hideSolution() {
    showSolution = false;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < (selectedExam?.questions.length ?? 1) - 1) {
      currentIndex++;
      showSolution = false;
      
      // If this is the last question and all questions are answered, flag exam as completed
      if (isLastQuestion) {
        checkExamCompletion();
      }
      
      notifyListeners();
    } else if (isAllQuestionsAnswered()) {
      examCompleted = true;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      showSolution = false;
      notifyListeners();
    }
  }

  void reset() {
    currentIndex = 0;
    userAnswers.clear();
    showSolution = false;
    examCompleted = false;
    notifyListeners();
  }

  bool get isLastQuestion => currentIndex == (selectedExam?.questions.length ?? 1) - 1;

  bool isAllQuestionsAnswered() {
    if (selectedExam == null) return false;
    return selectedExam!.questions.every((q) => userAnswers.containsKey(q.id));
  }

  int get correctAnswers {
    if (selectedExam == null) return 0;
    
    int correct = 0;
    for (var question in selectedExam!.questions) {
      if (userAnswers[question.id] == question.correctAnswer) {
        correct++;
      }
    }
    return correct;
  }

  double get percentageScore {
    if (selectedExam == null) return 0;
    return (correctAnswers / selectedExam!.questions.length) * 100;
  }

  bool hasAnsweredCurrentQuestion() {
    if (selectedExam == null) return false;
    return userAnswers.containsKey(selectedExam!.questions[currentIndex].id);
  }

  int get answeredQuestions => userAnswers.length;
  
  int get totalQuestions => selectedExam?.questions.length ?? 0;
}