import 'package:flutter/foundation.dart';
import 'package:rucas_exam_project/data/exam_data.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/models/question_model.dart';

class ExamProvider with ChangeNotifier {
  final List<ExamData> _exams = questionBank;

  final Map<String, Map<String, String>> _userAnswers = {};
  // Set to track flagged questions by ID
  final Set<String> _flaggedQuestions = {};

  String? _currentExamId;
  int _currentQuestionIndex = 0;
  bool _showSolution = false;
  bool _isReviewMode = false;

  // Getters
  List<ExamData> get exams => _exams;

  ExamData? get currentExam =>
      _currentExamId != null
          ? _exams.firstWhere((e) => e.id == _currentExamId)
          : null;

  int get currentQuestionIndex => _currentQuestionIndex;

  Question? get currentQuestion =>
      currentExam != null &&
              _currentQuestionIndex < currentExam!.questions.length
          ? currentExam!.questions[_currentQuestionIndex]
          : null;

  bool get showSolution => _showSolution;
  bool get isReviewMode => _isReviewMode;

  bool get isLastQuestion =>
      currentExam != null &&
      _currentQuestionIndex == currentExam!.questions.length - 1;

  // New getter for answered questions with answers
  Map<String, String> get answeredQuestions =>
      currentExam != null ? (_userAnswers[currentExam!.id] ?? {}) : {};

  ExamData? getExamById(String id) {
    try {
      return _exams.firstWhere((exam) => exam.id == id);
    } catch (e) {
      return null;
    }
  }

  Map<String, String> getUserAnswersForExam(String examId) {
    return _userAnswers[examId] ?? {};
  }

  String? getCurrentQuestionAnswer() {
    if (currentQuestion == null || currentExam == null) return null;
    final examAnswers = _userAnswers[currentExam!.id];
    if (examAnswers == null) return null;
    return examAnswers[currentQuestion!.id];
  }

  String? getQuestionAnswer(String questionId) {
    if (currentExam == null) return null;
    final examAnswers = _userAnswers[currentExam!.id];
    if (examAnswers == null) return null;
    return examAnswers[questionId];
  }

  void startExam(String examId) {
    _currentExamId = examId;
    _currentQuestionIndex = 0;
    _showSolution = false;

    if (!_userAnswers.containsKey(examId)) {
      _userAnswers[examId] = {};
    }

    notifyListeners();
  }

  void reviewMode() {
    _isReviewMode = true;
    _showSolution = true;
    notifyListeners();
  }

  void answerQuestion(String questionId, String answer) {
    if (currentExam == null) return;

    if (!_userAnswers.containsKey(currentExam!.id)) {
      _userAnswers[currentExam!.id] = {};
    }

    _userAnswers[currentExam!.id]![questionId] = answer;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentExam == null) return;

    if (_currentQuestionIndex < currentExam!.questions.length - 1) {
      _currentQuestionIndex++;
      if (!_isReviewMode) {
        _showSolution = false;
      }
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      if (!_isReviewMode) {
        _showSolution = false;
      }
      notifyListeners();
    }
  }

  // Adding the jumpToQuestion method that's missing in the provider but used in ExamScreen
  void jumpToQuestion(int index) {
    if (currentExam == null) return;

    if (index >= 0 && index < currentExam!.questions.length) {
      _currentQuestionIndex = index;
      if (!_isReviewMode) {
        _showSolution = false;
      }
      notifyListeners();
    }
  }

  // Add method to toggle flagged status for a question
  void toggleFlagQuestion(String questionId) {
    if (_flaggedQuestions.contains(questionId)) {
      _flaggedQuestions.remove(questionId);
    } else {
      _flaggedQuestions.add(questionId);
    }
    notifyListeners();
  }

  Map<String, dynamic> calculateResults() {
    if (currentExam == null) return {};

    final Map<String, String> examAnswers = _userAnswers[currentExam!.id] ?? {};
    int correct = 0;
    int answered = 0;
    int flagged = _flaggedQuestions.length;
    List<String> incorrectQuestionIds = [];

    for (var question in currentExam!.questions) {
      final userAnswer = examAnswers[question.id];
      if (userAnswer != null) {
        answered++;
        if (userAnswer == question.correctAnswer) {
          correct++;
        } else {
          incorrectQuestionIds.add(question.id);
        }
      }
    }

    final double percentage =
        currentExam!.questions.isEmpty
            ? 0
            : (correct / currentExam!.questions.length) * 100;

    return {
      'correct': correct,
      'total': currentExam!.questions.length,
      'answered': answered,
      'percentage': percentage,
      'flagged': flagged,
      'incorrectQuestionIds': incorrectQuestionIds,
    };
  }

  bool isQuestionAnswered(String questionId) {
    if (currentExam == null) return false;
    final examAnswers = _userAnswers[currentExam!.id];
    if (examAnswers == null) return false;
    return examAnswers.containsKey(questionId);
  }

  void resetExam() {
    _currentQuestionIndex = 0;
    _isReviewMode = false;
    _userAnswers.clear();
    notifyListeners();
  }

  List<String> getUnansweredQuestionIds() {
    if (currentExam == null) return [];

    final List<String> unanswered = [];
    final examAnswers = _userAnswers[currentExam!.id] ?? {};

    for (var question in currentExam!.questions) {
      if (!examAnswers.containsKey(question.id)) {
        unanswered.add(question.id);
      }
    }

    return unanswered;
  }

  // Find the index of a question by ID
  int findQuestionIndexById(String questionId) {
    if (currentExam == null) return -1;

    for (int i = 0; i < currentExam!.questions.length; i++) {
      if (currentExam!.questions[i].id == questionId) {
        return i;
      }
    }

    return -1;
  }
}
