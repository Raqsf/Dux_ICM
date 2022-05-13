import 'package:dux/pages/Annotations_Data/AllAnotationsByLabel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/label_model.dart';
import '../../providers/label_provider.dart';
import '../../providers/note_provider.dart';
import '../../utils/app_dialogs.dart';
import 'AllNotesByLabelScreen.dart';
import 'custom_list_tile.dart';
import 'dialog_label.dart';
import 'no_note_ui.dart';

class AllLabelsScreen extends StatelessWidget {
  const AllLabelsScreen({Key? key, required this.isNote}) : super(key: key);
  static const routeName = '/all-label';
  final bool isNote;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<LabelProvider>().fetchAndSet(),
      child: Consumer<LabelProvider>(
          builder: (context, labelProvider, child) => labelProvider
                  .items.isNotEmpty
              ? Column(children: [
                  Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const DialogLabelWidget(),
                            );
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add),
                                Text('Add a new label')
                              ]))),
                  Expanded(
                      flex: 4,
                      child: LabelListView(
                          labels: labelProvider.items, isNote: isNote))
                ])
              : child!,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: TextButton(
                      /* style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor.withOpacity(0.5)),
                    ), */
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const DialogLabelWidget(),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add),
                            Text('Add a new label')
                          ]))),
              const Expanded(
                  flex: 4,
                  child: NoNoteUIWidget(
                    title: "There are currently no labels",
                  )),
            ],
          )),
    );
  }
}

class LabelListView extends StatelessWidget {
  const LabelListView({
    Key? key,
    required this.labels,
    required this.isNote,
  }) : super(key: key);

  final List<Label> labels;
  final bool isNote;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final currentLabel = labels[index];

        return Dismissible(
          key: ValueKey<int>(currentLabel.id ?? 0),
          direction: DismissDirection.endToStart,
          child: CustomListTileWidget(
            title: currentLabel.title,
            iconData: Icons.label_outline,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => isNote
                      ? AllNotesByLabelScreen(label: currentLabel)
                      : AllAnnotationsByLabelScreen(label: currentLabel),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => DialogLabelWidget(
                    label: currentLabel,
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          background: Container(
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white70,
            ),
            alignment: Alignment.centerRight,
          ),
          confirmDismiss: (_) => showConfirmDialog(
            context: context,
            title: "Remove label?",
            content:
                "We will remove this label from all your notes this label will also be removed",
            actionName: "Remove",
          ),
          onDismissed: (_) async {
            await context.read<LabelProvider>().delete(currentLabel.id!);
            context.read<NoteProvider>().removeLabelContent(
                  content: currentLabel.title,
                );
          },
        );
      },
      itemCount: labels.length,
      padding: const EdgeInsets.only(bottom: 16),
    );
  }
}
