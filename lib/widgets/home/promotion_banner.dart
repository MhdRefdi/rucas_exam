import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';


class BannerPromosi extends StatefulWidget {
  final List<Promotion> promotions;
  final double bannerHeight;
  final double bannerWidth;
  final double spacing;
  final double borderRadius;
  final Color gradientColor;
  final Duration autoSlideDuration;
  final Function(Promotion) onPromotionTap;

  const BannerPromosi({
    super.key,
    required this.promotions,
    required this.onPromotionTap,
    this.bannerHeight = 120,
    this.bannerWidth = 300,
    this.spacing = 10,
    this.borderRadius = 12,
    this.gradientColor = Colors.black54,
    this.autoSlideDuration = const Duration(seconds: 3),
  });

  @override
  State<BannerPromosi> createState() => _BannerPromosiState();
}

class _BannerPromosiState extends State<BannerPromosi> {
  late PageController _pageController;
  late Timer _autoSlideTimer;
  bool _isInitialized = false;
  int _currentPage = 0;

  final AppTheme theme = AppTheme();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _pageController = PageController(
        viewportFraction: widget.bannerWidth / MediaQuery.of(context).size.width,
      );
      _startAutoSlide();
      _isInitialized = true;
    }
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(widget.autoSlideDuration, (timer) {
      if (widget.promotions.isEmpty) return;
      
      final nextPage = (_currentPage + 1) % widget.promotions.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoSlideTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promotions.isEmpty) {
      return SizedBox(
        height: widget.bannerHeight,
        child: const Center(
          child: Text('No promotions available'),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: widget.bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.promotions.length,
            padEnds: false,
            itemBuilder: (context, index) {
              final actualIndex = index % widget.promotions.length;
              final promotion = widget.promotions[actualIndex];
              
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
                child: GestureDetector(
                  onTap: () => widget.onPromotionTap(promotion),
                  child: Container(
                    width: widget.bannerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: Stack(
                        children: [
                          Image.asset(
                            promotion.imagePath,
                            width: widget.bannerWidth,
                            height: widget.bannerHeight,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: widget.bannerWidth,
                                height: widget.bannerHeight,
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
                            height: widget.bannerHeight,
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [widget.gradientColor, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Text(
                              promotion.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        _buildIndicators(),
      ],
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.promotions.length,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? theme.primaryColor
                : Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
