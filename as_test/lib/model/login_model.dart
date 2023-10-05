import 'package:flutter/material.dart';

// with ChangeNotifier: provider로 만들어줍니다.
class Login with ChangeNotifier {
  String? email;

  Login({
    this.email,
  });

  String? getEmail() => email;
  void setEmail(String email) {
    email = email;
    notifyListeners();
  }
}
