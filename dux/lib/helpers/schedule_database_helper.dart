import '../models/schedule_model.dart';
import 'database_helper.dart';

class ScheduleDatabaseHelper {
  static final ScheduleDatabaseHelper instance = ScheduleDatabaseHelper._init();
  ScheduleDatabaseHelper._init();

  Future<String> getRecord(int id) async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      scheduleTable,
      where: '${ScheduleField.id} = ? ',
      whereArgs: [id],
    );

    if (records.isNotEmpty) {
      ScheduleM temp = ScheduleM.fromJson(records.first);

      return ScheduleM.getSubject(temp);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ScheduleM>> getAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      scheduleTable,
      orderBy: '${ScheduleField.id} ASC',
    );

    return records.map((e) => ScheduleM.fromJson(e)).toList();
  }

  Future<int> insertRecord(ScheduleM schedule) async {
    final db = await DatabaseHelper.instance.database;

    try {
      return await db.insert(
        scheduleTable,
        schedule.toJson(),
      );
    } on Exception {
      return updateRecord(schedule);
    }
  }

  Future<int> updateRecord(ScheduleM schedule) async {
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
