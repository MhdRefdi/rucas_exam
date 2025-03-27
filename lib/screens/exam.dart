import 'package:flutter/material.dart';
import 'package:rucas_exam_project/data/question_data.dart';
import 'package:rucas_exam_project/models/question.dart';

class ExamScreen extends StatefulWidget {
  final String examId;

  const ExamScreen({super.key, required this.examId});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  // Colors adjusted to complement the background image
  static const Color defaultColor = Colors.white;
  static const Color primaryColor = Color(0xFF39AAE0); // Bright blue accent
  static const Color backgroundColor = Color(0xFF87CEEB); // Sky blue background
  static const Color textColor = Color(0xFF2C3E50); // Dark blue-gray for contrast
  static const Color transparentColor = Colors.transparent;

  // Spacing constants
  static const double smallSpace = 8.0;
  static const double mediumSpace = 16.0;
  static const double largeSpace = 24.0;

  // Border radius constants
  static const double mediumRadius = 16.0;
  static const double largeRadius = 30.0;

  int _currentQuestionIndex = 0;
  List<int?> _selectedAnswers = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    List<Question> questions = questionBank[widget.examId] ?? [];
    _selectedAnswers = List.filled(questions.length, null);
    _pageController = PageController();
  }

  void _submitExam() {
    // TODO: Implement actual exam submission logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ujian diselesaikan!', 
          style: TextStyle(color: defaultColor),
        ),
        backgroundColor: primaryColor,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questions = questionBank[widget.examId] ?? [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0,
        iconTheme: IconThemeData(color: defaultColor),
        title: Text(
          "Ujian: ${widget.examId.toUpperCase()}",
          style: TextStyle(color: defaultColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/icon-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: questions.isEmpty
              ? Center(
                  child: Text(
                    "Tidak ada soal untuk ujian ini.",
                    style: TextStyle(color: defaultColor, fontSize: 18),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: largeSpace),
                        padding: const EdgeInsets.symmetric(
                          horizontal: mediumSpace,
                          vertical: largeSpace,
                        ),
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(largeRadius),
                            topRight: Radius.circular(largeRadius),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: textColor.withOpacity(0.1),
                              blurRadius: 12,
                              spreadRadius: 0,
                              offset: const Offset(0, -3),
                            ),
                          ],
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: questions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final question = questions[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Soal ${index + 1} dari ${questions.length}",
                                  style: TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: mediumSpace),
                                Container(
                                  padding: const EdgeInsets.all(mediumSpace),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: textColor.withOpacity(0.1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(mediumRadius),
                                    boxShadow: [
                                      BoxShadow(
                                        color: textColor.withOpacity(0.05),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        question.question,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: mediumSpace),
                                      ...question.options.asMap().entries.map((entry) {
                                        int optionIndex = entry.key;
                                        String option = entry.value;
                                        return Container(
                                          margin: const EdgeInsets.symmetric(vertical: smallSpace),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: _selectedAnswers[index] == optionIndex
                                                  ? primaryColor
                                                  : textColor.withOpacity(0.2),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(mediumRadius),
                                            color: _selectedAnswers[index] == optionIndex
                                                ? primaryColor.withOpacity(0.1)
                                                : defaultColor,
                                          ),
                                          child: RadioListTile<int>(
                                            title: Text(
                                              option,
                                              style: TextStyle(
                                                color: _selectedAnswers[index] == optionIndex
                                                    ? primaryColor
                                                    : textColor,
                                              ),
                                            ),
                                            value: optionIndex,
                                            groupValue: _selectedAnswers[index],
                                            activeColor: primaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedAnswers[index] = value;
                                              });
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (index > 0)
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: defaultColor,
                                          side: BorderSide(color: primaryColor),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(mediumRadius),
                                          ),
                                        ),
                                        onPressed: () {
                                          _pageController.previousPage(
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Text(
                                          "Sebelumnya",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      ),
                                    if (index < questions.length - 1)
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(mediumRadius),
                                          ),
                                        ),
                                        onPressed: () {
                                          _pageController.nextPage(
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Text(
                                          "Selanjutnya",
                                          style: TextStyle(color: defaultColor),
                                        ),
                                      ),
                                    if (index == questions.length - 1)
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(mediumRadius),
                                          ),
                                        ),
                                        onPressed: _submitExam,
                                        child: Text(
                                          "Selesaikan Ujian",
                                          style: TextStyle(color: defaultColor),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}