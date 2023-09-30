import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

void main() {
  runApp(
    // provider를 하나만 쓸 게 아니니까, main에서 MultiProvider를 선언합니다.
    MultiProvider(
      providers: [
        // provider로 생성하는 것이기 때문에 create 사용
        ChangeNotifierProvider(create: (_) => Login(email: '')),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'prov_login',
      // 무시: 첫 화면은 스플래시
      //home: SplashPage(),
    );
  }
}
