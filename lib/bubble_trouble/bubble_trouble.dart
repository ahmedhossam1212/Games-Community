import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:games_community/bubble_trouble/widgets/control_button.dart';
import 'package:games_community/bubble_trouble/widgets/my_ball.dart';
import 'package:games_community/colors/colors.dart';

class Bubbletrouble extends StatefulWidget {
  const Bubbletrouble({super.key});

  @override
  State<Bubbletrouble> createState() => _BubbletroubleState();
}

// ignore: camel_case_types, constant_identifier_names
enum direction { LEFT, RIGHT }

class _BubbletroubleState extends State<Bubbletrouble> {
  double ballX = 0;
  double ballY = 0;
  double x = 0;
  double y = 1;
  var ballDirection = direction.LEFT;

  void startGame() {
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (ballX - 0.02 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.02 > 1) {
        ballDirection = direction.LEFT;
      }

      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.02;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.02;
        });
      }
    });
  }

  void axisPlus() {
    if (x < 1) {
      x += 0.05;
    } else {}
  }

  void axisNigative() {
    if (x > -1) {
      x -= 0.05;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: AppColors.pink,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(x, y),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.blue, shape: BoxShape.rectangle),
                    ),
                  ),
                  MyBall(ballX: ballX, ballY: ballY),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BubbleControlButton(
                    function: () {
                      debugPrint("left");
                      setState(() {
                        axisNigative();
                      });
                    },
                    icon: Icons.keyboard_arrow_left,
                  ),
                  BubbleControlButton(
                    function: () {
                      debugPrint("up");
                    },
                    icon: Icons.keyboard_arrow_up,
                  ),
                  BubbleControlButton(
                    function: () {
                      debugPrint("right");
                      setState(() {
                        axisPlus();
                      });
                    },
                    icon: Icons.keyboard_arrow_right,
                  ),
                  BubbleControlButton(
                    function: () {
                      debugPrint("paly");
                      startGame();
                    },
                    icon: Icons.play_arrow,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
