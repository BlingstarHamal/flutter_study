import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule/database/drift_database.dart';
import 'package:get_it/get_it.dart';

void main() async {
  // async 추가. 로컬 언어 변경작업/ 플러터 프레임워크가 준비될때까지 대기
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // intl 패키지 초기화

  // 데이터 베이스 생성
  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
