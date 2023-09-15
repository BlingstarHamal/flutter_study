import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오픈API 활용하기',
      home: Scaffold(
        appBar: AppBar(
          title: Text('공영 주차장 조회'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('주차장명'),
              Text('주차코드'),
              Text('위도위치'),
              Text('경도위치'),
            ],
          ),
        ),
      ),
    );
  }
}
