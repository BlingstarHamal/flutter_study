// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_board/view/pages/post/home_page.dart';
import 'package:getx_board/view/pages/post/update_page.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get.arguments;

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '글 제목!!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const Divider(),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.off(const HomePage()); // 상태관리로 갱신
                    },
                    child: const Text('삭제'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(UpdatePage());
                    },
                    child: const Text('수정'),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text("글 내용!!" * 500),
                ),
              ),
            ],
          ),
        ));
  }
}
