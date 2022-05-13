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
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday8();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday9();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday10();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday11();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday12();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday13();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday14();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday15();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday16();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday17();
  Provider.of<SchedulelProvider>(context, listen: false).getItemMonday18();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday8();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday9();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday10();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday11();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday12();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday13();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday14();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday15();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday16();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday17();
  Provider.of<SchedulelProvider>(context, listen: false).getItemTuesday18();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday8();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday9();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday10();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday11();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday12();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday13();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday14();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday15();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday16();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday17();
  Provider.of<SchedulelProvider>(context, listen: false).getItemWednesday18();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday8();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday9();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday10();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday11();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday12();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday13();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday14();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday15();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday16();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday17();
  Provider.of<SchedulelProvider>(context, listen: false).getItemThursday18();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday8();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday9();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday10();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday11();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday12();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday13();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday14();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday15();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday16();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday17();
  Provider.of<SchedulelProvider>(context, listen: false).getItemFriday18();
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
