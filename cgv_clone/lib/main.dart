import 'package:flutter/material.dart';
import 'package:cgv_clone/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGV Clone',
      debugShowCheckedModeBanner: false,
      home: MyHomPage(),
    );
  }
}
