import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/models/exam_model.dart';
import 'package:rucas_exam_project/provider/exam_provider.dart';
import 'package:rucas_exam_project/provider/screens/list_exam_provider.dart';
import 'package:rucas_exam_project/screens/list_exam/list_exam_tab.dart';

class ListExamScreen extends StatelessWidget {
  const ListExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examProvider = context.watch<ExamProvider>();
    final listExamScreenProvider = context.watch<ListExamScreenProvider>();
    final List<ExamData> exams = examProvider.getExamByCategory(
      listExamScreenProvider.selectedExamCategory,
    );
    final AppTheme theme = AppTheme();

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              AppHeader(theme: theme),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 45,
                  ),
                  child: TabBarView(children: <Widget>[ListExamTab()]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterListExam extends StatelessWidget {
  const FilterListExam({super.key});

  @override
  Widget build(BuildContext context) {
    final listExamScreenProvider = Provider.of<ListExamScreenProvider>(context);

    return Expanded(
      child: DropdownButtonFormField<String>(
        // value: "${listExamScreenProvider.selectedExamCategory}",
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        isExpanded: true,
        items: [DropdownMenuItem(child: Text('child'))],
        onChanged: (index) {},
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.theme});

  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                Navigator.of(context).pushNamed('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.defaultColor,
                shape: const CircleBorder(),
                padding: EdgeInsets.all(12),
              ),
              child: Icon(Icons.arrow_back_rounded, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
