import 'package:flutter/material.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/models/question_model.dart';

final List<ExamData> questionBank = [
  ExamData(
    id: "1",
    title: "Matematika Dasar",
    icon: Icon(Icons.calculate, size: 35, color: Colors.blue),
    banner: Image.asset("assets/banners/3.png"),
    date: "Senin, 3 Juli 2025",
    time: "00:00 - 23:59",
    questions: [
      Question(
        id: "1",
        question: "Berapakah hasil dari 2 + 2?",
        options: {"A": "3", "B": "4", "C": "5", "D": "6"},
        correctAnswer: "B",
        solution:
            "Penjumlahan dasar: 2 + 2 = 4. Ini adalah operasi matematika paling dasar dimana dua bilangan dijumlahkan menghasilkan 4.",
      ),
      Question(
        id: "2",
        question: "Berapakah hasil dari 10 - 7?",
        options: {"A": "2", "B": "3", "C": "4", "D": "5"},
        correctAnswer: "B",
        solution:
            "Pengurangan sederhana: 10 - 7 = 3. Jika Anda memiliki 10 item dan mengambil 7, sisanya adalah 3.",
      ),
      Question(
        id: "3",
        question: "Berapakah hasil dari 2 + 2?",
        options: {"A": "3", "B": "4", "C": "5", "D": "6"},
        correctAnswer: "B",
        solution:
            "Penjumlahan dasar: 2 + 2 = 4. Ini adalah operasi matematika paling dasar dimana dua bilangan dijumlahkan menghasilkan 4.",
      ),
      Question(
        id: "4",
        question: "Berapakah hasil dari 10 - 7?",
        options: {"A": "2", "B": "3", "C": "4", "D": "5"},
        correctAnswer: "B",
        solution:
            "Pengurangan sederhana: 10 - 7 = 3. Jika Anda memiliki 10 item dan mengambil 7, sisanya adalah 3.",
      ),
      Question(
        id: "5",
        question: "Berapakah hasil dari 2 + 2?",
        options: {"A": "3", "B": "4", "C": "5", "D": "6"},
        correctAnswer: "B",
        solution:
            "Penjumlahan dasar: 2 + 2 = 4. Ini adalah operasi matematika paling dasar dimana dua bilangan dijumlahkan menghasilkan 4.",
      ),
      Question(
        id: "6",
        question: "Berapakah hasil dari 10 - 7?",
        options: {"A": "2", "B": "3", "C": "4", "D": "5"},
        correctAnswer: "B",
        solution:
            "Pengurangan sederhana: 10 - 7 = 3. Jika Anda memiliki 10 item dan mengambil 7, sisanya adalah 3.",
      ),
      Question(
        id: "7",
        question: "Berapakah hasil dari 2 + 2?",
        options: {"A": "3", "B": "4", "C": "5", "D": "6"},
        correctAnswer: "B",
        solution:
            "Penjumlahan dasar: 2 + 2 = 4. Ini adalah operasi matematika paling dasar dimana dua bilangan dijumlahkan menghasilkan 4.",
      ),
      Question(
        id: "8",
        question: "Berapakah hasil dari 10 - 7?",
        options: {"A": "2", "B": "3", "C": "4", "D": "5"},
        correctAnswer: "B",
        solution:
            "Pengurangan sederhana: 10 - 7 = 3. Jika Anda memiliki 10 item dan mengambil 7, sisanya adalah 3.",
      ),
      Question(
        id: "9",
        question: "Berapakah hasil dari 2 + 2?",
        options: {"A": "3", "B": "4", "C": "5", "D": "6"},
        correctAnswer: "B",
        solution:
            "Penjumlahan dasar: 2 + 2 = 4. Ini adalah operasi matematika paling dasar dimana dua bilangan dijumlahkan menghasilkan 4.",
      ),
      Question(
        id: "10",
        question: "Berapakah hasil dari 10 - 7?",
        options: {"A": "2", "B": "3", "C": "4", "D": "5"},
        correctAnswer: "B",
        solution:
            "Pengurangan sederhana: 10 - 7 = 3. Jika Anda memiliki 10 item dan mengambil 7, sisanya adalah 3.",
      ),
    ],
  ),
  ExamData(
    id: "2",
    title: "IPA Umum",
    icon: Icon(Icons.science, color: Colors.blue, size: 35),
    banner: Image.asset("assets/banners/3.png"),
    date: "Senin, 4 Juli 2025",
    time: "00:00 - 23:59",
    questions: [
      Question(
        id: "1",
        question: "Air membeku pada suhu berapa derajat?",
        options: {"A": "0°C", "B": "100°C", "C": "50°C", "D": "25°C"},
        correctAnswer: "A",
        solution:
            "Air murni membeku pada 0°C pada tekanan 1 atmosfer. Ini adalah titik beku standar air dimana fase cair berubah menjadi fase padat (es).",
      ),
      Question(
        id: "2",
        question: "Planet ke-3 dari Matahari adalah?",
        options: {"A": "Mars", "B": "Venus", "C": "Bumi", "D": "Jupiter"},
        correctAnswer: "C",
        solution:
            "Urutan planet dari Matahari: 1. Merkurius, 2. Venus, 3. Bumi, 4. Mars, 5. Jupiter, dst. Bumi adalah planet ketiga dan satu-satunya yang diketahui memiliki kehidupan.",
      ),
    ],
  ),
];
