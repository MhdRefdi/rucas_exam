import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/data/exam_data.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class ListExamScreen extends StatelessWidget {
  const ListExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examProvider = context.watch<ExamProvider>();

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
                    image: AssetImage("images/icon-background.png"),
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
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 300,
                            height: 42,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TabBar(
                              isScrollable: false,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                              labelColor: Colors.white,
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
                          Navigator.of(context).pushNamed('/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
                                actions: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed:
                                          () => Navigator.of(context).pushNamed(
                                            '/exam',
                                            arguments:
                                                examProvider.exams[index].id,
                                          ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.amber,
                                        foregroundColor: Colors.white,
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
                                        image: AssetImage("banners/1.png"),
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
                                    actions: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => {},
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.white,
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
                                              foregroundColor: Colors.white,
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

  const ListExamCard({super.key, required this.exam, this.actions});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: exam.banner,
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
                  title: "Tanggal",
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
        Icon(icon, color: Colors.blue),
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
