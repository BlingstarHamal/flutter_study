import 'package:get/get.dart';
import 'package:getx_board/util/jwt.dart';

const host = "http://192.168.68.102:8080";

// 통신은 프로바이더 => 레포지토리에서 오브젝트를 바꿈 => 컨트롤러에서 레포지토리를 호출하고 상태값을 변경,
// 화면에 동기화하는게 아니면 상태값이 변경이 아니라 뷰로 응답을해주고, 응답받은 것을 토대로 결정 가능

// 통신 호출

class PostProvider extends GetConnect {
  // Promise = Future는 값이 오기로 약속되어 있음.
  Future<Response> findAll() =>
      get("$host/post", headers: {"Authorization": jwtToken ?? ""});

  Future<Response> findById(int id) =>
      get("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});

  Future<Response> deleteById(int id) =>
      delete("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});

  Future<Response> updateById(int id, Map data) =>
      put("$host/post/$id", data, headers: {"Authorization": jwtToken ?? ""});

  Future<Response> save(Map data) =>
      post("$host/post", data, headers: {"Authorization": jwtToken ?? ""});
}
