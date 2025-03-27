import 'package:flutter/material.dart';
import 'package:rucas_exam_project/widgets/exam_grid.dart';
import 'package:rucas_exam_project/widgets/promotion_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Colors adjusted to complement the background image
  static const Color defaultColor = Colors.white;
  static const Color primaryColor = Color(0xFF39AAE0);  // Bright blue accent
  static const Color backgroundColor = Color(0xFF87CEEB);  // Sky blue background
  static const Color textColor = Color(0xFF2C3E50);  // Dark blue-gray for contrast
  static const Color transparentColor = Colors.transparent;

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
        backgroundColor: transparentColor,
        iconTheme: IconThemeData(color: defaultColor),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: defaultColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: defaultColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/icon-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: largeSpace,
                    vertical: mediumSpace,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo, Selamat Datang!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(height: smallSpace),
                      Text(
                        "Siap untuk belajar hari ini?",
                        style: TextStyle(fontSize: 16, color: defaultColor),
                      ),
                      const SizedBox(height: largeSpace),
                    ],
                  ),
                ),

                // Main Content Area
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: mediumSpace,
                    vertical: largeSpace,
                  ),
                  width: double.infinity,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari mata pelajaran...',
                          hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                          prefixIcon: Icon(Icons.search, color: textColor.withOpacity(0.7)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textColor.withOpacity(0.3)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
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
                              color: textColor,
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

                      // Exam Grid
                      Container(
                        padding: const EdgeInsets.all(mediumSpace),
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(mediumRadius),
                          border: Border.all(color: textColor.withOpacity(0.1), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: textColor.withOpacity(0.05),
                              blurRadius: 8,
                              spreadRadius: 2,
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
                          color: textColor,
                        ),
                      ),

                      const SizedBox(height: mediumSpace),

                      // Promotion Banner
                      BannerPromosi(),
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