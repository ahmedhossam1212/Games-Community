import 'package:flutter/material.dart';
import 'package:games_community/XO%20Game/xo_screen.dart';
import 'package:games_community/colors.dart';
import 'package:particles_flutter/particles_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blue,
        title: const Text("Games Community"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.blue,
      body: Stack(
        children: [
          CircularParticle(
            width: w,
            height: h,
            awayRadius: w / 5,
            numberOfParticles: 150,
            speedOfParticles: 1.5,
            maxParticleSize: 7,
            particleColor: Colors.white.withOpacity(.7),
            awayAnimationDuration: const Duration(milliseconds: 600),
            awayAnimationCurve: Curves.easeInOutBack,
            onTapAnimation: true,
            isRandSize: true,
            isRandomColor: false,
            connectDots: true,
            enableHover: true,
            hoverColor: Colors.black,
            hoverRadius: 90,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the value as per your requirement
                          ),
                        ),
                        child: Text(
                          "X & O",
                          style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => XOGame(),
                              ));
                        }),
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
