import '../models/question.dart';

final Map<String, List<Question>> questionBank = {
  'math': [
    Question(
      question: 'Berapakah hasil dari 5 + 3?',
      options: ['6', '7', '8', '9'],
      correctAnswer: '8',
    ),
    Question(
      question: 'Berapakah hasil dari 12 - 4?',
      options: ['6', '7', '8', '9'],
      correctAnswer: '8',
    ),
    Question(
      question: 'Berapakah hasil dari 3 × 7?',
      options: ['21', '24', '27', '30'],
      correctAnswer: '21',
    ),
    Question(
      question: 'Berapakah hasil dari 20 ÷ 4?',
      options: ['4', '5', '6', '7'],
      correctAnswer: '5',
    ),
    Question(
      question: 'Berapakah luas persegi dengan sisi 9 cm?',
      options: ['72 cm²', '81 cm²', '90 cm²', '99 cm²'],
      correctAnswer: '81 cm²',
    ),
    Question(
      question: 'Berapakah hasil dari 2³?',
      options: ['6', '8', '9', '12'],
      correctAnswer: '8',
    ),
    Question(
      question: 'Sebuah lingkaran memiliki jari-jari 7 cm. Berapakah kelilingnya? (π ≈ 3.14)',
      options: ['21,98 cm', '43,96 cm', '50 cm', '55 cm'],
      correctAnswer: '43,96 cm',
    ),
    Question(
      question: 'Berapakah 25% dari 200?',
      options: ['25', '40', '50', '60'],
      correctAnswer: '50',
    ),
    Question(
      question: 'Sebuah kubus memiliki volume 125 cm³. Berapakah panjang sisinya?',
      options: ['4 cm', '5 cm', '6 cm', '7 cm'],
      correctAnswer: '5 cm',
    ),
    Question(
      question: 'Jika x = 4 dan y = 3, maka nilai dari x² + y² adalah?',
      options: ['16', '25', '30', '40'],
      correctAnswer: '25',
    ),
  ],
};
