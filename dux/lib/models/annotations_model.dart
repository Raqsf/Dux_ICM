import 'package:flutter/material.dart';

const String annotationTable = 'Annotation';

class AnnotationField {
  static const String id = '_id';
  static const String title = 'title';
  static const String imagePaths = 'imagePaths';
  static const String createdTime = 'createdTime';
  static const String label = 'label';
}

class Annotation {
  final int id;
  final String title;
  final String label;
  final List<String> imagePaths;
  final DateTime createdTime;

  Annotation({
    required this.id,
    required this.title,
    required this.createdTime,
    required this.label,
    required this.imagePaths,
  });

  static Annotation fromJson(Map<String, Object?> json) => Annotation(
        id: json[AnnotationField.id] as int,
        title: json[AnnotationField.title].toString(),
        createdTime:
            DateTime.parse(json[AnnotationField.createdTime].toString()),
        label: json[AnnotationField.label].toString(),
        imagePaths: json[AnnotationField.imagePaths].toString().isEmpty
            ? []
            : json[AnnotationField.imagePaths].toString().split('||'),
      );

  Map<String, Object?> toJson() => {
        AnnotationField.id: id,
        AnnotationField.title: title,
        AnnotationField.label: label,
        AnnotationField.imagePaths:
            imagePaths.isEmpty ? '' : imagePaths.join('||'),
        AnnotationField.createdTime: createdTime.toIso8601String(),
      };

  Annotation copy({
    int? id,
    String? title,
    String? label,
    List<String>? imagePaths,
    DateTime? createdTime,
  }) =>
      Annotation(
        id: id ?? this.id,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
        label: label ?? this.label,
        imagePaths: imagePaths ?? this.imagePaths,
      );
}
