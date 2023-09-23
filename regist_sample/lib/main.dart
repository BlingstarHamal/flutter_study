import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: false,
                onChanged: (_) {},
              ),
              const Text('이용약관에 동의합니다.'),
            ],
          ),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('제출')),
        ],
      ),
    );
  }
}
