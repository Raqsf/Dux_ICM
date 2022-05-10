import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/label_model.dart';
import '../models/notes_model.dart';
import '../models/annotations_model.dart';
import '../models/schedule_model.dart';

class DatabaseHelper {
  static const dbName = 'note_app.db';

  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb(dbName);

    return _database!;
  }

  Future<File> _getLocalFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File(dir);
  }

  _initDb(String dbName) async {
    var appDir = await _getLocalFile() /* getApplicationDocumentsDirectory() */;

    String path = join(appDir.path, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $noteTable (
              ${NoteField.id} INTEGER PRIMARY KEY,
              ${NoteField.title} TEXT, 
              ${NoteField.content} TEXT, 
              ${NoteField.label} TEXT,
              ${NoteField.bgColor} INTEGER, 
              ${NoteField.createdTime} TEXT
            )
          ''');

        await db.execute('''
            CREATE TABLE $labelTable (
              ${LabelField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${LabelField.title} TEXT
            )
          ''');

        await db.execute('''
            CREATE TABLE $annotationTable (
              ${AnnotationField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${AnnotationField.title} TEXT,
              ${AnnotationField.label} TEXT,
              ${AnnotationField.imagePaths} TEXT,
              ${AnnotationField.createdTime} TEXT
            )
          ''');

        await db.execute('''
            CREATE TABLE $scheduleTable (
              ${ScheduleField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${ScheduleField.subject} TEXT,
              ${ScheduleField.day} TEXT,
              ${ScheduleField.hours} TEXT
            )
          ''');
      },
    );
  }
}
