import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';

class GreetingSection extends StatelessWidget {
  final AppTheme theme = AppTheme();

  GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            theme.mediumSpace,
            theme.smallSpace,
            theme.mediumSpace,
            theme.largeSpace,
          ),
          child: Column(
            children: [
              // Top Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Logo/Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.defaultColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.school_outlined,
                          color: theme.defaultColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "RucasExam",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: theme.defaultColor,
                        ),
                      ),
                    ],
                  ),

                  // Action Icons
                  Row(
                    children: [
                      _buildActionButton(
                        icon: Icons.notifications_outlined,
                        hasBadge: true,
                        onPressed: () {
                          Navigator.pushNamed(context, '/notification');
                        },
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: theme.defaultColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: theme.defaultColor,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/profil.jpg",
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    color: theme.primaryColor,
                                    size: 20,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Added extra spacing here
              SizedBox(height: theme.largeSpace * 1.5),

              // Main Greeting Content
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTimeBasedGreeting(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.defaultColor.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Halo, Selamat Datang! 👋",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: theme.defaultColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Mari kita mulai belajar dan raih prestasi terbaikmu hari ini!",
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.defaultColor.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool hasBadge = false,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.defaultColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: hasBadge
            ? Badge(
                smallSize: 8,
                backgroundColor: Colors.red,
                child: Icon(icon, color: theme.defaultColor, size: 22),
              )
            : Icon(icon, color: theme.defaultColor, size: 22),
        onPressed: onPressed,
      ),
    );
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Selamat Pagi ☀️";
    if (hour < 17) return "Selamat Siang 🌤️";
    return "Selamat Malam 🌙";
  }
}