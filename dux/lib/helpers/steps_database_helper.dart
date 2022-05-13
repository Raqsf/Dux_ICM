import '../models/steps_model.dart';
import 'database_helper.dart';
import 'package:intl/intl.dart';

class StepsDatabaseHelper {
  static final StepsDatabaseHelper instance = StepsDatabaseHelper._init();
  StepsDatabaseHelper._init();

  Future<Steps> getRecord(String day) async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      stepsTable,
      where: '${StepsField.day} = ?',
      whereArgs: [day],
    );

    if (records.isNotEmpty) {
      return Steps.fromJson(records.first);
    } else {
      throw Exception('$day not found');
    }
  }

  Future<Steps> getToday() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      stepsTable,
      where: '${StepsField.isToday} = ?',
      whereArgs: [1],
    );

    if (records.isNotEmpty) {
      DateTime date = DateTime.now();
      String dateFormat = DateFormat('EEEE').format(date);

      Steps today = Steps.fromJson(records.first);

      if (today.day == day(dateFormat)) {
        return Steps.fromJson(records.first);
      } else {
        updateToday();
        final newToday = await db.query(
          stepsTable,
          where: '${StepsField.isToday} = ?',
          whereArgs: [1],
        );
        return Steps.fromJson(newToday.first);
      }
    } else {
      DateTime date = DateTime.now();
      String dateFormat = DateFormat('EEEE').format(date);
      Steps s = Steps(day: day(dateFormat), steps: 0, isToday: 1);
      insertRecord(s);
      return s;
    }
  }

  Future<List<Steps>> getAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      stepsTable,
      orderBy: '${StepsField.day} ASC',
    );

    return records.map((e) => Steps.fromJson(e)).toList();
  }

  Future<int> insertRecord(Steps steps) async {
    final db = await DatabaseHelper.instance.database;

    try {
      return await db.insert(
        stepsTable,
        steps.toJson(),
      );
    } on Exception {
      return updateRecord(steps);
    }
  }

  Future<int> updateSteps() async {
    final db = await DatabaseHelper.instance.database;
    Steps today = await getToday();

    int steps = today.steps;
    steps++;

    Map<String, Object?> newToday = {
      'day': today.day,
      'steps': steps,
      'isToday': 1
    };

    return updateRecord(Steps.fromJson(newToday));
  }

  Future<int> updateRecord(Steps steps) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      stepsTable,
      steps.toJson(),
      where: '${StepsField.day} = ?',
      whereArgs: [steps.day],
    );
  }

  Future<int> updateToday() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      stepsTable,
      where: '${StepsField.isToday} = ?',
      whereArgs: [1],
    );

    Steps today = Steps.fromJson(records.first);
    Map<String, Object?> notToday = {
      'day': today.day,
      'steps': today.steps,
      'isToday': 0
    };

    await db.update(
      stepsTable,
      notToday,
      where: '${StepsField.isToday} = ?',
      whereArgs: [1],
    );

    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);

    final recordsToday = await db.query(
      stepsTable,
      where: '${StepsField.day} = ?',
      whereArgs: [day(dateFormat)],
    );

    if (recordsToday.isNotEmpty) {
      /* today = Steps.fromJson(recordsToday.first);
      notToday = {'day': today.day, 'steps': today.steps, 'isToday': 1}; */
      notToday = {'day': day(dateFormat), 'steps': 0, 'isToday': 1};

      return await db.update(
        stepsTable,
        notToday,
        where: '${StepsField.day} = ?',
        whereArgs: [day(dateFormat)],
      );
    } else {
      today = Steps(day: day(dateFormat), steps: 0, isToday: 1);
      print("update Today, no today");
      return insertRecord(today);
    }
  }

  Future<int> deleteRecord(String day) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      stepsTable,
      where: '${StepsField.day} = ?',
      whereArgs: [day],
    );
  }

  Future<int> deleteAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(stepsTable);
  }
}

int day(String day) {
  int d = 0;
  switch (day) {
    case ("Monday"):
      break;
    case ("Tuesday"):
      d = 1;
      break;
    case ("Wednesday"):
      d = 2;
      break;
    case ("Thursday"):
      d = 3;
      break;
    case ("Friday"):
      d = 4;
      break;
    case ("Saturday"):
      d = 5;
      break;
    case ("Sunday"):
      d = 6;
      break;
  }
  return d;
}
