import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:schedule/database/drift_database.dart';
// import 'package:get_it/get_it.dart';
// import 'package:schedule/provider/schedule_provider.dart';
// import 'package:schedule/repository/schedule_repository.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // async 추가. 로컬 언어 변경작업/ 플러터 프레임워크가 준비될때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting(); // intl 패키지 초기화

  // // 프로바이 더 및 드리프트
  // // 데이터 베이스 생성
  // final database = LocalDatabase();

  // GetIt.I.registerSingleton<LocalDatabase>(database);

  // final repository = SchduleRepository();
  // final scheduleProvider = ScheduleProvider(repository: repository);

  // runApp(
  //   // provider 하위 위젯에 제공
  //   ChangeNotifierProvider(
  //     create: (_) => scheduleProvider,
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: HomeScreen(),
  //     ),
  //   ),
  // );

  // firebase
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
