import '../models/annotations_model.dart';
import 'database_helper.dart';

class AnnotationDatabaseHelper {
  static final AnnotationDatabaseHelper instance =
      AnnotationDatabaseHelper._init();
  AnnotationDatabaseHelper._init();

  Future<Annotation> getRecord(int id) async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      annotationTable,
      where: '${AnnotationField.id} = ?',
      whereArgs: [id],
    );

    if (records.isNotEmpty) {
      return Annotation.fromJson(records.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Annotation>> getAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    final records = await db.query(
      annotationTable,
      orderBy: '${AnnotationField.createdTime} DESC',
    );

    return records.map((e) => Annotation.fromJson(e)).toList();
  }

  Future<int> insertRecord(Annotation annotation) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert(
      annotationTable,
      annotation.toJson(),
    );
  }

  Future<int> updateRecord(Annotation annotation) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      annotationTable,
      annotation.toJson(),
      where: '${AnnotationField.id} = ?',
      whereArgs: [annotation.id],
    );
  }

  Future<int> changeFieldValueOfAllRecords({
    required String field,
    required String value,
  }) async {
    final db = await DatabaseHelper.instance.database;

    return await db
        .rawUpdate('UPDATE $annotationTable SET $field = ?', [value]);
  }

  Future<int> deleteRecord(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      annotationTable,
      where: '${AnnotationField.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllRecords() async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(annotationTable);
  }
}
