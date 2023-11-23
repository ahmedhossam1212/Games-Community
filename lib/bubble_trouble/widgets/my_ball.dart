import 'package:flutter/material.dart';
import 'package:games_community/colors/colors.dart';

class MyBall extends StatelessWidget {
  const MyBall({super.key, required this.ballX, required this.ballY});

  final double ballX;
  final double ballY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: AppColors.whiteWithOpacity, shape: BoxShape.circle),
      ),
    );
  }
}
