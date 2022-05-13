import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../functions/future_functions.dart';
import '../models/notes_model.dart';
import '../pages/Notes_Data/note_list_view.dart';
import '../providers/note_provider.dart';

class NoteSearch extends SearchDelegate<String> {
  final bool isNoteByLabel;
  final String? label;

  NoteSearch({
    required this.isNoteByLabel,
    this.label = '',
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsConstant.bgScaffoldColor,
        elevation: 0,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyleConstants.contentStyle2, // query Color
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final notes = isNoteByLabel
        ? context.read<NoteProvider>().itemsByLabel(label!)
        : context.read<NoteProvider>().items;
    final List<Note> matchNotes = query.isEmpty
        ? []
        : notes
            .where(
              (e) =>
                  e.title.toLowerCase().contains(query.toLowerCase()) ||
                  e.content.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return Builder(
      // future: getViewMode(),
      builder: (context) {
        if (query.isEmpty) {
          return NoteListViewWidget(
            notes: notes,
            // viewMode: snapshot.data.toString(),
          );
        } else {
          return matchNotes.isNotEmpty
              ? NoteListViewWidget(
                  notes: matchNotes,
                  // viewMode: snapshot.data.toString(),
                )
              : messageText(
                  /* AppLocalizations.of(context)!
                    . */
                  "no_matching_results_were_found");
        }
      },
    );
  }
}
