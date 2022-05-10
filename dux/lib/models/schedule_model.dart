const String scheduleTable = 'Schedule';

class ScheduleField {
  static const String id = '_id';
  static const String subject = 'subject';
  static const String day = 'day';
  static const String hours = 'hours';
}

class ScheduleM {
  final int? id;
  final String subject;
  final String day;
  final String hours;

  ScheduleM({
    this.id,
    required this.subject,
    required this.day,
    required this.hours,
  });

  static ScheduleM fromJson(Map<String, Object?> json) => ScheduleM(
        id: json[ScheduleField.id] as int,
        subject: json[ScheduleField.subject].toString(),
        day: json[ScheduleField.day].toString(),
        hours: json[ScheduleField.hours].toString(),
      );

  Map<String, Object?> toJson() => {
        ScheduleField.id: id,
        ScheduleField.subject: subject,
        ScheduleField.day: day,
        ScheduleField.hours: hours,
      };

  ScheduleM copy({int? id, String? title}) => ScheduleM(
      id: id ?? this.id,
      subject: title ?? this.subject,
      day: day ?? this.day,
      hours: hours ?? this.hours);
}
