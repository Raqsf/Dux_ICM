import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/future_functions.dart';
import '../../models/annotations_model.dart';
import '../../providers/annotation_provider.dart';
import 'EditAnnotationScreen.dart';
import 'annotation_card.dart';

class AnnotationListViewWidget extends StatelessWidget {
  const AnnotationListViewWidget({
    Key? key,
    required this.notes,
    //required this.viewMode,
    this.scaffoldContext,
  }) : super(key: key);

  final List<Annotation> notes;
  //final String viewMode;
  final BuildContext? scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      itemBuilder: (context, index) => _noteItem(context, index),
    );
  }

  Widget _noteItem(BuildContext context, int index) {
    final currentAnnotation = notes[index];
    final noteProvider = context.read<AnnotationProvider>();

    return GestureDetector(
      onTap: () async {
        final Annotation? result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditAnnotationScreen(
              annotation: currentAnnotation,
            ),
          ),
        );
        if (result != null) {
          bool isUndo = false;
          ScaffoldMessenger.of(scaffoldContext!).hideCurrentSnackBar();
          ScaffoldMessenger.of(scaffoldContext!).showSnackBar(
            SnackBar(
              content: const Text(
                "The annotation has been deleted!",
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  isUndo = true;
                  noteProvider.add(result);
                },
              ),
            ),
          );
          Future.delayed(const Duration(seconds: 3), () {
            if (isUndo == false) {
              result.imagePaths.map((path) => File(path)).toList();
            }
          });
        }
        refreshOrGetData(scaffoldContext!);
      },
      child: AnnotationCardWidget(
        annotation: currentAnnotation,
      ),
    );
  }
}
