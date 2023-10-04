import 'package:validators/validators.dart';

Function validateUsername() {
  return (String? value) {
    if (value!.isEmpty) {
      return "유저네임에 공백이 들어갈 수 없습니다.";
    } else if (!isAlphanumeric(value)) {
      return "유저네임에 한글나 특수문자가 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "유저네임의 최대 길이는 12자 입니다.";
    } else if (value.length < 3) {
      return "유저네임의 최소 길이는 4자 입니다.";
    } else {
      return null;
    }
  };
}

Function validatePassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "패스워드에 공백이 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "패스워드의 최대 길이는 12자 입니다.";
    } else if (value.length < 4) {
      return "패스워드의 최소 길이는 4자 입니다.";
    } else {
      return null;
    }
  };
}

Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "이메일에 공백이 들어갈 수 없습니다.";
    } else if (!isEmail(value)) {
      return "이메일에 형식에 맞지 않습니다.";
    } else {
      return null;
    }
  };
}

Function validateTitle() {
  return (String? value) {
    if (value!.isEmpty) {
      return "제목에 공백이 들어갈 수 없습니다.";
    } else if (value.length > 30) {
      return "제목의 최대 길이는 30자 입니다.";
    } else {
      return null;
    }
  };
}

Function validateContent() {
  return (String? value) {
    if (value!.isEmpty) {
      return "내용에 공백이 들어갈 수 없습니다.";
    } else if (value.length > 500) {
      return "내용의 최대 길이는 500자 입니다.";
    } else {
      return null;
    }
  };
}