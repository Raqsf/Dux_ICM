import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/future_functions.dart';
import '../../models/notes_model.dart';
import '../../providers/note_provider.dart';
import 'EditNotesScreen.dart';
import 'note_card.dart';

class NoteListViewWidget extends StatelessWidget {
  const NoteListViewWidget({
    Key? key,
    required this.notes,
    //required this.viewMode,
    this.scaffoldContext,
  }) : super(key: key);

  final List<Note> notes;
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
    final currentNote = notes[index];
    final noteProvider = context.read<NoteProvider>();

    return GestureDetector(
      onTap: () async {
        final Note? result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditNoteScreen(
              note: currentNote,
            ),
          ),
        );
        if (result != null) {
          bool isUndo = false;
          ScaffoldMessenger.of(scaffoldContext!).hideCurrentSnackBar();
          ScaffoldMessenger.of(scaffoldContext!).showSnackBar(
            SnackBar(
              content: const Text(
                "The note has been deleted!",
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
          /* Future.delayed(const Duration(seconds: 3), () {
            if (isUndo == false) {
              deleteFileList(
                result.imagePaths.map((path) => File(path)).toList(),
              );
            }
          }); */
        }
        refreshOrGetData(scaffoldContext!);
      },
      child: NoteCardWidget(
        note: currentNote,
      ),
    );
  }
}
