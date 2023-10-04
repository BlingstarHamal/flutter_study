// 나는 한글이 깨지지 않았긴한데 유튜브에선 깨졌음. 일단 utf8 변경기능을 넣어줌

import 'dart:convert';

// body는 codeUnits를 받지 못해서 body를 받아서 json로 바꾸고 다시 decode
dynamic convertUtf8ToObject(dynamic body) {
  String responseBody = jsonEncode(body); // json 데이터로 변경
  dynamic convertBody = jsonDecode(utf8.decode(responseBody.codeUnits));
  return convertBody;
}
