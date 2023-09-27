import 'package:flutter/material.dart';
import 'package:cgv_clone/screens/home/home_screen.dart';
import 'package:cgv_clone/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        return const MaterialApp(
          title: 'CGV Clone',
          debugShowCheckedModeBanner: false,
          home: MyHomPage(),
        );
      },
    );
  }
}
