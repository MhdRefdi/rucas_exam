import 'package:flutter/material.dart';

class BannerPromosi extends StatelessWidget {
  final List<Map<String, String>> banners = [
    {'image': 'banners/th.jpg', 'title': 'Diskon 50% untuk Ujian!'},
    {'image': 'banners/1.png', 'title': 'Paket Belajar Premium!'},
    {'image': 'banners/2.png', 'title': 'Try Out Nasional Segera Dimulai!'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Sesuaikan tinggi banner
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.length,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.asset(
                    banners[index]['image']!,
                    width: 300,
                    height: 120, // Samakan dengan parent
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 300,
                        height: 120,
                        color: Colors.grey[300], // Placeholder warna abu-abu
                        child: Center(
                          child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 120, // Samakan tinggi
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Text(
                      banners[index]['title']!,
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
