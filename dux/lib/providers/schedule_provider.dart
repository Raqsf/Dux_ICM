import 'package:dux/pages/Schedule_Data/subject.dart';
import 'package:flutter/material.dart';

import '../helpers/schedule_database_helper.dart';
import '../models/schedule_model.dart';

class SchedulelProvider with ChangeNotifier {
  List<ScheduleM> _items = [];
  List<ScheduleM> get items => [..._items];
  String _subject_M_8 = "",
      _subject_M_9 = "",
      _subject_M_10 = "",
      _subject_M_11 = "",
      _subject_M_12 = "",
      _subject_M_13 = "",
      _subject_M_14 = "",
      _subject_M_15 = "",
      _subject_M_16 = "",
      _subject_M_17 = "",
      _subject_M_18 = "",
      _subject_T_8 = "",
      _subject_T_9 = "",
      _subject_T_10 = "",
      _subject_T_11 = "",
      _subject_T_12 = "",
      _subject_T_13 = "",
      _subject_T_14 = "",
      _subject_T_15 = "",
      _subject_T_16 = "",
      _subject_T_17 = "",
      _subject_T_18 = "",
      _subject_W_8 = "",
      _subject_W_9 = "",
      _subject_W_10 = "",
      _subject_W_11 = "",
      _subject_W_12 = "",
      _subject_W_13 = "",
      _subject_W_14 = "",
      _subject_W_15 = "",
      _subject_W_16 = "",
      _subject_W_17 = "",
      _subject_W_18 = "",
      _subject_Q_8 = "",
      _subject_Q_9 = "",
      _subject_Q_10 = "",
      _subject_Q_11 = "",
      _subject_Q_12 = "",
      _subject_Q_13 = "",
      _subject_Q_14 = "",
      _subject_Q_15 = "",
      _subject_Q_16 = "",
      _subject_Q_17 = "",
      _subject_Q_18 = "",
      _subject_F_8 = "",
      _subject_F_9 = "",
      _subject_F_10 = "",
      _subject_F_11 = "",
      _subject_F_12 = "",
      _subject_F_13 = "",
      _subject_F_14 = "",
      _subject_F_15 = "",
      _subject_F_16 = "",
      _subject_F_17 = "",
      _subject_F_18 = "";
  String get subject_M_8 => _subject_M_8;
  String get subject_M_9 => _subject_M_9;
  String get subject_M_10 => _subject_M_10;
  String get subject_M_11 => _subject_M_11;
  String get subject_M_12 => _subject_M_12;
  String get subject_M_13 => _subject_M_13;
  String get subject_M_14 => _subject_M_14;
  String get subject_M_15 => _subject_M_15;
  String get subject_M_16 => _subject_M_16;
  String get subject_M_17 => _subject_M_17;
  String get subject_M_18 => _subject_M_18;
  String get subject_T_8 => _subject_T_8;
  String get subject_T_9 => _subject_T_9;
  String get subject_T_10 => _subject_T_10;
  String get subject_T_11 => _subject_T_11;
  String get subject_T_12 => _subject_T_12;
  String get subject_T_13 => _subject_T_13;
  String get subject_T_14 => _subject_T_14;
  String get subject_T_15 => _subject_T_15;
  String get subject_T_16 => _subject_T_16;
  String get subject_T_17 => _subject_T_17;
  String get subject_T_18 => _subject_T_18;
  String get subject_W_8 => _subject_W_8;
  String get subject_W_9 => _subject_W_9;
  String get subject_W_10 => _subject_W_10;
  String get subject_W_11 => _subject_W_11;
  String get subject_W_12 => _subject_W_12;
  String get subject_W_13 => _subject_W_13;
  String get subject_W_14 => _subject_W_14;
  String get subject_W_15 => _subject_W_15;
  String get subject_W_16 => _subject_W_16;
  String get subject_W_17 => _subject_W_17;
  String get subject_W_18 => _subject_W_18;
  String get subject_Q_8 => _subject_Q_8;
  String get subject_Q_9 => _subject_Q_9;
  String get subject_Q_10 => _subject_Q_10;
  String get subject_Q_11 => _subject_Q_11;
  String get subject_Q_12 => _subject_Q_12;
  String get subject_Q_13 => _subject_Q_13;
  String get subject_Q_14 => _subject_Q_14;
  String get subject_Q_15 => _subject_Q_15;
  String get subject_Q_16 => _subject_Q_16;
  String get subject_Q_17 => _subject_Q_17;
  String get subject_Q_18 => _subject_Q_18;
  String get subject_F_8 => _subject_F_8;
  String get subject_F_9 => _subject_F_9;
  String get subject_F_10 => _subject_F_10;
  String get subject_F_11 => _subject_F_11;
  String get subject_F_12 => _subject_F_12;
  String get subject_F_13 => _subject_F_13;
  String get subject_F_14 => _subject_F_14;
  String get subject_F_15 => _subject_F_15;
  String get subject_F_16 => _subject_F_16;
  String get subject_F_17 => _subject_F_17;
  String get subject_F_18 => _subject_F_18;

  Future fetchAndSet() async {
    _items = await ScheduleDatabaseHelper.instance.getAllRecords();
    notifyListeners();
  }

  Future getItemMonday8() async {
    try {
      _subject_M_8 = await ScheduleDatabaseHelper.instance.getRecord(0);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday9() async {
    try {
      _subject_M_9 = await ScheduleDatabaseHelper.instance.getRecord(1);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday10() async {
    try {
      _subject_M_10 = await ScheduleDatabaseHelper.instance.getRecord(2);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday11() async {
    try {
      _subject_M_11 = await ScheduleDatabaseHelper.instance.getRecord(3);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday12() async {
    try {
      _subject_M_12 = await ScheduleDatabaseHelper.instance.getRecord(4);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday13() async {
    try {
      _subject_M_13 = await ScheduleDatabaseHelper.instance.getRecord(5);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday14() async {
    try {
      _subject_M_14 = await ScheduleDatabaseHelper.instance.getRecord(6);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday15() async {
    try {
      _subject_M_15 = await ScheduleDatabaseHelper.instance.getRecord(7);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday16() async {
    try {
      _subject_M_16 = await ScheduleDatabaseHelper.instance.getRecord(8);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday17() async {
    try {
      _subject_M_17 = await ScheduleDatabaseHelper.instance.getRecord(9);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemMonday18() async {
    try {
      _subject_M_18 = await ScheduleDatabaseHelper.instance.getRecord(10);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday8() async {
    try {
      _subject_T_8 = await ScheduleDatabaseHelper.instance.getRecord(11);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday9() async {
    try {
      _subject_T_9 = await ScheduleDatabaseHelper.instance.getRecord(12);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday10() async {
    try {
      _subject_T_10 = await ScheduleDatabaseHelper.instance.getRecord(13);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday11() async {
    try {
      _subject_T_11 = await ScheduleDatabaseHelper.instance.getRecord(14);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday12() async {
    try {
      _subject_T_12 = await ScheduleDatabaseHelper.instance.getRecord(15);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday13() async {
    try {
      _subject_T_13 = await ScheduleDatabaseHelper.instance.getRecord(16);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday14() async {
    try {
      _subject_T_14 = await ScheduleDatabaseHelper.instance.getRecord(17);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday15() async {
    try {
      _subject_T_15 = await ScheduleDatabaseHelper.instance.getRecord(18);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday16() async {
    try {
      _subject_T_16 = await ScheduleDatabaseHelper.instance.getRecord(19);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday17() async {
    try {
      _subject_T_17 = await ScheduleDatabaseHelper.instance.getRecord(20);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemTuesday18() async {
    try {
      _subject_T_18 = await ScheduleDatabaseHelper.instance.getRecord(21);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday8() async {
    try {
      _subject_W_8 = await ScheduleDatabaseHelper.instance.getRecord(22);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday9() async {
    try {
      _subject_W_9 = await ScheduleDatabaseHelper.instance.getRecord(23);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday10() async {
    try {
      _subject_W_10 = await ScheduleDatabaseHelper.instance.getRecord(24);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday11() async {
    try {
      _subject_W_11 = await ScheduleDatabaseHelper.instance.getRecord(25);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday12() async {
    try {
      _subject_W_12 = await ScheduleDatabaseHelper.instance.getRecord(26);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday13() async {
    try {
      _subject_W_13 = await ScheduleDatabaseHelper.instance.getRecord(27);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday14() async {
    try {
      _subject_W_14 = await ScheduleDatabaseHelper.instance.getRecord(28);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday15() async {
    try {
      _subject_W_15 = await ScheduleDatabaseHelper.instance.getRecord(29);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday16() async {
    try {
      _subject_W_16 = await ScheduleDatabaseHelper.instance.getRecord(30);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday17() async {
    try {
      _subject_W_17 = await ScheduleDatabaseHelper.instance.getRecord(31);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemWednesday18() async {
    try {
      _subject_W_18 = await ScheduleDatabaseHelper.instance.getRecord(32);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday8() async {
    try {
      _subject_Q_8 = await ScheduleDatabaseHelper.instance.getRecord(33);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday9() async {
    try {
      _subject_Q_9 = await ScheduleDatabaseHelper.instance.getRecord(34);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday10() async {
    try {
      _subject_Q_10 = await ScheduleDatabaseHelper.instance.getRecord(35);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday11() async {
    try {
      _subject_Q_11 = await ScheduleDatabaseHelper.instance.getRecord(36);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday12() async {
    try {
      _subject_Q_12 = await ScheduleDatabaseHelper.instance.getRecord(37);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday13() async {
    try {
      _subject_Q_13 = await ScheduleDatabaseHelper.instance.getRecord(38);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday14() async {
    try {
      _subject_Q_14 = await ScheduleDatabaseHelper.instance.getRecord(39);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday15() async {
    try {
      _subject_Q_15 = await ScheduleDatabaseHelper.instance.getRecord(40);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday16() async {
    try {
      _subject_Q_16 = await ScheduleDatabaseHelper.instance.getRecord(41);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday17() async {
    try {
      _subject_Q_17 = await ScheduleDatabaseHelper.instance.getRecord(42);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemThursday18() async {
    try {
      _subject_Q_18 = await ScheduleDatabaseHelper.instance.getRecord(43);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday8() async {
    try {
      _subject_F_8 = await ScheduleDatabaseHelper.instance.getRecord(44);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday9() async {
    try {
      _subject_F_9 = await ScheduleDatabaseHelper.instance.getRecord(45);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday10() async {
    try {
      _subject_F_10 = await ScheduleDatabaseHelper.instance.getRecord(46);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday11() async {
    try {
      _subject_F_11 = await ScheduleDatabaseHelper.instance.getRecord(47);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday12() async {
    try {
      _subject_F_12 = await ScheduleDatabaseHelper.instance.getRecord(48);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday13() async {
    try {
      _subject_F_13 = await ScheduleDatabaseHelper.instance.getRecord(49);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday14() async {
    try {
      _subject_F_14 = await ScheduleDatabaseHelper.instance.getRecord(50);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday15() async {
    try {
      _subject_F_15 = await ScheduleDatabaseHelper.instance.getRecord(51);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday16() async {
    try {
      _subject_F_16 = await ScheduleDatabaseHelper.instance.getRecord(52);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday17() async {
    try {
      _subject_F_17 = await ScheduleDatabaseHelper.instance.getRecord(53);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future getItemFriday18() async {
    try {
      _subject_F_18 = await ScheduleDatabaseHelper.instance.getRecord(54);
      notifyListeners();
    } on Exception {
      debugPrint("ID not found");
    }
  }

  Future add(ScheduleM label) async {
    _items.insert(0, label);
    notifyListeners();
    await ScheduleDatabaseHelper.instance.insertRecord(label);
  }

  Future update(ScheduleM label) async {
    final index = _items.indexWhere((e) => e.id == label.id);
    if (index != -1) {
      _items[index] = label;
      notifyListeners();
      await ScheduleDatabaseHelper.instance.updateRecord(label);
    }
  }

  Future delete(int id) async {
    print(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
    await ScheduleDatabaseHelper.instance.deleteRecord(id);
  }

  Future deleteAll() async {
    _items.clear();
    notifyListeners();
    await ScheduleDatabaseHelper.instance.deleteAllRecords();
  }
}
