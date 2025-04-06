import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final Color textColor;
  final Color primaryColor;

  const SearchSection({
    super.key,
    required this.textColor,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari mata pelajaran...',
        hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
        prefixIcon: Icon(Icons.search, color: textColor.withOpacity(0.7)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textColor.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}
