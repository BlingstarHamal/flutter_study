import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

class FreeBoardPage extends StatefulWidget {
  const FreeBoardPage({super.key});

  @override
  State<FreeBoardPage> createState() => _FreeBoardPageState();
}

class _FreeBoardPageState extends State<FreeBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[Expanded(child: _customSliverView())],
      ),
    );
  }

  // 다른 요소들은 다 생략하였습니다.

  CustomScrollView _customSliverView() {
    // 여기서 이렇게 provider를 선언해도 괜찮습니다.
    Login loginInfo = Provider.of<Login>(context);
    return CustomScrollView(
      slivers: <Widget>[
        // 생략이 많습니다.
        Text(
          // provider인 loginInfo에서 getMail 호출
          loginInfo.getEmail(),
        ),
      ],
    );
  }
}
