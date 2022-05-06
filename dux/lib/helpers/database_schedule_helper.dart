import '../models/schedule_model.dart';
import 'database_helper.dart';

class ScheduleDatabaseHelper {
  static final ScheduleDatabaseHelper instance = ScheduleDatabaseHelper._init();
  ScheduleDatabaseHelper._init();

  Future<Schedule> getRecord(int id) async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      scheduleTable,
      where: '${ScheduleField.id} = ?',
      whereArgs: [id],
    );

    if (records.isNotEmpty) {
      return Schedule.fromJson(records.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Schedule>> getAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      scheduleTable,
      orderBy: '${ScheduleField.id} DESC',
    );

    return records.map((e) => Schedule.fromJson(e)).toList();
  }

  Future<int> insertRecord(Schedule schedule) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert(
      scheduleTable,
      schedule.toJson(),
    );
  }

  Future<int> updateRecord(Schedule schedule) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      scheduleTable,
      schedule.toJson(),
      where: '${ScheduleField.id} = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<int> deleteRecord(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      scheduleTable,
      where: '${ScheduleField.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(scheduleTable);
  }
}
