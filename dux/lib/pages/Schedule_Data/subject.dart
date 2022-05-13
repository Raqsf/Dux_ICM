import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Subject {
  String subject_M_8 = "";
  String subject_M_9 = "";
  String subject_M_10 = "";
  String subject_M_11 = "";
  String subject_M_12 = "";
  String subject_M_13 = "";
  String subject_M_14 = "";
  String subject_M_15 = "";
  String subject_M_16 = "";
  String subject_M_17 = "";
  String subject_M_18 = "";
  String subject_M_19 = "";
  String subject_T_8 = "";
  String subject_T_9 = "";
  String subject_T_10 = "";
  String subject_T_11 = "";
  String subject_T_12 = "";
  String subject_T_13 = "";
  String subject_T_14 = "";
  String subject_T_15 = "";
  String subject_T_16 = "";
  String subject_T_17 = "";
  String subject_T_18 = "";
  String subject_T_19 = "";
  String subject_W_8 = "";
  String subject_W_9 = "";
  String subject_W_10 = "";
  String subject_W_11 = "";
  String subject_W_12 = "";
  String subject_W_13 = "";
  String subject_W_14 = "";
  String subject_W_15 = "";
  String subject_W_16 = "";
  String subject_W_17 = "";
  String subject_W_18 = "";
  String subject_W_19 = "";
  String subject_Q_8 = "";
  String subject_Q_9 = "";
  String subject_Q_10 = "";
  String subject_Q_11 = "";
  String subject_Q_12 = "";
  String subject_Q_13 = "";
  String subject_Q_14 = "";
  String subject_Q_15 = "";
  String subject_Q_16 = "";
  String subject_Q_17 = "";
  String subject_Q_18 = "";
  String subject_Q_19 = "";
  String subject_F_8 = "";
  String subject_F_9 = "";
  String subject_F_10 = "";
  String subject_F_11 = "";
  String subject_F_12 = "";
  String subject_F_13 = "";
  String subject_F_14 = "";
  String subject_F_15 = "";
  String subject_F_16 = "";
  String subject_F_17 = "";
  String subject_F_18 = "";
  String subject_F_19 = "";

  // Constructor
  Subject({
    required this.subject_M_8,
    required this.subject_M_9,
    required this.subject_M_10,
    required this.subject_M_11,
    required this.subject_M_12,
    required this.subject_M_13,
    required this.subject_M_14,
    required this.subject_M_15,
    required this.subject_M_16,
    required this.subject_M_17,
    required this.subject_M_18,
    required this.subject_M_19,
    required this.subject_T_8,
    required this.subject_T_9,
    required this.subject_T_10,
    required this.subject_T_11,
    required this.subject_T_12,
    required this.subject_T_13,
    required this.subject_T_14,
    required this.subject_T_15,
    required this.subject_T_16,
    required this.subject_T_17,
    required this.subject_T_18,
    required this.subject_T_19,
    required this.subject_W_8,
    required this.subject_W_9,
    required this.subject_W_10,
    required this.subject_W_11,
    required this.subject_W_12,
    required this.subject_W_13,
    required this.subject_W_14,
    required this.subject_W_15,
    required this.subject_W_16,
    required this.subject_W_17,
    required this.subject_W_18,
    required this.subject_W_19,
    required this.subject_Q_8,
    required this.subject_Q_9,
    required this.subject_Q_10,
    required this.subject_Q_11,
    required this.subject_Q_12,
    required this.subject_Q_13,
    required this.subject_Q_14,
    required this.subject_Q_15,
    required this.subject_Q_16,
    required this.subject_Q_17,
    required this.subject_Q_18,
    required this.subject_Q_19,
    required this.subject_F_8,
    required this.subject_F_9,
    required this.subject_F_10,
    required this.subject_F_11,
    required this.subject_F_12,
    required this.subject_F_13,
    required this.subject_F_14,
    required this.subject_F_15,
    required this.subject_F_16,
    required this.subject_F_17,
    required this.subject_F_18,
    required this.subject_F_19,
  });

  Subject copy({
    String? subject_M_8,
    String? subject_M_9,
    String? subject_M_10,
    String? subject_M_11,
    String? subject_M_12,
    String? subject_M_13,
    String? subject_M_14,
    String? subject_M_15,
    String? subject_M_16,
    String? subject_M_17,
    String? subject_M_18,
    String? subject_M_19,
    String? subject_T_8,
    String? subject_T_9,
    String? subject_T_10,
    String? subject_T_11,
    String? subject_T_12,
    String? subject_T_13,
    String? subject_T_14,
    String? subject_T_15,
    String? subject_T_16,
    String? subject_T_17,
    String? subject_T_18,
    String? subject_T_19,
    String? subject_W_8,
    String? subject_W_9,
    String? subject_W_10,
    String? subject_W_11,
    String? subject_W_12,
    String? subject_W_13,
    String? subject_W_14,
    String? subject_W_15,
    String? subject_W_16,
    String? subject_W_17,
    String? subject_W_18,
    String? subject_W_19,
    String? subject_Q_8,
    String? subject_Q_9,
    String? subject_Q_10,
    String? subject_Q_11,
    String? subject_Q_12,
    String? subject_Q_13,
    String? subject_Q_14,
    String? subject_Q_15,
    String? subject_Q_16,
    String? subject_Q_17,
    String? subject_Q_18,
    String? subject_Q_19,
    String? subject_F_8,
    String? subject_F_9,
    String? subject_F_10,
    String? subject_F_11,
    String? subject_F_12,
    String? subject_F_13,
    String? subject_F_14,
    String? subject_F_15,
    String? subject_F_16,
    String? subject_F_17,
    String? subject_F_18,
    String? subject_F_19,
  }) =>
      Subject(
        subject_M_8: subject_M_8 ?? this.subject_M_8,
        subject_M_9: subject_M_9 ?? this.subject_M_9,
        subject_M_10: subject_M_10 ?? this.subject_M_10,
        subject_M_11: subject_M_11 ?? this.subject_M_11,
        subject_M_12: subject_M_12 ?? this.subject_M_12,
        subject_M_13: subject_M_13 ?? this.subject_M_13,
        subject_M_14: subject_M_14 ?? this.subject_M_14,
        subject_M_15: subject_M_15 ?? this.subject_M_15,
        subject_M_16: subject_M_16 ?? this.subject_M_16,
        subject_M_17: subject_M_17 ?? this.subject_M_17,
        subject_M_18: subject_M_18 ?? this.subject_M_18,
        subject_M_19: subject_M_19 ?? this.subject_M_19,
        subject_T_8: subject_T_8 ?? this.subject_T_8,
        subject_T_9: subject_T_9 ?? this.subject_T_9,
        subject_T_10: subject_T_10 ?? this.subject_T_10,
        subject_T_11: subject_T_11 ?? this.subject_T_11,
        subject_T_12: subject_T_12 ?? this.subject_T_12,
        subject_T_13: subject_T_13 ?? this.subject_T_13,
        subject_T_14: subject_T_14 ?? this.subject_T_14,
        subject_T_15: subject_T_15 ?? this.subject_T_15,
        subject_T_16: subject_T_16 ?? this.subject_T_16,
        subject_T_17: subject_T_17 ?? this.subject_T_17,
        subject_T_18: subject_T_18 ?? this.subject_T_18,
        subject_T_19: subject_T_19 ?? this.subject_T_19,
        subject_W_8: subject_W_8 ?? this.subject_W_8,
        subject_W_9: subject_W_9 ?? this.subject_W_9,
        subject_W_10: subject_W_10 ?? this.subject_W_12,
        subject_W_11: subject_W_11 ?? this.subject_W_11,
        subject_W_12: subject_W_12 ?? this.subject_W_12,
        subject_W_13: subject_W_13 ?? this.subject_W_13,
        subject_W_14: subject_W_14 ?? this.subject_W_14,
        subject_W_15: subject_W_15 ?? this.subject_W_15,
        subject_W_16: subject_W_16 ?? this.subject_W_16,
        subject_W_17: subject_W_17 ?? this.subject_W_17,
        subject_W_18: subject_W_18 ?? this.subject_W_18,
        subject_W_19: subject_W_19 ?? this.subject_W_19,
        subject_Q_8: subject_Q_8 ?? this.subject_Q_8,
        subject_Q_9: subject_Q_9 ?? this.subject_Q_9,
        subject_Q_10: subject_Q_10 ?? this.subject_Q_10,
        subject_Q_11: subject_Q_11 ?? this.subject_Q_11,
        subject_Q_12: subject_Q_12 ?? this.subject_Q_12,
        subject_Q_13: subject_Q_13 ?? this.subject_Q_13,
        subject_Q_14: subject_Q_14 ?? this.subject_Q_14,
        subject_Q_15: subject_Q_15 ?? this.subject_Q_15,
        subject_Q_16: subject_Q_16 ?? this.subject_Q_16,
        subject_Q_17: subject_Q_17 ?? this.subject_Q_17,
        subject_Q_18: subject_Q_18 ?? this.subject_Q_18,
        subject_Q_19: subject_Q_19 ?? this.subject_Q_19,
        subject_F_8: subject_F_8 ?? this.subject_F_8,
        subject_F_9: subject_F_9 ?? this.subject_F_9,
        subject_F_10: subject_F_10 ?? this.subject_F_10,
        subject_F_11: subject_F_11 ?? this.subject_F_11,
        subject_F_12: subject_F_12 ?? this.subject_F_12,
        subject_F_13: subject_F_13 ?? this.subject_F_13,
        subject_F_14: subject_F_14 ?? this.subject_F_14,
        subject_F_15: subject_F_15 ?? this.subject_F_15,
        subject_F_16: subject_F_16 ?? this.subject_F_16,
        subject_F_17: subject_F_17 ?? this.subject_F_17,
        subject_F_18: subject_F_18 ?? this.subject_F_18,
        subject_F_19: subject_F_19 ?? this.subject_F_19,
      );

  static Subject fromJson(Map<String, dynamic> json) => Subject(
        subject_M_8: json['subject_M_8'],
        subject_M_9: json['subject_M_9'],
        subject_M_10: json['subject_M_10'],
        subject_M_11: json['subject_M_11'],
        subject_M_12: json['subject_M_12'],
        subject_M_13: json['subject_M_13'],
        subject_M_14: json['subject_M_14'],
        subject_M_15: json['subject_M_15'],
        subject_M_16: json['subject_M_16'],
        subject_M_17: json['subject_M_17'],
        subject_M_18: json['subject_M_18'],
        subject_M_19: json['subject_M_19'],
        subject_T_8: json['subject_T_8'],
        subject_T_9: json['subject_T_9'],
        subject_T_10: json['subject_T_10'],
        subject_T_11: json['subject_T_11'],
        subject_T_12: json['subject_T_12'],
        subject_T_13: json['subject_T_13'],
        subject_T_14: json['subject_T_14'],
        subject_T_15: json['subject_T_15'],
        subject_T_16: json['subject_T_16'],
        subject_T_17: json['subject_T_17'],
        subject_T_18: json['subject_T_18'],
        subject_T_19: json['subject_T_19'],
        subject_W_8: json['subject_W_8'],
        subject_W_9: json['subject_W_9'],
        subject_W_10: json['subject_W_10'],
        subject_W_11: json['subject_W_11'],
        subject_W_12: json['subject_W_12'],
        subject_W_13: json['subject_W_13'],
        subject_W_14: json['subject_W_14'],
        subject_W_15: json['subject_W_15'],
        subject_W_16: json['subject_W_16'],
        subject_W_17: json['subject_W_17'],
        subject_W_18: json['subject_W_18'],
        subject_W_19: json['subject_W_19'],
        subject_Q_8: json['subject_Q_8'],
        subject_Q_9: json['subject_Q_9'],
        subject_Q_10: json['subject_Q_10'],
        subject_Q_11: json['subject_Q_11'],
        subject_Q_12: json['subject_Q_12'],
        subject_Q_13: json['subject_Q_13'],
        subject_Q_14: json['subject_Q_14'],
        subject_Q_15: json['subject_Q_15'],
        subject_Q_16: json['subject_Q_16'],
        subject_Q_17: json['subject_Q_17'],
        subject_Q_18: json['subject_Q_18'],
        subject_Q_19: json['subject_Q_19'],
        subject_F_8: json['subject_F_8'],
        subject_F_9: json['subject_F_9'],
        subject_F_10: json['subject_F_10'],
        subject_F_11: json['subject_F_11'],
        subject_F_12: json['subject_F_12'],
        subject_F_13: json['subject_F_13'],
        subject_F_14: json['subject_F_14'],
        subject_F_15: json['subject_F_15'],
        subject_F_16: json['subject_F_16'],
        subject_F_17: json['subject_F_17'],
        subject_F_18: json['subject_F_18'],
        subject_F_19: json['subject_F_19'],
      );

  Map<String, dynamic> toJson() => {
        'subject_M_8': subject_M_8,
        'subject_M_9': subject_M_9,
        'subject_M_10': subject_M_10,
        'subject_M_11': subject_M_11,
        'subject_M_12': subject_M_12,
        'subject_M_13': subject_M_13,
        'subject_M_14': subject_M_14,
        'subject_M_15': subject_M_15,
        'subject_M_16': subject_M_16,
        'subject_M_17': subject_M_17,
        'subject_M_18': subject_M_18,
        'subject_M_19': subject_M_19,
        'subject_T_8': subject_T_8,
        'subject_T_9': subject_T_9,
        'subject_T_10': subject_T_10,
        'subject_T_11': subject_T_11,
        'subject_T_12': subject_T_12,
        'subject_T_13': subject_T_13,
        'subject_T_14': subject_T_14,
        'subject_T_15': subject_T_15,
        'subject_T_16': subject_T_16,
        'subject_T_17': subject_T_17,
        'subject_T_18': subject_T_18,
        'subject_T_19': subject_T_19,
        'subject_W_8': subject_W_8,
        'subject_W_9': subject_W_9,
        'subject_W_10': subject_W_10,
        'subject_W_11': subject_W_11,
        'subject_W_12': subject_W_12,
        'subject_W_13': subject_W_13,
        'subject_W_14': subject_W_14,
        'subject_W_15': subject_W_15,
        'subject_W_16': subject_W_16,
        'subject_W_17': subject_W_17,
        'subject_W_18': subject_W_18,
        'subject_W_19': subject_W_19,
        'subject_Q_8': subject_Q_8,
        'subject_Q_9': subject_Q_9,
        'subject_Q_10': subject_Q_10,
        'subject_Q_11': subject_Q_11,
        'subject_Q_12': subject_Q_12,
        'subject_Q_13': subject_Q_13,
        'subject_Q_14': subject_Q_14,
        'subject_Q_15': subject_Q_15,
        'subject_Q_16': subject_Q_16,
        'subject_Q_17': subject_Q_17,
        'subject_Q_18': subject_Q_18,
        'subject_Q_19': subject_Q_19,
        'subject_F_8': subject_F_8,
        'subject_F_9': subject_F_9,
        'subject_F_10': subject_F_10,
        'subject_F_11': subject_F_11,
        'subject_F_12': subject_F_12,
        'subject_F_13': subject_F_13,
        'subject_F_14': subject_F_14,
        'subject_F_15': subject_F_15,
        'subject_F_16': subject_F_16,
        'subject_F_17': subject_F_17,
        'subject_F_18': subject_F_18,
        'subject_F_19': subject_F_19,
      };
}

class SubjectData {
  static late SharedPreferences _preferences;
  static const _keySubject = 'subject';

  static Subject mySubject = Subject(
    subject_M_8: "",
    subject_M_9: "",
    subject_M_10: "",
    subject_M_11: "",
    subject_M_12: "",
    subject_M_13: "",
    subject_M_14: "",
    subject_M_15: "",
    subject_M_16: "",
    subject_M_17: "",
    subject_M_18: "",
    subject_M_19: "",
    subject_T_8: "",
    subject_T_9: "",
    subject_T_10: "",
    subject_T_11: "",
    subject_T_12: "",
    subject_T_13: "",
    subject_T_14: "",
    subject_T_15: "",
    subject_T_16: "",
    subject_T_17: "",
    subject_T_18: "",
    subject_T_19: "",
    subject_W_8: "",
    subject_W_9: "",
    subject_W_10: "",
    subject_W_11: "",
    subject_W_12: "",
    subject_W_13: "",
    subject_W_14: "",
    subject_W_15: "",
    subject_W_16: "",
    subject_W_17: "",
    subject_W_18: "",
    subject_W_19: "",
    subject_Q_8: "",
    subject_Q_9: "",
    subject_Q_10: "",
    subject_Q_11: "",
    subject_Q_12: "",
    subject_Q_13: "",
    subject_Q_14: "",
    subject_Q_15: "",
    subject_Q_16: "",
    subject_Q_17: "",
    subject_Q_18: "",
    subject_Q_19: "",
    subject_F_8: "",
    subject_F_9: "",
    subject_F_10: "",
    subject_F_11: "",
    subject_F_12: "",
    subject_F_13: "",
    subject_F_14: "",
    subject_F_15: "",
    subject_F_16: "",
    subject_F_17: "",
    subject_F_18: "",
    subject_F_19: "",
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setSubject(Subject subject) async {
    final json = jsonEncode(subject.toJson());

    await _preferences.setString(_keySubject, json);
  }

  static Subject getSubject() {
    final json = _preferences.getString(_keySubject);

    return json == null ? mySubject : Subject.fromJson(jsonDecode(json));
  }
}
