import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../models/label_model.dart';
import '../../models/notes_model.dart';
import '../../providers/label_provider.dart';
import '../../providers/note_provider.dart';

class DialogLabelWidget extends StatefulWidget {
  const DialogLabelWidget({
    Key? key,
    this.label,
  }) : super(key: key);

  final Label? label;

  @override
  State<DialogLabelWidget> createState() => _DialogLabelWidgetState();
}

class _DialogLabelWidgetState extends State<DialogLabelWidget> {
  final _labelController = TextEditingController();

  bool _isSubmitted = false;

  String? get _errorMessage {
    final text = _labelController.text.trim();
    if (text.isEmpty) {
      return "Label cannot be empty";
    }
    if (text.length > 30) {
      return "Label can not be more than 30 characters";
    }
    final indexLabelExist =
        Provider.of<LabelProvider>(context, listen: false).items.indexWhere(
              (e) => e.title.toLowerCase() == text.toLowerCase(),
            );
    if (indexLabelExist != -1) {
      return "Label already exists";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _labelController.text = widget.label?.title ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _labelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _labelController,
      builder: (context, value, child) => AlertDialog(
        title: widget.label == null
            ? const Text("Add label")
            : const Text("Edit label"),
        content: TextField(
          controller: _labelController,
          autofocus: true,
          decoration: InputDecoration(
            errorText: _isSubmitted ? _errorMessage : null,
          ),
          style: TextStyleConstants.contentStyle3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('');
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _labelController.value.text.isNotEmpty ? _submit : null,
            child: widget.label == null
                ? const Text("Create")
                : const Text("Edit"),
          )
        ],
      ),
    );
  }

  _submit() {
    setState(() {
      _isSubmitted = true;
    });

    if (_errorMessage == null) {
      if (widget.label == null) {
        _addLabel();
      } else {
        _updateLabel();
      }

      Navigator.of(context).pop(_labelController.text.trim());
    }
  }

  _addLabel() {
    final label = Label(
      title: _labelController.text.trim(),
    );
    context.read<LabelProvider>().add(label);
  }

  _updateLabel() {
    String newTitle = _labelController.text.trim();

    final label = widget.label!.copy(title: newTitle);

    Provider.of<LabelProvider>(context, listen: false).update(label);

    //* update note when label changed

    List<Note> temptNotes = Provider.of<NoteProvider>(context, listen: false)
        .items
        .where((e) => e.label == widget.label!.title)
        .toList();

    List<Note> notesDidUpdated =
        temptNotes.map((e) => e.copy(label: newTitle)).toList();

    for (var element in notesDidUpdated) {
      context.read<NoteProvider>().update(element);
    }
  }
}
