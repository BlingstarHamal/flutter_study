import 'package:flutter/material.dart';
import 'package:getx_board/controller/post_controller.dart';
import 'package:getx_board/view/components/custom_text_form_field.dart';
import 'package:getx_board/view/components/custom_textarea.dart';
import 'package:getx_board/util/validator_util.dart';
import 'package:getx_board/view/components/custom_elevated_button.dart';

import 'package:get/get.dart';

class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController p = Get.find();
    _title.text = "${p.post.value.title}";
    _content.text = "${p.post.value.content}";

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
              // homepage -> detailpage
              CustomElevatedButton(
                text: '글 수정하기',
                funPageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    await p.updateById(
                        p.post.value.id ?? 0, _title.text, _content.text);
                    // 같은 page가 있으면 이동할 때 덮어씌우기가 없음
                    Get.back(); // 상태관리로 getx 라이브러리 - obs 사용해야함 but, detail page 에서 post를 관찰중이라 back으로도 변경됨
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
