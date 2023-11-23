import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:games_community/bubble_trouble/widgets/control_button.dart';
import 'package:games_community/bubble_trouble/widgets/my_ball.dart';
import 'package:games_community/colors/colors.dart';

class BubbleTrouble extends StatefulWidget {
  const BubbleTrouble({super.key});

  @override
  State<BubbleTrouble> createState() => _BubbleTroubleState();
}

// ignore: camel_case_types, constant_identifier_names
enum directionX { LEFT, RIGHT }

// ignore: camel_case_types, constant_identifier_names

class _BubbleTroubleState extends State<BubbleTrouble> {
  double ballX = 0;
  double ballY = 0;
  double x = 0;
  double y = 1;
  var ballDirectionX = directionX.LEFT;

  bool playerDies() {
    if ((ballX - x).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          title: const Text(
            "You die Bro .",
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  double hieghtToCoordinate(double hieght) {
    double totalHieght = MediaQuery.of(context).size.height * 3 / 4;
    double missleY = 1 - 2 * hieght / totalHieght;
    return missleY;
  }

  void startGame() {
    ballX = 0;
    ballY = 0;
    double time = 0;
    double height = 0;
    double velocity = 50;
    Timer.periodic(const Duration(milliseconds: 25), (timer) {
      height = -5 * time * time + velocity * time;

      if (height < 0) {
        time = 0;
      }

      setState(() {
        ballY = hieghtToCoordinate(height);
      });
      time += 0.1;
      if (ballX - 0.02 < -1) {
        ballDirectionX = directionX.RIGHT;
      } else if (ballX + 0.02 > 1) {
        ballDirectionX = directionX.LEFT;
      }

      if (ballDirectionX == directionX.LEFT) {
        setState(() {
          ballX -= 0.02;
        });
      } else if (ballDirectionX == directionX.RIGHT) {
        setState(
          () {
            ballX += 0.02;
          },
        );
      }

      if (playerDies()) {
        timer.cancel;
        _showDialog();
        dispose();
      }
    });
  }

  void upAxis() {
    if (y > -1) {
      y -= 0.05;
    }
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bubble Trouble"),
        backgroundColor: AppColors.pink,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.blue,
                          shape: BoxShape.rectangle),
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
                      setState(() {
                        upAxis();
                      });
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
