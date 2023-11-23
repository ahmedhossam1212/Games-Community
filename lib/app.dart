import 'package:flutter/material.dart';
import 'package:games_community/bubble_trouble/bubble_trouble.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bubbletrouble(),
    );
  }
}
