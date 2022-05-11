import 'package:dux/pages/Notes_Data/AllLabelsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/future_functions.dart';
import '../../providers/note_provider.dart';
import '../../utils/note_search.dart';
import 'EditNotesScreen.dart';
import 'no_note_ui.dart';
import 'note_list_view.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({Key? key}) : super(key: key);

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  // String _viewMode = ViewMode.list.name;
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
    refreshOrGetData(context);

    if (_isLoading == true) {
      Future.wait([
        refreshOrGetData(context),
      ]).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Notes'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            /* title: Text(
          /* AppLocalizations.of(context)!. */ "all_notes",
          style: TextStyleConstants.titleAppBarStyle, 
        ), */
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop('');
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              if (context.watch<NoteProvider>().items.isNotEmpty)
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NoteSearch(isNoteByLabel: false),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              const SizedBox(
                width: 6,
              )
            ],
            bottom: const TabBar(
              indicatorColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.note_alt)),
                Tab(icon: Icon(Icons.label)),
              ],
            ),
          ),
          body: TabBarView(children: [
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => refreshOrGetData(context),
                    child: Consumer<NoteProvider>(
                      builder: (context, noteProvider, child) =>
                          noteProvider.items.isNotEmpty
                              ? NoteListViewWidget(
                                  notes: noteProvider.items,
                                  // viewMode: _viewMode,
                                  scaffoldContext: _scaffoldKey.currentContext!,
                                )
                              : child!,
                      child: const NoNoteUIWidget(
                        title: "Your notes after adding will appear here",
                      ),
                    ),
                  ),
            const AllLabelsScreen(isNote: true)
          ]),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditNoteScreen(),
              ));
            },
          ),
        ));
  }
}
