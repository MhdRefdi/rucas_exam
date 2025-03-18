import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/exam_grid.dart';
import 'package:rucas_exam_project/widgets/promotion_banner.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Colors that complement wooden background
  static const Color primaryColor = Color(0xFF5D4037);     // Rich brown
  static const Color secondaryColor = Color(0xFFD7CCC8);   // Light taupe
  static const Color accentColor = Color(0xFF8D6E63);      // Medium brown
  static const Color cardColor = Color(0xFFF5F0E6);        // Cream color
  static const Color lightTextColor = Colors.white;        // White text for dark backgrounds
  static const Color darkTextColor = Color(0xFF3E2723);    // Dark brown text

  // Spacing constants
  static const double smallSpace = 8.0;
  static const double mediumSpace = 16.0;
  static const double largeSpace = 24.0;

  // Border radius constants
  static const double mediumRadius = 16.0;
  static const double largeRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: lightTextColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: lightTextColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Section with warm opacity overlay
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: largeSpace, 
                    vertical: mediumSpace
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Halo, Selamat Datang!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: lightTextColor,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: smallSpace),
                      const Text(
                        "Siap untuk belajar hari ini?",
                        style: TextStyle(
                          fontSize: 16,
                          color: lightTextColor,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: largeSpace),
                    ],
                  ),
                ),

                // Main Content Area with frosted glass effect
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: mediumSpace, 
                    vertical: largeSpace
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.95),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(largeRadius),
                      topRight: Radius.circular(largeRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar with wood-themed styling
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari mata pelajaran...',
                          hintStyle: TextStyle(color: accentColor.withOpacity(0.6)),
                          prefixIcon: Icon(Icons.search, color: accentColor),
                          filled: true,
                          fillColor: secondaryColor.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: accentColor.withOpacity(0.2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: primaryColor, width: 1.5),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: largeSpace),
                      
                      // Exam Category Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pilihan Ujian",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkTextColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: mediumSpace),
                      
                      // Exam Grid with wood-themed styling
                      Container(
                        padding: const EdgeInsets.all(mediumSpace),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(mediumRadius),
                          border: Border.all(
                            color: secondaryColor.withOpacity(0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ExamGrid(
                          exams: [
                            {'icon': Icons.calculate, 'label': 'Matematika'},
                            {'icon': Icons.science, 'label': 'Fisika'},
                            {'icon': Icons.biotech, 'label': 'Kimia'},
                            {'icon': Icons.eco, 'label': 'Biologi'},
                            {'icon': Icons.history_edu, 'label': 'Sejarah'},
                            {'icon': Icons.public, 'label': 'Geografi'},
                            {'icon': Icons.attach_money, 'label': 'Ekonomi'},
                            {'icon': Icons.language, 'label': 'B. Inggris'},
                            {'icon': Icons.people, 'label': 'Sosiologi'},
                            {'icon': Icons.computer, 'label': 'Teknologi'},
                            {'icon': Icons.brush, 'label': 'Seni Budaya'},
                            {'icon': Icons.sports_soccer, 'label': 'Olahraga'},
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: largeSpace),
                      
                      // Promotions Section
                      Text(
                        "Promosi Terbaru",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkTextColor,
                        ),
                      ),
                      
                      const SizedBox(height: mediumSpace),
                      
                      // Promotion Banner
                      BannerPromosi(),
                      
                      const SizedBox(height: largeSpace),
                      
                      // Recent Activity Section
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}