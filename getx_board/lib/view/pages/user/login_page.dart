import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_board/controller/user_controller.dart';
import 'package:getx_board/view/components/custom_elevated_button.dart';
import 'package:getx_board/view/components/custom_text_form_field.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:getx_board/view/pages/user/join_page.dart';
import 'package:getx_board/util/validator_util.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.put(UserController());

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "로그인 페이지 ${u.isLogin}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _loginForm(),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: 'Username',
            funValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: 'Password',
            funValidator: validatePassword(),
          ),
          CustomElevatedButton(
            text: '로그인',
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
                // Get.to(const HomePage());
                String token =
                    await u.login(_username.text.trim(), _password.text.trim());
                if (token != '-1') {
                  //print('토큰 정상적으로 받음');
                  Get.to(() => const HomePage());
                } else {
                  //print('토큰 못 받음');
                  Get.snackbar('로그인 시도', '로그인 실패');
                }
              }
            },
          ),
          TextButton(
            onPressed: () {
              Get.to(() => JoinPage());
            },
            child: const Text('아직 회원가입이 안되어 있나요?'),
          ),
        ],
      ),
    );
  }
}
