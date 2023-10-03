class ScheduleModel {
  final String id;
  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;

  ScheduleModel({
    required this.id,
    required this.content,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  // REST API 요청 응받을 받으면 json 형식으로 데이터를 받음
  // json 형식을 그래도 from joson 생성자에 넣어주면 schedulemodel에 맵핑되게 함
  // to josn에서 다시 json형식으로 데이터 변환
  ScheduleModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        content = json['content'],
        date = DateTime.parse(json['date']),
        startTime = json['startTime'],
        endTime = json['endTime'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date':
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
      'starTime': startTime,
      'endTime': endTime,
    };
  }

  ScheduleModel copyWith(
      {String? id,
      String? content,
      DateTime? date,
      int? startTime,
      int? endTime}) {
    return ScheduleModel(
        id: id ?? this.id,
        content: content ?? this.content,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime);
  }
}
