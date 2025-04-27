import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';

class SearchSection extends StatelessWidget {
  final AppTheme theme = AppTheme();

  SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari mata pelajaran...',
        hintStyle: TextStyle(color: theme.textColor.withOpacity(0.5)),
        prefixIcon: Icon(Icons.search, color: theme.textColor.withOpacity(0.7)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.textColor.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
    );
  }
}
