import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';
import '../../functions/future_functions.dart';
import '../../models/label_model.dart';
import '../../providers/note_provider.dart';
import '../../utils/note_search.dart';
import 'EditNotesScreen.dart';
import 'no_note_ui.dart';
import 'note_list_view.dart';

class AllNotesByLabelScreen extends StatefulWidget {
  const AllNotesByLabelScreen({
    Key? key,
    required this.label,
  }) : super(key: key);

  final Label label;

  @override
  State<AllNotesByLabelScreen> createState() => _AllNotesByLabelScreenState();
}

class _AllNotesByLabelScreenState extends State<AllNotesByLabelScreen> {
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isLoading == true) {
      Future.wait([
        refreshOrGetAnnotationsData(context),
      ]).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.label.title,
          style: TextStyleConstants.titleAppBarStyle,
        ),
        actions: [
          /* if (context
              .watch<NoteProvider>()
              .itemsByLabel(widget.label.title)
              .isNotEmpty)
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: NoteSearch(
                    isNoteByLabel: true,
                    label: widget.label.title,
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ), */
          const SizedBox(
            width: 6,
          )
        ],
      ),
      // drawer: const DrawerScreen(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => refreshOrGetAnnotationsData(context),
              child: Consumer<NoteProvider>(
                builder: (context, noteProvider, child) => noteProvider
                        .itemsByLabel(widget.label.title)
                        .isNotEmpty
                    ? NoteListViewWidget(
                        notes: noteProvider.itemsByLabel(widget.label.title),
                        // viewMode: _viewMode,
                        scaffoldContext: _scaffoldKey.currentContext,
                      )
                    : child!,
                child: const NoNoteUIWidget(
                  title: "There are no notes for this label",
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  EditNoteScreen(defaultLabel: widget.label.title),
            ),
          );
        },
      ),
    );
  }
}
