import 'package:get/get.dart';

const host = "http://192.168.68.102:8080";

// 통신 호출

class UserProvider extends GetConnect {
  // Promise = Future는 값이 오기로 약속되어 있음.
  Future<Response> login(Map data) => post("$host/login", data);
}
