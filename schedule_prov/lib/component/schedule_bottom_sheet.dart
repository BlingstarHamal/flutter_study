import 'package:schedule_prov/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:schedule_prov/const/colors.dart';
import 'package:schedule_prov/model/schedule_model.dart';
import 'package:provider/provider.dart';
import 'package:schedule_prov/provider/schedule_provider.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleBottomSheet({required this.selectedDate, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    // 키보드 높이 조절
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          // mediaquery 앱 디바이스의 길이 / 화면 반 높이에 키보드 높이 추가
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding:
                EdgeInsets.only(left: 8, top: 8, right: 8, bottom: bottomInset),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextField(
                        isTime: true,
                        label: '종료 시간',
                        onSaved: (String? val) {
                          endTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: CustomTextField(
                    isTime: false,
                    label: '내용',
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: contentValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // 프로바이더 온프레스드
                    onPressed: () => onSavePressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: const Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // 프로바이더 일정생성
      context.read<ScheduleProvider>().createSchedule(
            schedule: ScheduleModel(
                id: 'new_model',
                content: content!,
                date: widget.selectedDate,
                startTime: startTime!,
                endTime: endTime!),
          );
      // 일정 생성 후 화면 뒤로 가기
      Navigator.of(context).pop();
    }
  }

  // 시간 검증
  String? timeValidator(String? val) {
    if (val == null) {
      return '값을 입력해주세요';
    }
    int? number;
    try {
      number = int.parse(val);
    } catch (e) {
      return '숫자를 입력해주세요';
    }
    if (number < 0 || number > 24) {
      return '0시부터 24시 사이를 입력해주세요';
    }
    return null;
  }

  // 내용 검증
  String? contentValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '값을 입력해주세요';
    }
    return null;
  }
}
