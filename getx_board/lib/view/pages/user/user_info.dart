import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_board/controller/user_controller.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    UserController u = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('회원 번호 : ${u.principal.value.id}'),
            Text('회원 유저네임 : ${u.principal.value.username}'),
            Text('회원 이메일 : ${u.principal.value.email}'),
            Text('회원 가입날짜 : ${u.principal.value.created}'),
          ],
        ),
      ),
    );
  }
}
