import 'package:flutter/material.dart';
import 'package:games_community/colors/colors.dart';

class BubbleControlButton extends StatelessWidget {
  const BubbleControlButton(
      {super.key, required this.icon, required this.function});

  final IconData icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Icon(
            icon,
            size: 40,
          ),
        ),
      ),
    );
  }
}
