const String scheduleTable = 'Schedule';

class ScheduleField {
  static const String id = '_id';
  static const String subject = 'subject';
}

class Schedule {
  final int? id;
  final String subject;

  Schedule({
    this.id,
    required this.subject,
  });

  static Schedule fromJson(Map<String, Object?> json) => Schedule(
        id: json[ScheduleField.id] as int,
        subject: json[ScheduleField.subject].toString(),
      );

  Map<String, Object?> toJson() => {
        ScheduleField.id: id,
        ScheduleField.subject: subject,
      };

  Schedule copy({int? id, String? title}) =>
      Schedule(id: id ?? this.id, subject: title ?? this.subject);
}
