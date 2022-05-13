import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';
import '../../functions/future_functions.dart';
import '../../models/label_model.dart';
import '../../providers/annotation_provider.dart';
import '../Notes_Data/no_note_ui.dart';
import 'EditAnnotationScreen.dart';
import 'annotation_list_view.dart';

class AllAnnotationsByLabelScreen extends StatefulWidget {
  const AllAnnotationsByLabelScreen({
    Key? key,
    required this.label,
  }) : super(key: key);

  final Label label;

  @override
  State<AllAnnotationsByLabelScreen> createState() =>
      _AllAnnotationsByLabelScreenState();
}

class _AllAnnotationsByLabelScreenState
    extends State<AllAnnotationsByLabelScreen> {
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
          if (context
              .watch<AnnotationProvider>()
              .itemsByLabel(widget.label.title)
              .isNotEmpty)
            /* IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: AnnotationSearch(
                    isAnnotationByLabel: true,
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
              child: Consumer<AnnotationProvider>(
                builder: (context, noteProvider, child) => noteProvider
                        .itemsByLabel(widget.label.title)
                        .isNotEmpty
                    ? AnnotationListViewWidget(
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
                  EditAnnotationScreen(defaultLabel: widget.label.title),
            ),
          );
        },
      ),
    );
  }
}
