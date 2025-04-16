import 'package:flutter/material.dart';
import 'package:rucas_exam_project/data/exam_data.dart';

class ExamScreen extends StatefulWidget {
  final String examId;
  final Color defaultColor;
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final double smallSpace;
  final double mediumSpace;
  final double largeSpace;
  final double mediumRadius;
  final double largeRadius;

  const ExamScreen({
    super.key,
    required this.examId,
    this.defaultColor = Colors.white,
    this.primaryColor = const Color(0xFF39AAE0),
    this.backgroundColor = const Color(0xFF87CEEB),
    this.textColor = const Color(0xFF2C3E50),
    this.smallSpace = 8.0,
    this.mediumSpace = 16.0,
    this.largeSpace = 24.0,
    this.mediumRadius = 16.0,
    this.largeRadius = 30.0,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int _currentIndex = 0;
  final Map<String, String> _userAnswers = {};
  bool _showSolution = false;

  @override
  Widget build(BuildContext context) {
    final ExamData selectedExam = questionBank.firstWhere(
      (e) => e.id == widget.examId,
      orElse: () => throw Exception('Exam not found'),
    );

    final question = selectedExam.questions[_currentIndex];
    final isLastQuestion = _currentIndex == selectedExam.questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedExam.title,
          style: TextStyle(color: widget.defaultColor),
        ),
        backgroundColor: widget.primaryColor,
        iconTheme: IconThemeData(color: widget.defaultColor),
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              _showResults(context, selectedExam);
            },
            icon: Icon(Icons.assessment, color: widget.defaultColor),
            label: Text('Hasil', style: TextStyle(color: widget.defaultColor)),
          ),
        ],
      ),
      backgroundColor: widget.defaultColor,
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.symmetric(
              vertical: widget.smallSpace,
              horizontal: widget.mediumSpace,
            ),
            color: widget.backgroundColor.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pertanyaan ${_currentIndex + 1} dari ${selectedExam.questions.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.textColor,
                  ),
                ),
                SizedBox(height: widget.smallSpace),
                LinearProgressIndicator(
                  value: (_currentIndex + 1) / selectedExam.questions.length,
                  backgroundColor: widget.backgroundColor.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Question card
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(widget.mediumSpace),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.mediumRadius),
                  ),
                  color: widget.defaultColor,
                  child: Padding(
                    padding: EdgeInsets.all(widget.mediumSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.textColor,
                          ),
                        ),
                        SizedBox(height: widget.largeSpace),
                        ...question.options.entries.map((option) {
                          final isSelected =
                              _userAnswers[question.id] == option.key;
                          final isCorrect =
                              _showSolution &&
                              question.correctAnswer == option.key;
                          final isWrong =
                              _showSolution &&
                              isSelected &&
                              question.correctAnswer != option.key;

                          Color borderColor =
                              isCorrect
                                  ? Colors.green
                                  : isWrong
                                  ? Colors.red
                                  : isSelected
                                  ? widget.primaryColor
                                  : widget.backgroundColor;

                          Color fillColor =
                              isCorrect
                                  ? Colors.green.withOpacity(0.1)
                                  : isWrong
                                  ? Colors.red.withOpacity(0.1)
                                  : isSelected
                                  ? widget.backgroundColor.withOpacity(0.2)
                                  : Colors.transparent;

                          Color circleColor =
                              isCorrect
                                  ? Colors.green
                                  : isWrong
                                  ? Colors.red
                                  : isSelected
                                  ? widget.primaryColor
                                  : widget.backgroundColor;

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: widget.mediumSpace,
                            ),
                            child: InkWell(
                              onTap:
                                  _showSolution
                                      ? null
                                      : () {
                                        setState(() {
                                          _userAnswers[question.id] =
                                              option.key;
                                        });
                                      },
                              borderRadius: BorderRadius.circular(
                                widget.mediumRadius,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    widget.mediumRadius,
                                  ),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 2,
                                  ),
                                  color: fillColor,
                                ),
                                padding: EdgeInsets.all(widget.mediumSpace),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: circleColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          option.key,
                                          style: TextStyle(
                                            color: widget.defaultColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: widget.mediumSpace),
                                    Expanded(
                                      child: Text(
                                        option.value,
                                        style: TextStyle(
                                          color: widget.textColor,
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isCorrect)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    else if (isWrong)
                                      const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        if (_showSolution) ...[
                          SizedBox(height: widget.largeSpace),
                          Container(
                            padding: EdgeInsets.all(widget.mediumSpace),
                            decoration: BoxDecoration(
                              color: widget.backgroundColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                widget.mediumRadius,
                              ),
                              border: Border.all(color: widget.primaryColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Penjelasan:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: widget.primaryColor,
                                  ),
                                ),
                                SizedBox(height: widget.smallSpace),
                                Text(
                                  question.solution,
                                  style: TextStyle(color: widget.textColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Navigation buttons
          Container(
            padding: EdgeInsets.all(widget.mediumSpace),
            decoration: BoxDecoration(
              color: widget.defaultColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed:
                      _currentIndex > 0
                          ? () {
                            setState(() {
                              _currentIndex--;
                              _showSolution = false;
                            });
                          }
                          : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Sebelumnya'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.backgroundColor,
                    foregroundColor: widget.textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.mediumRadius),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.mediumSpace,
                      vertical: widget.smallSpace,
                    ),
                  ),
                ),
                if (_userAnswers.containsKey(question.id) && !_showSolution)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showSolution = true;
                      });
                    },
                    icon: const Icon(Icons.help_outline),
                    label: const Text('Lihat Jawaban'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          widget.mediumRadius,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.mediumSpace,
                        vertical: widget.smallSpace,
                      ),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed:
                      isLastQuestion
                          ? () {
                            _showResults(context, selectedExam);
                          }
                          : () {
                            setState(() {
                              _currentIndex++;
                              _showSolution = false;
                            });
                          },
                  icon: Icon(
                    isLastQuestion ? Icons.check_circle : Icons.arrow_forward,
                  ),
                  label: Text(isLastQuestion ? 'Selesai' : 'Selanjutnya'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isLastQuestion ? Colors.green : widget.primaryColor,
                    foregroundColor: widget.defaultColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.mediumRadius),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.mediumSpace,
                      vertical: widget.smallSpace,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showResults(BuildContext context, ExamData exam) {
    // Calculate results
    int correct = 0;
    for (var question in exam.questions) {
      if (_userAnswers[question.id] == question.correctAnswer) {
        correct++;
      }
    }

    final percentage = (correct / exam.questions.length) * 100;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.mediumRadius),
            ),
            backgroundColor: widget.defaultColor,
            title: Text(
              'Hasil Ujian',
              style: TextStyle(
                color: widget.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(widget.largeSpace),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        percentage >= 70
                            ? Colors.green.withOpacity(0.1)
                            : percentage >= 50
                            ? Colors.amber.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                    border: Border.all(
                      color:
                          percentage >= 70
                              ? Colors.green
                              : percentage >= 50
                              ? Colors.amber
                              : Colors.red,
                      width: 3,
                    ),
                  ),
                  child: Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color:
                          percentage >= 70
                              ? Colors.green
                              : percentage >= 50
                              ? Colors.amber
                              : Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: widget.mediumSpace),
                Text(
                  'Jawaban benar: $correct dari ${exam.questions.length}',
                  style: TextStyle(fontSize: 18, color: widget.textColor),
                ),
                SizedBox(height: widget.mediumSpace),
                Text(
                  percentage >= 70
                      ? 'Selamat! Hasil yang sangat baik.'
                      : percentage >= 50
                      ? 'Cukup baik, tetapi masih bisa ditingkatkan.'
                      : 'Perlu belajar lebih giat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Tutup',
                  style: TextStyle(color: widget.backgroundColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 0;
                    _userAnswers.clear();
                    _showSolution = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryColor,
                  foregroundColor: widget.defaultColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.mediumRadius),
                  ),
                ),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
    );
  }
}
