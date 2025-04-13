import 'package:flutter/material.dart';

class BannerPromosi extends StatelessWidget {
  final List<Map<String, String>> banners;
  final double bannerHeight;
  final double bannerWidth;
  final double spacing;
  final double borderRadius;
  final Color gradientColor;

  const BannerPromosi({
    super.key,
    required this.banners,
    this.bannerHeight = 120,
    this.bannerWidth = 300,
    this.spacing = 10,
    this.borderRadius = 12,
    this.gradientColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bannerHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: spacing),
            width: bannerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
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
              borderRadius: BorderRadius.circular(borderRadius),
              child: Stack(
                children: [
                  Image.asset(
                    banners[index]['image']!,
                    width: bannerWidth,
                    height: bannerHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: bannerWidth,
                        height: bannerHeight,
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: bannerHeight,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientColor, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Text(
                      banners[index]['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
