import 'package:flutter/material.dart';
import 'package:schedule/component/schedule_card.dart';
import '../component/main_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:schedule/component/today_banner.dart';
import 'package:schedule/const/colors.dart';
import 'package:schedule/component/schedule_bottom_sheet.dart';
import 'package:get_it/get_it.dart';
import 'package:schedule/database/drift_database.dart';
import 'package:schedule/component/today_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 새 일정 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              // (_) 기본 파라미터를 안쓴다는 의미
              builder: (_) => ScheduleBottomSheet(
                    selectedDate: selectedDate,
                  ),
              isDismissible: true,
              // 일정 추가 키보드 사용시 스크롤 오류 해결
              isScrollControlled: true);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            // 간격
            const SizedBox(
              height: 8.0,
            ),
            StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  return TodayBanner(
                    selectedDate: selectedDate,
                    count: snapshot.data?.length ?? 0,
                  );
                }),
            // 간격
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final schedule = snapshot.data![index];
                      // 밀어서 삭제
                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // const ScheduleCard(
            //   startTime: 12,
            //   endTime: 14,
            //   content: 'study programing',
            // ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
