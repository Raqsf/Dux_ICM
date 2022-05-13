import 'package:dux/pages/Notes_Data/AllLabelsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/future_functions.dart';
import '../../providers/annotation_provider.dart';
import '../../utils/note_search.dart';
import '../Notes_Data/no_note_ui.dart';
import 'EditAnnotationScreen.dart';
import 'annotation_list_view.dart';

class AllAnnotationsScreen extends StatefulWidget {
  const AllAnnotationsScreen({Key? key}) : super(key: key);

  @override
  State<AllAnnotationsScreen> createState() => _AllAnnotationsScreenState();
}

class _AllAnnotationsScreenState extends State<AllAnnotationsScreen> {
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
    refreshOrGetAnnotationsData(context);

    if (_isLoading == true) {
      Future.wait([
        /* _loadViewMode(),
        Provider.of<LocaleProvider>(context, listen: false).fetchLocale(), */
        refreshOrGetAnnotationsData(context),
      ]).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  /* Future _loadViewMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('view-mode')) return;
    setState(() {
      _viewMode = prefs.getString('view-mode') ?? ViewMode.staggeredGrid.name;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Annotations'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            /* title: Text(
          /* AppLocalizations.of(context)!. */ "all_notes",
          style: TextStyleConstants.titleAppBarStyle, 
        ), */
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              if (context.watch<AnnotationProvider>().items.isNotEmpty)
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
                    onRefresh: () => refreshOrGetAnnotationsData(context),
                    child: Consumer<AnnotationProvider>(
                      builder: (context, noteProvider, child) =>
                          noteProvider.items.isNotEmpty
                              ? AnnotationListViewWidget(
                                  notes: noteProvider.items,
                                  // viewMode: _viewMode,
                                  scaffoldContext: _scaffoldKey.currentContext!,
                                )
                              : child!,
                      child: const NoNoteUIWidget(
                        title: "Your annotations after adding will appear here",
                      ),
                    ),
                  ),
            const AllLabelsScreen(isNote: false)
          ]),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditAnnotationScreen(),
              ));
            },
          ),
        ));
  }
}
