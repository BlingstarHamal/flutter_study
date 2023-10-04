import 'package:flutter/material.dart';
import 'package:getx_board/view/components/custom_text_form_field.dart';
import 'package:getx_board/view/components/custom_textarea.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:getx_board/util/validator_util.dart';
import 'package:getx_board/view/components/custom_elevated_button.dart';

import 'package:get/get.dart';

class WritePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  WritePage({super.key});

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
              ),
              CustomTextArea(
                hint: "content",
                funValidator: validateContent(),
              ),
              CustomElevatedButton(
                text: '글쓰기',
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    Get.to(const HomePage());
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
