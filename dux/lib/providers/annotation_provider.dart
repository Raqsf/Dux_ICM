import 'package:flutter/material.dart';
import '../helpers/annotation_database_helper.dart';
import '../models/annotations_model.dart';

class AnnotationProvider with ChangeNotifier {
  List<Annotation> _items = [];

  List<Annotation> get items => [..._items];

  List<Annotation> itemsByLabel(String titleLabel) =>
      _items.where((e) => e.label == titleLabel).toList();

  Future fetchAndSet() async {
    _items = await AnnotationDatabaseHelper.instance.getAllRecords();
    notifyListeners();
  }

  Future add(Annotation annotation) async {
    _items.insert(0, annotation);
    notifyListeners();
    await AnnotationDatabaseHelper.instance.insertRecord(annotation);
  }

  Future update(Annotation annotation) async {
    final index = _items.indexWhere((e) => e.id == annotation.id);

    if (index != -1) {
      _items[index] = annotation;
      notifyListeners();
      await AnnotationDatabaseHelper.instance.updateRecord(annotation);
    }
  }

  Future delete(int id) async {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
    await AnnotationDatabaseHelper.instance.deleteRecord(id);
  }

  Future deleteAll() async {
    _items.clear();
    notifyListeners();
    await AnnotationDatabaseHelper.instance.deleteAllRecords();
  }

  Future removeLabelContent({required String content}) async {
    int n = _items.length;
    for (var i = 0; i < n; i++) {
      if (_items[i].label == content) {
        var newAnnotation = _items[i].copy(label: '');
        _items[i] = newAnnotation;
        await AnnotationDatabaseHelper.instance.updateRecord(newAnnotation);
      }
    }
    notifyListeners();
  }

  Future removeAllLabelContent() async {
    _items = [..._items.map((e) => e.copy(label: '')).toList()];
    notifyListeners();
    await AnnotationDatabaseHelper.instance
        .changeFieldValueOfAllRecords(field: AnnotationField.label, value: '');
  }
}
