import 'package:flutter/material.dart';
import 'package:getx_board/controller/post_controller.dart';
import 'package:getx_board/view/components/custom_text_form_field.dart';
import 'package:getx_board/view/components/custom_textarea.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:getx_board/util/validator_util.dart';
import 'package:getx_board/view/components/custom_elevated_button.dart';

import 'package:get/get.dart';

class WritePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

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
                controller: _title,
                hint: 'Title',
                funValidator: validateTitle(),
              ),
              CustomTextArea(
                controller: _content,
                hint: "content",
                funValidator: validateContent(),
              ),
              CustomElevatedButton(
                text: '글쓰기',
                funPageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    await Get.find<PostController>()
                        .save(_title.text, _content.text);
                    Get.off(() => HomePage());
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
