import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/screens/list_exam/list_exam_card.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';

class HistoryExamTab extends StatelessWidget {
  const HistoryExamTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final examProvider = Provider.of<ExamProvider>(context);

    return ScrollConfiguration(
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
                            backgroundColor: theme.defaultColor,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            textStyle: TextStyle(fontSize: 15),
                            side: BorderSide(color: Colors.grey, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
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
                            foregroundColor: theme.defaultColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            textStyle: TextStyle(fontSize: 15),
                          ),
                          child: Text("Pembahasan"),
                        ),
                      ),
                    ],
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(height: 10),
            itemCount: examProvider.exams.length,
          ),
        ],
      ),
    );
  }
}
