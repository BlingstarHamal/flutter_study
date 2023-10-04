import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_board/view/components/custom_elevated_button.dart';
import 'package:getx_board/view/pages/user/login_page.dart';
import 'package:getx_board/view/components/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:getx_board/util/validator_util.dart';
import 'package:validators/validators.dart';

class JoinPage extends StatelessWidget {
  JoinPage({super.key});

  final _formKey = GlobalKey<FormState>();

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
              child: const Text(
                "회원가입 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _joinForm(),
          ],
        ),
      ),
    );
  }

  Widget _joinForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
              hint: 'Username', funValidator: validateUsername()),
          CustomTextFormField(
            hint: 'Password',
            funValidator: validatePassword(),
          ),
          CustomTextFormField(
            hint: 'Email',
            funValidator: validateEmail(),
          ),
          CustomElevatedButton(
            text: '회원가입',
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                Get.to(LoginPage());
              }
            },
          ),
          TextButton(
            onPressed: () {
              Get.to(LoginPage());
            },
            child: const Text('로그인 페이지로 이동'),
          ),
        ],
      ),
    );
  }
}
