const String stepsTable = 'Steps';

class StepsField {
  static const String day = 'day';
  static const String steps = 'steps';
  static const String isToday = 'isToday';
}

class Steps {
  final int day;
  final int steps;
  final int isToday;

  Steps({
    required this.day,
    required this.steps,
    required this.isToday,
  });

  static Steps fromJson(Map<String, Object?> json) => Steps(
      day: json[StepsField.day] as int,
      steps: json[StepsField.steps] as int,
      isToday: json[StepsField.isToday] as int);

  Map<String, Object?> toJson() => {
        StepsField.day: day,
        StepsField.steps: steps,
        StepsField.isToday: isToday,
      };

  Steps copy({int? day, int? steps, int? isToday}) => Steps(
      day: day ?? this.day,
      steps: steps ?? this.steps,
      isToday: isToday ?? this.isToday);
}
