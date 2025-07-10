import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class ListExamScreen extends StatelessWidget {
  const ListExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examProvider = context.watch<ExamProvider>();
    final AppTheme theme = AppTheme();

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/icon-background.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
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
                          SizedBox(height: 10),
                          Container(
                            width: 300,
                            height: 42,
                            padding: EdgeInsets.all(4),
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
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                              labelColor: theme.defaultColor,
                              unselectedLabelColor: Colors.grey,
                              dividerHeight: 0,
                              tabs: [
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
                          padding: EdgeInsets.all(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 45,
                  ),
                  child: TabBarView(
                    children: <Widget>[
                      ScrollConfiguration(
                        behavior: ScrollConfiguration.of(
                          context,
                        ).copyWith(scrollbars: false, overscroll: false),
                        child: ListView.separated(
                          itemBuilder:
                              (_, index) => ListExamCard(
                                exam: examProvider.exams[index],
                                theme: theme,
                                actions: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed:
                                          () => showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder:
                                                (_) => ExamDetailBottomSheet(
                                                  exam:
                                                      examProvider.exams[index],
                                                ),
                                          ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.amber,
                                        foregroundColor: theme.defaultColor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ),
                                        textStyle: TextStyle(fontSize: 15),
                                      ),
                                      child: Text("Lihat"),
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (_, _) => SizedBox(height: 10),
                          itemCount: examProvider.exams.length,
                        ),
                      ),
                      ScrollConfiguration(
                        behavior: ScrollConfiguration.of(
                          context,
                        ).copyWith(scrollbars: false, overscroll: false),
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              toolbarHeight: 150,
                              flexibleSpace: FlexibleSpaceBar(
                                background: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/banners/1.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 10)),
                            SliverList.separated(
                              itemBuilder:
                                  (_, index) => ListExamCard(
                                    exam: examProvider.exams[index],
                                    theme: theme,
                                    actions: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => {},
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  theme.defaultColor,
                                              foregroundColor: Colors.black,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 15,
                                              ),
                                              textStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              side: BorderSide(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            child: Text("Hasil Ujian"),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.amber,
                                              foregroundColor:
                                                  theme.defaultColor,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 15,
                                              ),
                                              textStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            child: Text("Pembahasan"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              separatorBuilder:
                                  (_, index) => SizedBox(height: 10),
                              itemCount: examProvider.exams.length,
                            ),
                          ],
                        ),
                      ),
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
}

class ListExamCard extends StatelessWidget {
  final ExamData exam;
  final Widget? actions;
  final AppTheme theme;

  const ListExamCard({
    super.key,
    required this.exam,
    this.actions,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: exam.banner,
            // ),
            BannerWithLoading(
              banner: exam.imagePath,
              theme: theme,
              borderRadius: BorderRadius.circular(theme.mediumRadius),
            ),
            SizedBox(height: 20),
            Text(
              exam.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                ExamDescription(
                  icon: Icons.date_range,
                  title: "Tanggal",
                  description: exam.date,
                ),
                SizedBox(width: 40),
                ExamDescription(
                  icon: Icons.lock_clock_rounded,
                  title: "Waktu",
                  description: exam.time,
                ),
              ],
            ),
            SizedBox(height: 15),
            if (actions != null) actions!,
          ],
        ),
      ),
    );
  }
}

class ExamDescription extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ExamDescription({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Color(0xFF39AAE0)),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title),
            Text(description, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

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
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 24,
                offset: Offset(0, -8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Garis penarik
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    margin: EdgeInsets.only(bottom: 24),
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
                SizedBox(height: 24),
                Text(
                  exam.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  exam.description ?? "Deskripsi tidak tersedia.",
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.blueAccent),
                    SizedBox(width: 12),
                    Text(
                      "Tanggal: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(exam.date),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.lock_clock_rounded, color: Colors.orangeAccent),
                    SizedBox(width: 12),
                    Text(
                      "Jam: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(exam.time),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.green),
                    SizedBox(width: 12),
                    Text(
                      "Durasi: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${exam.duration ?? "?"} menit'),
                  ],
                ),
                SizedBox(height: 24),
                Divider(height: 1, color: Colors.grey[300]),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Jumlah Soal",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${exam.totalQuestions ?? exam.questions.length}',
                            style: TextStyle(
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
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (context) =>
                                    _buildStartExamDialog(context, exam),
                          );
                        },
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Mulai Ujian",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                // Tombol Tutup Lebih Menarik
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      elevation: 2,
                      side: BorderSide(color: Colors.blueAccent, width: 1.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 42,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
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
    insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    backgroundColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
          SizedBox(height: 16),
          Text(
            "Perhatian!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Soal akan dikerjakan dalam waktu *${exam.duration ?? "?"} menit*. "
            "Harap baca soal dengan teliti dan *jangan keluar dari aplikasi selama ujian berlangsung*.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text("Kembali"),
                ),
              ),
              SizedBox(width: 12),
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
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
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

class BannerWithLoading extends StatelessWidget {
  final String banner; // ubah jadi String
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final AppTheme theme;

  const BannerWithLoading({
    super.key,
    required this.banner,
    required this.theme,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.asset(banner, fit: BoxFit.cover);

    return FutureBuilder<void>(
      future: _precacheImage(imageWidget.image, context),
      builder: (context, snapshot) {
        return Container(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: theme.backgroundColor.withAlpha(30),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (snapshot.connectionState == ConnectionState.done)
                ClipRRect(
                  borderRadius: borderRadius ?? BorderRadius.circular(0),
                  child: imageWidget,
                ),
              if (snapshot.connectionState != ConnectionState.done)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _precacheImage(ImageProvider image, BuildContext context) async {
    try {
      await precacheImage(image, context);
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
  }
}
