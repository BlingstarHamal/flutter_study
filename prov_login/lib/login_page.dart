import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  get emailTextController => null;

  /*
   * 여기는 다양한 function이 위치할 것입니다.
   */
  @override
  Widget build(BuildContext context) {
    // 사용하고자 하는 provider를 선언합니다.
    Login loginInfo = Provider.of<Login>(context);
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            // TextFormField가 하나 있다고 하겠습니다.
            controller: emailTextController,
          ),
          TextButton(
            // 다른 속성은 생략
            onPressed: () async {
              // 클릭 시, provider인 loginInfo를 호출하여 setEmail 실행
              loginInfo.setEmail(emailTextController);
            },
            child: const Text('hi'),
          ),
        ],
      ),
    );
  }
}
