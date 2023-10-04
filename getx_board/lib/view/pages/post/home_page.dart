import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_board/controller/post_controller.dart';
import 'package:getx_board/controller/user_controller.dart';
import 'package:getx_board/domain/user/user.dart';
import 'package:getx_board/view/pages/post/detail_page.dart';
import 'package:getx_board/view/pages/post/write_page.dart';
import 'package:getx_board/view/pages/user/login_page.dart';
import 'package:getx_board/view/pages/user/user_info.dart';
import 'package:getx_board/size.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // put = 없으면 만들고, 있으면 찾기 => 이미 만들어서 find
    // UserController u = Get.put(UserController());
    UserController u = Get.find();
    // 객체 생성(create) onInit 함수 실행 (initialize)
    PostController p = Get.put(PostController());
    // p.findAll();

    return Scaffold(
      drawer: _navigation(context),
      appBar: AppBar(
        title: Text("${u.isLogin}"),
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: p.posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Get.to(DetailPage(index), arguments: "arguments 속성 테스트");
              },
              title: Text('${p.posts[index].title}'),
              leading: Text('${p.posts[index].id}'),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }

  Widget _navigation(BuildContext context) {
    UserController u = Get.find();
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(WritePage());
                },
                child: const Text(
                  '글쓰기',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Get.to(const UserInfo());
                },
                child: const Text(
                  '회원정보',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  u.logout();
                  Get.to(() => LoginPage());
                },
                child: const Text(
                  '로그아웃',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
