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

      if (today.day == dateFormat) {
        return Steps.fromJson(records.first);
      } else {
        // isToday tem q ficar false
        // dia de hoje tem de ficar true
        updateToday();
        return Steps.fromJson(records.first);
      }
    } else {
      DateTime date = DateTime.now();
      String dateFormat = DateFormat('EEEE').format(date);
      Steps s = Steps(day: dateFormat, steps: 0, isToday: 1);
      insertRecord(s);
      return s;
      //throw Exception('Today not found');
    }
  }

  Future<List<Steps>> getAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      stepsTable,
      orderBy: '${StepsField.day} DESC',
    );

    return records.map((e) => Steps.fromJson(e)).toList();
  }

  Future<int> insertRecord(Steps steps) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert(
      stepsTable,
      steps.toJson(),
    );
  }

  Future<int> updateSteps() async {
    print("HERE");
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      stepsTable,
      where: '${StepsField.isToday} = ?',
      whereArgs: [1],
    );

    Steps today = Steps.fromJson(records.first);
    int steps = today.steps;
    steps++;

    Map<String, Object?> newToday = {
      'day': today.day,
      'steps': steps,
      'isToday': 1
    };

    print(steps);
    print(newToday);

    return await db.update(
      stepsTable,
      newToday,
      where: '${StepsField.isToday} = ?',
      whereArgs: [1],
    );
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
    Map<String, Object?> newToday = {
      'day': today.day,
      'steps': today.steps,
      'isToday': 0
    };

    await db.update(
      stepsTable,
      newToday,
      where: '${StepsField.isToday} = ?',
      whereArgs: [1],
    );

    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);

    final recordsToday = await db.query(
      stepsTable,
      where: '${StepsField.day} = ?',
      whereArgs: [dateFormat],
    );

    today = Steps.fromJson(recordsToday.first);
    newToday = {'day': today.day, 'steps': today.steps, 'isToday': 1};

    return await db.update(
      stepsTable,
      newToday,
      where: '${StepsField.day} = ?',
      whereArgs: [dateFormat],
    );
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
