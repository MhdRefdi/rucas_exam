// lib/widgets/promotion/components/back_button.dart

import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext context;

  const CustomBackButton({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
              arguments: true,
            );
          },
        ),
      ),
    );
  }
}