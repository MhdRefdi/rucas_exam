class Question {
  final String id;
  final String question;
  final Map<String, String> options;
  final String correctAnswer;
  final String solution;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.solution,
  });
}
