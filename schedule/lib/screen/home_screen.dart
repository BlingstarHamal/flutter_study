import 'package:flutter/material.dart';
import 'package:schedule/component/schedule_card.dart';
import '../component/main_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:schedule/component/today_banner.dart';
import 'package:schedule/const/colors.dart';
import 'package:schedule/component/schedule_bottom_sheet.dart';

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
              builder: (_) => const ScheduleBottomSheet(),
              isDismissible: true);
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
            TodayBanner(selectedDate: selectedDate, count: 0),
            // 간격
            const SizedBox(
              height: 8,
            ),
            const ScheduleCard(
              startTime: 12,
              endTime: 14,
              content: 'study programing',
            ),
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
