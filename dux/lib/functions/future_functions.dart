import 'dart:io';

import 'package:dux/providers/annotation_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../providers/label_provider.dart';
import '../providers/note_provider.dart';
import '../providers/steps_provider.dart';
import '../providers/schedule_provider.dart';

Future refreshOrGetData(BuildContext context) async {
  await Provider.of<NoteProvider>(context, listen: false).fetchAndSet();
  Provider.of<LabelProvider>(context, listen: false).fetchAndSet();
  Provider.of<AnnotationProvider>(context, listen: false).fetchAndSet();
  Provider.of<StepsProvider>(context, listen: false).fetchAndSet();
  Provider.of<StepsProvider>(context, listen: false).getToday();
  Provider.of<SchedulelProvider>(context, listen: false).fetchAndSet();
  Provider.of<SchedulelProvider>(context, listen: false).getItemByDayHours();
}

Future? openLink(String urlString) async {
  if (await canLaunchUrlString(urlString)) {
    await launchUrlString(urlString);
  } else {
    throw 'Could not launch $urlString';
  }
}

/* Future<String> getViewMode() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('view-mode')) return ViewMode.staggeredGrid.name;

  return prefs.getString('view-mode') ?? ViewMode.staggeredGrid.name;
} */

/* Future<String> changeViewMode(String viewMode) async {
  final prefs = await SharedPreferences.getInstance();
  if (viewMode == ViewMode.list.name) {
    viewMode = ViewMode.staggeredGrid.name;
  } else {
    viewMode = ViewMode.list.name;
  }
  await prefs.setString('view-mode', viewMode);
  return viewMode;
} */

Future deleteFile(File file) async {
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    throw 'file read error';
  }
}

Future deleteFileList(List<File> fileList) async {
  for (var file in fileList) {
    await deleteFile(file);
  }
}

Future deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();
  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}
