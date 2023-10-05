// validator를 이용해서 유효성검사가 필요함
// 텍스트 입력을 textformfield를 바꿔서 컨트롤러로 유효성 검사를 해야함

import 'package:as_test/screens/auth/login_page.dart';
import 'package:as_test/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png',
            width: 80.0, height: 80.0, fit: BoxFit.fitWidth),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
            icon: const Icon(Icons.home),
            color: const Color.fromARGB(255, 21, 52, 107),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        children: [
          const Text(
            '다음 정보를 모두 입력해 주세요.',
            textAlign: TextAlign.center,
          ),
          const TextField(
            autocorrect: false,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Name",
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const TextField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "E-mail",
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const TextField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "Password",
            ),
            textInputAction: TextInputAction.next,
            obscureText: true,
          ),
          const TextField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "Password Check",
            ),
            textInputAction: TextInputAction.done,
            obscureText: true,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send),
            label: const Text('제출'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('로그인 페이지로 이동'),
          ),
        ],
      ),
    );
  }
}
