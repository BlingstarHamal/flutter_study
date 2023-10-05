import 'package:schedule/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

// private 값까지 불러올수있음
part 'drift_database.g.dart'; // part 파일 지정

@DriftDatabase(
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<List<Schedule>> watchSchedules(DateTime date) =>

      // 데이터 조회 변화 감지
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  // 일정 추가
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  // 일정 삭제
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // 스키마 버전 / 1부터 시작 테이블 변화가 있을 떄마다 1씩 올려 테이블 구조 변경
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
