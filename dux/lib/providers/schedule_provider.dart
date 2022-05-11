import 'package:dux/pages/Schedule_Data/subject.dart';
import 'package:flutter/material.dart';

import '../helpers/schedule_database_helper.dart';
import '../models/schedule_model.dart';

class SchedulelProvider with ChangeNotifier {
  List<ScheduleM> _items = [];
  String _subject = "";
  List<ScheduleM> get items => [..._items];
  String get subject => _subject;

  Future fetchAndSet() async {
    _items = await ScheduleDatabaseHelper.instance.getAllRecords();
    notifyListeners();
  }

  Future getItemByDayHours(String day, String hours) async {
    _subject = await ScheduleDatabaseHelper.instance.getRecord(day, hours);
    notifyListeners();
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
