// models/result_model.dart

class ExamResult {
  final String examId;
  final String examTitle;
  final DateTime dateTaken;
  final int correctAnswers;
  final int totalQuestions;
  final int answeredQuestions;
  final int flaggedQuestions;
  final double scorePercentage;
  final Map<String, String> userAnswers;
  final Map<String, String> correctAnswer; 
  final List<String> incorrectQuestionIds;
  double? rating;
  double? difficulty;
  String? comment;

  ExamResult({
    required this.examId,
    required this.examTitle,
    required this.dateTaken,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.answeredQuestions,
    required this.flaggedQuestions,
    required this.scorePercentage,
    required this.userAnswers,
    required this.correctAnswer,
    required this.incorrectQuestionIds,
    this.rating,
    this.difficulty,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'examId': examId,
      'examTitle': examTitle,
      'dateTaken': dateTaken.toIso8601String(),
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'answeredQuestions': answeredQuestions,
      'flaggedQuestions': flaggedQuestions,
      'scorePercentage': scorePercentage,
      'userAnswers': userAnswers,
      'correctAnswers': correctAnswers,
      'incorrectQuestionIds': incorrectQuestionIds,
      'rating': rating,
      'difficulty': difficulty,
      'comment': comment,
    };
  }

  factory ExamResult.fromMap(Map<String, dynamic> map) {
    return ExamResult(
      examId: map['examId'],
      examTitle: map['examTitle'],
      dateTaken: DateTime.parse(map['dateTaken']),
      correctAnswers: map['correctAnswers'],
      totalQuestions: map['totalQuestions'],
      answeredQuestions: map['answeredQuestions'],
      flaggedQuestions: map['flaggedQuestions'],
      scorePercentage: map['scorePercentage'].toDouble(),
      userAnswers: Map<String, String>.from(map['userAnswers']),
      correctAnswer: Map<String, String>.from(map['correctAnswers']),
      incorrectQuestionIds: List<String>.from(map['incorrectQuestionIds']),
      rating: map['rating']?.toDouble(),
      difficulty: map['difficulty']?.toDouble(),
      comment: map['comment'],
    );
  }
}