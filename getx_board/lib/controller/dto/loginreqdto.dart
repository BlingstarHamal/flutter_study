class LoginReqdto {
  final String? username;
  final String? password;

  LoginReqdto({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
