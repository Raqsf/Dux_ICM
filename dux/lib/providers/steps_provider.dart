import 'package:flutter/material.dart';

import '../helpers/steps_database_helper.dart';
import '../models/steps_model.dart';

class StepsProvider with ChangeNotifier {
  List<Steps> _items = [];
  Steps? _today;

  List<Steps> get items => [..._items];
  Steps? get today => _today;

  Future fetchAndSet() async {
    _items = await StepsDatabaseHelper.instance.getAllRecords();
    notifyListeners();
  }

  Future getToday() async {
    print("GET TODAY PROVIDER");
    _today = await StepsDatabaseHelper.instance.getToday();
    notifyListeners();
  }

  Future add(Steps steps) async {
    _items.insert(0, steps);
    notifyListeners();
    await StepsDatabaseHelper.instance.insertRecord(steps);
  }

  Future updateSteps() async {
    await StepsDatabaseHelper.instance.updateSteps();
  }

  Future update(Steps steps) async {
    final index = _items.indexWhere((e) => e.day == steps.day);
    if (index != -1) {
      _items[index] = steps;
      notifyListeners();
      await StepsDatabaseHelper.instance.updateRecord(steps);
    }
  }

  Future delete(String day) async {
    _items.removeWhere((e) => e.day == day);
    notifyListeners();
    await StepsDatabaseHelper.instance.deleteRecord(day);
  }

  Future deleteAll() async {
    _items.clear();
    notifyListeners();
    await StepsDatabaseHelper.instance.deleteAllRecords();
  }
}
