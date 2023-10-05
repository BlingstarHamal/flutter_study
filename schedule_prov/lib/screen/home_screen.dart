import 'package:flutter/material.dart';
import 'package:schedule/component/schedule_card.dart';
import '../component/main_calendar.dart';
import 'package:schedule/component/today_banner.dart';
import 'package:schedule/const/colors.dart';
import 'package:schedule/component/schedule_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:schedule/provider/schedule_provider.dart';

// drift -> streambuilder 필요
// provider -> read watch 기능으로 스트림빌더 불필요
// provider stl

class HomeScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 프로바이더
    // 프로바이더 변경이 있을 때마다 빌드 함수 재실행
    final provider = context.watch<ScheduleProvider>();
    // 선택된 날짜 가져오기 / selectedDate 변수를 이제 프로바이더가 관리함
    final selectedDate = provider.selectedDate;
    // 선택된 날짜에 해당하는 일정들 가져오기 ScheduleProvider에는 일정을 날짜별로 정리한 캐쉬값을 저장해두었음
    // 이제는 캐쉬에서 값을 불러오게됨
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      // 플로팅 새일정 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            // 일정 추가할 때 키보드 스크롤 오류 해결
            isScrollControlled: true,
            // (_) 기본 파라미터 사용 x
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: (selectedDate, focusedDate) =>
                  onDaySelected(selectedDate, focusedDate, context),
            ),
            const SizedBox(height: 8.0),
            //프로바이더 투데이배너
            TodayBanner(selectedDate: selectedDate, count: schedules.length),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  // 밀어서 삭제 프로바이더
                  return Dismissible(
                    key: ObjectKey(schedule.id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (DismissDirection direction) {
                      provider.deleteSchedule(
                        date: selectedDate,
                        id: schedule.id,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: ScheduleCard(
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        content: schedule.content,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(
      date: selectedDate,
    );
    provider.getSchedules(date: selectedDate);
  }
}
