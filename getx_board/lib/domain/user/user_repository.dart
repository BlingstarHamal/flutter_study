import 'package:get/get.dart';
import 'package:getx_board/controller/dto/loginreqdto.dart';
import 'package:getx_board/domain/user/user_provider.dart';

// 통신 호출해서 응답되는 데이터를 가공 json => dart 오브젝트로

class UserRepository {
  // _ 하면 여기서만 사용가능해짐
  final UserProvider _userProvider = UserProvider();

  Future<String> login(String username, String password) async {
    LoginReqdto loginReqdto =
        LoginReqdto(username: username, password: password);
    //_userProvider.login(loginReqdto.toJson());

    // await 쓸거면 async 필수 // login -> loginreqdto -> await -> response
    Response response = await _userProvider.login(loginReqdto.toJson());
    dynamic headers = response.headers;

    if (headers['authorization'] == null) {
      return "-1"; // future는 null을 리턴 못해서 텍스트 넣음
    } else {
      String token = headers['authorization'];
      return token;
    }
  }
}
