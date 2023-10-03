//import 'dart:js_util';

// import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:schedule/component/schedule_card.dart';
import '../component/main_calendar.dart';
import 'package:schedule/component/today_banner.dart';
import 'package:schedule/const/colors.dart';
import 'package:schedule/component/schedule_bottom_sheet.dart';
//import 'package:get_it/get_it.dart';
// import 'package:schedule/database/drift_database.dart';
// import 'package:provider/provider.dart';
// import 'package:schedule/provider/schedule_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/model/schedule_model.dart';

// drift -> streambuilder 필요
// provider -> read watche 기능으로 스트림빌더 불필요
// provider stl

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

// class HomeScreen extends StatelessWidget {

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    // 프로바이더
    // // 프로바이더 변경이 있을 때마다 빌드 함수 재실행
    // final provider = context.watch<ScheduleProvider>();
    // // 선택된 날짜 가져오기 / selectedDate 변수를 이제 프로바이더가 관리함
    // final selectedDate = provider.selectedDate;
    // // 선택된 날짜에 해당하는 일정들 가져오기 ScheduleProvider에는 일정을 날짜별로 정리한 캐쉬값을 저장해두었음
    // // 이제는 캐쉬에서 값을 불러오게됨
    // final schedules = provider.cache[selectedDate] ?? [];

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
              onDaySelected: (selectedDate, focusedDate) =>
                  onDaySelected(selectedDate, focusedDate, context),
            ),
            // 간격
            const SizedBox(
              height: 8.0,
            ),

            // 드리프트에서 사용하던 스트림빌더는 제외
            // StreamBuilder<List<Schedule>>(
            //     stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            //     builder: (context, snapshot) {
            //       return TodayBanner(
            //         selectedDate: selectedDate,
            //         count: snapshot.data?.length ?? 0,
            //       );
            //     }),

            //프로바이더 투데이배너
            //TodayBanner(selectedDate: selectedDate, count: schedules.length),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                    'schedule',
                  )
                  .where(
                    'date',
                    isEqualTo:
                        '${selectedDate.year}${selectedDate.month}${selectedDate.day}',
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.docs.length ?? 0,
                );
              },
            ),
            const SizedBox(
              height: 8.0,
            ),

            // firebase
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(
                      'schedule',
                    )
                    .where(
                      'date',
                      isEqualTo:
                          '${selectedDate.year}${selectedDate.month}${selectedDate.day}',
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('일정 정보를 가져오지 못했습니다.'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  final schedules = snapshot.data!.docs
                      .map(
                        (QueryDocumentSnapshot e) => ScheduleModel.fromJson(
                            json: (e.data() as Map<String, dynamic>)),
                      )
                      .toList();

                  // 드리프트 밀어서 삭제 기능
                  // Expanded(
                  //   child: StreamBuilder<List<Schedule>>(
                  //     stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                  //     builder: (context, snapshot) {
                  //       if (!snapshot.hasData) {
                  //         return Container();
                  //       }
                  //       return ListView.builder(
                  //         itemCount: snapshot.data!.length,
                  //         itemBuilder: (context, index) {
                  //           final schedule = snapshot.data![index];
                  //           // 밀어서 삭제
                  //           return Dismissible(
                  //             key: ObjectKey(schedule.id),
                  //             direction: DismissDirection.startToEnd,
                  //             onDismissed: (DismissDirection direction) {
                  //               GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
                  //             },
                  //             child: Padding(
                  //               padding: const EdgeInsets.only(
                  //                 bottom: 8,
                  //                 left: 8,
                  //                 right: 8,
                  //               ),
                  //               child: ScheduleCard(
                  //                 startTime: schedule.startTime,
                  //                 endTime: schedule.endTime,
                  //                 content: schedule.content,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),

                  // 프로바이더 expanded 밀어서 삭제기능
                  // Expanded(
                  //   child: ListView.builder(

                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];

                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction) {
                          // 프로바이더
                          // provider.deleteSchedule(
                          //     date: selectedDate, id: schedule.id);

                          // 파이어 베이스
                          FirebaseFirestore.instance
                              .collection('schedule')
                              .doc(schedule.id)
                              .delete();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
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
          ],
        ),
      ),
    );
  }

  // 드리프트
  // void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
  //   setState(() {
  //     this.selectedDate = selectedDate;
  //   });
  // }

  // // 프로바이더
  // void onDaySelected(
  //   DateTime selectedDate,
  //   DateTime focusedDate,
  //   BuildContext context,
  // ) {
  //   final provier = context.read<ScheduleProvider>();
  //   provier.changeSelectedDate(
  //     date: selectedDate,
  //   );
  //   provier.getSchedules(date: selectedDate);
  // }

  // 파이어베이스

  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
