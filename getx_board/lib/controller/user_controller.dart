import 'package:get/get.dart';
import 'package:getx_board/domain/user/user.dart';
import 'package:getx_board/domain/user/user_repository.dart';
import 'package:getx_board/util/jwt.dart';

// repo에서 작업한것을 컨트롤러가 받음

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final RxBool isLogin = false.obs; // UI가 관찰 가능한 변수 => 변수가 변경 => UI 자동 업데이트
  final principal = User().obs;

  void logout() {
    isLogin.value = false;
    jwtToken = null;
    // get.storage() 를 이용하면 로그인 상태 유지 가능, 현재 앱은 메모리에 로그인 정보를 담아서 앱이 꺼지면 로그인이 풀림
  }

  // void는 리턴 없음. 로그인 진행
  Future<int> login(String username, String password) async {
    User principal = await _userRepository.login(username, password);

    // 정상적으로 로그인
    if (principal.id != null) {
      isLogin.value = true;
      this.principal.value = principal;
      return 1;

      // 로그인 실패 빈 값
    } else {
      return -1;
    }

    // if (token != '-1') {
    //   isLogin.value = true;
    //   jwtToken = token;
    //   print("jwtToken : $jwtToken");
    // }
    // return token;
  }
}
