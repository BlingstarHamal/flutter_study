import 'package:schedule/model/schedule.dart';
import 'package:schedule/model/schedule_model.dart';
import 'package:schedule/repository/schedule_repository.dart';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  final SchduleRepository repository;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({required DateTime date}) async {
    final resp = await repository.getSchedules(date: date);

    cache.update(date, (value) => resp, ifAbsent: () => resp);

    notifyListeners();
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;

    const uuid = Uuid();
    final tempId = uuid.v4(); // 유일한 ID값 생성
    final newSchedule = schedule.copyWith(
      id: tempId,
    );
    // 서버 응답 전에 캐시 업데이트
    cache.update(
      targetDate,
      (value) => [
        ...value,
        newSchedule,
      ]..sort(
          (a, b) => a.startTime.compareTo(
            b.startTime,
          ),
        ),
      ifAbsent: () => [newSchedule],
    );

    notifyListeners(); // 캐시업데이트 반영

    try {
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      cache.update(
        targetDate,
        (value) => value
            .map((e) => e.id == tempId
                ? e.copyWith(
                    id: savedSchedule,
                  )
                : e)
            .toList(),
      );
    } catch (e) {
      cache.update(
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }

    // 드리프트
    // cache.update(
    //   targetDate,
    //   (value) => [
    //     ...value,
    //     schedule.copyWith(
    //       id: savedSchedule,
    //     ),
    //   ]..sort(
    //       (a, b) => a.startTime.compareTo(b.startTime),
    //     ),
    //   ifAbsent: () => [schedule],
    // );
    notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule = cache[date]!.firstWhere(
      (e) => e.id == id,
    );

    cache.update(
      date,
      (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    );

    // 드리프트
    // final resp = await repository.deleteSchedule(id: id);

    // cache.update(
    //   date,
    //   (value) => value.where((e) => e.id != id).toList(),
    //   ifAbsent: () => [],
    // );

    notifyListeners();

    try {
      await repository.deleteSchedule(id: id);
    } catch (e) {
      cache.update(
        date,
        (value) => [...value, targetSchedule]..sort(
            (a, b) => a.startTime.compareTo(
              b.startTime,
            ),
          ),
      );
    }
    notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;
    notifyListeners();
  }
}
