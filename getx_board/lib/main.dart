import 'package:flutter/material.dart';
import 'package:getx_board/view/pages/user/join_page.dart';
import 'package:getx_board/view/pages/user/login_page.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
