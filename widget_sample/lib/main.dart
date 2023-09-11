import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('위젯 실습'),
        ),
        body: Container(
          color: Colors.yellow,
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(50),
          child: Container(color: Colors.orangeAccent,)
          //Text("Container 위젯에 텍스트(Text) 위젯을 추가한 경우"),
          // width: 200,
          // height: 100,
        )
      ),
    );
  }
}
