import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// firbase 연결
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWidget(),
    );
  }
}

// 홈 authwidget
class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  bool isInput = true;
  bool isSignIn = true;

// 로그인, 로그아웃, 회원가입
  singIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value);
        if (value.user!.emailVerified) {
          setState(() {
            isInput = false;
          });
        } else {
          showToast('이메일 인증 오류');
        }
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('가입되지 않은 이메일 입니다.');
      } else if (e.code == 'wrong-password') {
        showToast('잘못된 비밀번호 입니다.');
      } else {
        print(e.code);
      }
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      isInput = true;
    });
  }

  signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user!.email != null) {
          FirebaseAuth.instance.currentUser?.sendEmailVerification();
          setState(() {
            isInput = false;
          });
        }
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'week-password') {
        showToast('취약한 비밀번호 입니다.');
      } else if (e.code == 'email-already-in-use') {
        showToast('사용 중인 이메일 입니다.');
      } else {
        showToast('other error');
        print(e.code);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // 전체를 리스트화
  List<Widget> getInputWidget() {
    return [
      Text(
        // 상단 로그인 회원가입 타이틀
        isSignIn ? "로그인" : "회원가입",
        style: const TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),

      // 이메일과 비밀번호 칸 기본 입력 키워드
      // 이메일이나 패스워드를 입력하지 않았을 때 뜨는 오류 메시지
      Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: '이메일'),
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return '이메일을 입력 하세요';
                }
                return null;
              },
              onSaved: (String? value) {
                email = value ?? "";
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return '비밀번호를 입력 하세요';
                }
                return null;
              },
              onSaved: (String? value) {
                password = value ?? "";
              },
            ),
          ],
        ),
      ),

      // 하단 로그인,회원가입 버튼
      // elevated는 오른쪽과 아래로 그림자가 생기는 버튼
      Container(
        margin: const EdgeInsets.only(
          top: 25.0,
        ),
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                print('email:$email, password:$password');
                if (isSignIn) {
                  singIn();
                } else {
                  signUp();
                }
              }
            },
            child: Text(isSignIn ? "로그인" : "회원가입")),
      ),

      // go 회원가입, 로그인 글씨
      Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            text: 'Go ',
            style: Theme.of(context).textTheme.bodyLarge,
            children: <TextSpan>[
              TextSpan(
                  text: isSignIn ? "회원가입" : "로그인",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isSignIn = !isSignIn;
                      });
                    }),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> getResultWidget() {
    String resultEmail = FirebaseAuth.instance.currentUser!.email!;
    return [
      Center(
        child: Text(
          isSignIn
              ? "$resultEmail로 로그인 하셨습니다!"
              : "$resultEmail로 회원 가입 하셨습니다! 이메일 인증을 거쳐야 로그인이 가능합니다.",
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ElevatedButton(
          onPressed: () {
            if (isSignIn) {
              signOut();
            } else {
              setState(() {
                isInput = true;
                isSignIn = true;
              });
            }
          },
          child: Text(isSignIn ? "로그아웃" : "로그인")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 바
      appBar: AppBar(
        title: const Text("로그인 페이지 테스트"),
        centerTitle: true,
      ),

      // 하단 로그인 버튼 및 go 회원가입 위치
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isInput ? getInputWidget() : getResultWidget(),
        ),
      ),
    );
  }
}
