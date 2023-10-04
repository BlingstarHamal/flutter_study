import 'package:flutter/material.dart';
import 'package:getx_board/view/components/custom_text_form_field.dart';
import 'package:getx_board/view/components/custom_textarea.dart';
import 'package:getx_board/view/pages/post/detail_page.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:getx_board/util/validator_util.dart';
import 'package:getx_board/view/components/custom_elevated_button.dart';

import 'package:get/get.dart';

class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hint: 'Title',
                funValidator: validateTitle(),
                value: '제목1' * 3,
              ),
              CustomTextArea(
                hint: "content",
                funValidator: validateContent(),
                value: '내용1' * 20,
              ),
              // homepage -> detailpage
              CustomElevatedButton(
                text: '글 수정하기',
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    // 같은 page가 있으면 이동할 때 덮어씌우기가 없음
                    Get.back(); // 상태관리로 getx 라이브러리 - obs 사용해야함
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
