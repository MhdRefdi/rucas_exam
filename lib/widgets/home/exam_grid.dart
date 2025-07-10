import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

import '../../screens/list_exam.dart';

class ExamGrid extends StatefulWidget {
  const ExamGrid({super.key});

  @override
  State<ExamGrid> createState() => _ExamGridState();
}

class _ExamGridState extends State<ExamGrid> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _maxScrollExtent = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollPosition() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      _maxScrollExtent = _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollToIndex(int index) {
    final double targetScroll = index * 288.0; // 280 width + 8 margin
    _scrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<ExamProvider>(context).exams;
    final currentIndex = _maxScrollExtent > 0 
        ? (_scrollPosition / _maxScrollExtent * (exams.length - 1)).round()
        : 0;

    return Column(
      children: [
        // Horizontal Scrollable Exam Banners
        SizedBox(
          height: 180,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              final isFirst = index == 0;
              final isLast = index == exams.length - 1;

              return Container(
                width: 280,
                margin: EdgeInsets.only(
                  left: isFirst ? 16 : 8,
                  right: isLast ? 16 : 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => ExamDetailBottomSheet(exam: exam),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              exam.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => 
                                Container(color: Colors.grey[200]),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exam.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, 
                                        size: 12, 
                                        color: Colors.white),
                                    const SizedBox(width: 4),
                                    Text(
                                      exam.date,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.access_time, 
                                        size: 12, 
                                        color: Colors.white),
                                    const SizedBox(width: 4),
                                    Text(
                                      exam.time,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
        const SizedBox(height: 12),
        // Dot Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(exams.length, (index) {
            return GestureDetector(
              onTap: () => _scrollToIndex(index),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index 
                      ? AppTheme().primaryColor 
                      : Colors.grey[300],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}