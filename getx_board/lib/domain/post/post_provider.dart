import 'package:get/get.dart';
import 'package:getx_board/util/jwt.dart';

const host = "http://192.168.68.102:8080";

// 통신 호출

class PostProvider extends GetConnect {
  // Promise = Future는 값이 오기로 약속되어 있음.
  Future<Response> findAll() =>
      get("$host/post", headers: {"Authorization": jwtToken ?? ""});
}
