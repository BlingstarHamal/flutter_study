// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_board/controller/post_controller.dart';
import 'package:getx_board/controller/user_controller.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:getx_board/view/pages/post/update_page.dart';

class DetailPage extends StatelessWidget {
  final int? id;

  const DetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get.arguments;
    UserController u = Get.find();
    PostController p = Get.find();
    print('로그인 유저아이디 : ${u.principal.value.id}');

    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 아이디 : $id, 로그인 상태 : ${u.isLogin}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${p.post.value.title}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const Divider(),
              u.principal.value.id == p.post.value.user!.id
                  ? Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await p.deleteById(p.post.value.id!);
                            Get.off(() =>
                                HomePage()); // 상태관리로 갱신 / obs를 적용해서 back으로도 가능하지만 안전하게 홈페이지로 이동
                          },
                          child: const Text('삭제'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => UpdatePage());
                          },
                          child: const Text('수정'),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  child: Text("${p.post.value.content}"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
