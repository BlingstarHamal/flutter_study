import 'package:get/get.dart';
import 'package:getx_board/domain/user/user_repository.dart';
import 'package:getx_board/util/jwt.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final RxBool isLogin = false.obs; // UI가 관찰 가능한 변수 => 변수가 변경 => UI 자동 업데이트

  void logout() {
    isLogin.value = false;
    jwtToken = null;
  }

  // void는 리턴 없음.
  Future<String> login(String username, String password) async {
    String token = await _userRepository.login(username, password);

    if (token != '-1') {
      isLogin.value = true;
      jwtToken = token;
      print("jwtToken : $jwtToken");
    }
    return token;
  }
}
