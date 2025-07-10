import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/models/result_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/result_provider.dart';

class ListExamScreen extends StatelessWidget {
  const ListExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examProvider = context.watch<ExamProvider>();
    final resultProvider = context.watch<ResultProvider>();
    final AppTheme theme = AppTheme();

    // Add null check for exams
    if (examProvider.exams.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              // Header with tabs (unchanged)
              Container(
                height: 130,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/icon-background.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Ujian Saya",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.defaultColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 42,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: theme.defaultColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TabBar(
                              isScrollable: false,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                              labelColor: theme.defaultColor,
                              unselectedLabelColor: Colors.grey,
                              dividerHeight: 0,
                              tabs: const [
                                Tab(text: "Daftar Ujian"),
                                Tab(text: "Riwayat Ujian"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.defaultColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Main content area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: TabBarView(
                    children: <Widget>[
                      // Tab 1: Daftar Ujian (unchanged)
                      _buildExamList(context, examProvider.exams, theme, false),
                      // Tab 2: Riwayat Ujian - now using results
                      _buildHistoryView(context, resultProvider.results, examProvider.exams, theme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamList(BuildContext context, List<ExamData> exams, AppTheme theme, bool isHistory) {
    // Ensure exams is not empty
    if (exams.isEmpty) {
      return const Center(child: Text("Tidak ada ujian tersedia"));
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false, 
        overscroll: false
      ),
      child: isHistory 
        ? _buildHistoryList(context, exams, theme)
        : _buildUpcomingList(context, exams, theme),
    );
  }

  Widget _buildHistoryView(BuildContext context, List<ExamResult> results, List<ExamData> exams, AppTheme theme) {
    if (results.isEmpty) {
      return _buildEmptyHistoryView(context, theme);
    }

    // Get unique exam IDs from results
    final completedExamIds = results.map((r) => r.examId).toSet();
    
    // Filter exams that have results
    final completedExams = exams.where((exam) => completedExamIds.contains(exam.id)).toList();

    return _buildHistoryList(context, completedExams, theme);
  }

  Widget _buildEmptyHistoryView(BuildContext context, AppTheme theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   'assets/images/empty_history.png', // Replace with your empty state image
          //   width: 200,
          //   height: 200,
          // ),
          const SizedBox(height: 20),
          Text(
            "Belum Ada Riwayat Ujian",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.defaultColor,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Anda belum menyelesaikan ujian apapun. Selesaikan ujian untuk melihat riwayatnya di sini.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Optionally navigate to exams tab
              DefaultTabController.of(context).animateTo(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              "Lihat Daftar Ujian",
              style: TextStyle(
                color: theme.defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingList(BuildContext context, List<ExamData> exams, AppTheme theme) {
    return ListView.builder(
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListExamCard(
            exam: exam,
            theme: theme,
            actions: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => ExamDetailBottomSheet(exam: exam),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.amber,
                  foregroundColor: theme.defaultColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                ),
                child: const Text("Lihat Detail"),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryList(BuildContext context, List<ExamData> exams, AppTheme theme) {
    final resultProvider = Provider.of<ResultProvider>(context, listen: false);

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final exam = exams[index];
              final latestResult = resultProvider.getLatestResultForExam(exam.id);
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListExamCard(
                  exam: exam,
                  theme: theme,
                  additionalInfo: latestResult != null 
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            "Terakhir dikerjakan: ${latestResult.dateTaken.toString()}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Nilai: ${latestResult.scorePercentage.toStringAsFixed(1)}%",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      )
                    : null,
                  actions: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to result screen
                            Navigator.pushNamed(
                              context,
                              '/exam_result',
                              arguments: exam.id,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: theme.defaultColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: const TextStyle(fontSize: 12),
                            side: BorderSide(
                              color: Colors.grey[400]!,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text("Hasil Ujian"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to discussion screen
                            Navigator.pushNamed(
                              context,
                              '/review',
                              arguments: exam.id,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.amber,
                            foregroundColor: theme.defaultColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text("Pembahasan"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: exams.length,
          ),
        ),
      ],
    );
  }
}

class ListExamCard extends StatelessWidget {
  final ExamData exam;
  final Widget? actions;
  final Widget? additionalInfo;
  final AppTheme theme;

  const ListExamCard({
    super.key,
    required this.exam,
    this.actions,
    this.additionalInfo,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Banner with fixed height
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  exam.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    Container(color: Colors.grey[200]),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              exam.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // Exam details row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  _buildExamDetail(Icons.date_range, "Tanggal", exam.date),
                  const SizedBox(width: 20),
                  _buildExamDetail(Icons.lock_clock_rounded, "Waktu", exam.time),
                ],
              ),
            ),
            if (additionalInfo != null) additionalInfo!,
            if (actions != null) ...[
              const SizedBox(height: 10),
              actions!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExamDetail(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: const Color(0xFF39AAE0), size: 18),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 11),
            ),
            Text(
              value, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Rest of the code (ExamDetailBottomSheet and _buildStartExamDialog) remains unchanged

class ExamDetailBottomSheet extends StatelessWidget {
  final ExamData exam;
  const ExamDetailBottomSheet({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 24,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Garis penarik
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(exam.imagePath, fit: BoxFit.cover),
                ),
                const SizedBox(height: 24),
                Text(
                  exam.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  exam.description ?? "Deskripsi tidak tersedia.",
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.blueAccent),
                    const SizedBox(width: 12),
                    const Text(
                      "Tanggal: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(exam.date),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.lock_clock_rounded, color: Colors.orangeAccent),
                    const SizedBox(width: 12),
                    const Text(
                      "Jam: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(exam.time),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.green),
                    const SizedBox(width: 12),
                    const Text(
                      "Durasi: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${exam.duration ?? "?"} menit'),
                  ],
                ),
                const SizedBox(height: 24),
                Divider(height: 1, color: Colors.grey[300]),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Jumlah Soal",
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${exam.totalQuestions ?? exam.questions.length}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>
                                _buildStartExamDialog(context, exam),
                          );
                        },
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Mulai Ujian",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Tombol Tutup
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      elevation: 2,
                      side: const BorderSide(color: Colors.blueAccent, width: 1.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 42,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      "Tutup",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildStartExamDialog(BuildContext context, ExamData exam) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    backgroundColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
          const SizedBox(height: 16),
          const Text(
            "Perhatian!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Soal akan dikerjakan dalam waktu *${exam.duration ?? "?"} menit*. "
            "Harap baca soal dengan teliti dan *jangan keluar dari aplikasi selama ujian berlangsung*.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Kembali"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                    Navigator.pop(context); // Tutup bottom sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ujian dimulai. Semoga sukses!"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/exam',
                      (route) => false,
                      arguments: exam.id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Mulai Sekarang",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}