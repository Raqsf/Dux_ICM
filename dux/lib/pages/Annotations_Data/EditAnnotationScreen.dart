import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../constants/assets_path.dart';
import '../../functions/future_functions.dart';
import '../../functions/picker_functions.dart';
import '../../models/annotations_model.dart';
import '../../providers/annotation_provider.dart';
import '../../utils/app_dialogs.dart';
import '../Notes_Data/PickLabelScreen.dart';
import '../Notes_Data/label_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'ImageDetailScreen.dart';
import 'annotation_form.dart';

class EditAnnotationScreen extends StatefulWidget {
  const EditAnnotationScreen({
    Key? key,
    this.annotation,
    this.defaultLabel,
  }) : super(key: key);

  final Annotation? annotation;
  final String? defaultLabel;

  @override
  _EditAnnotationScreenState createState() => _EditAnnotationScreenState();
}

class _EditAnnotationScreenState extends State<EditAnnotationScreen> {
  final _formKey = GlobalKey<FormState>();
  // list of temporarily deleted image files
  final List<File> _tmpDeletedImageFiles = [];
  // list of temporarily added image files
  final List<File> _tmpAddedImageFiles = [];

  late String _title;
  late String _label;
  late List<String> _imagePaths;

  late String _defaultLabel;

  @override
  void initState() {
    super.initState();
    _defaultLabel = widget.defaultLabel ?? '';

    _title = widget.annotation?.title ?? '';
    _imagePaths = widget.annotation?.imagePaths ?? [];

    if (_defaultLabel.isNotEmpty) {
      _label = _defaultLabel;
    } else {
      _label = widget.annotation?.label ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xff343A40),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.grey),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          deleteFileList(_tmpAddedImageFiles);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            /* leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                deleteFileList(_tmpAddedImageFiles);
              },
            ), */
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => _addImageFromCamera(ImageSource.camera),
              ),
              IconButton(
                onPressed: _addManyImagesFromGallery,
                icon: const Icon(Icons.photo),
              ),
              IconButton(
                onPressed: _deleteAnnotation,
                icon: const Icon(Icons.delete),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: _saveAnnotation,
                  child: const Text("Save"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor.withOpacity(0.3),
                  )),
                ),
              )
            ],
          ),
          body: ListView(
            children: [
              ImagesStaggeredGridView(
                imagePaths: _imagePaths,
                tmpDeletedImagePaths: _tmpDeletedImageFiles,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: AnnotationFormWidget(
                        title: _title,
                        onChangedTitle: (value) => _title = value,
                        // onChangedContent: (value) => _imagePaths = value,
                      ),
                    ),
                    if (_label.isNotEmpty) LabelCardWidget(title: _label)
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * .06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _defaultLabel.isEmpty ? _addOrChangeLabel : null,
                  icon: const Icon(Icons.label),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '${"Edited"}: ${DateFormat.yMd().format(DateTime.now())}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveAnnotation() async {
    print("AQUI");
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      final bool isUpdate = (widget.annotation != null);

      if (isUpdate) {
        _updateAnnotation();
      } else {
        _addAnnotation();
      }
      Navigator.of(context).pop();
      deleteFileList(_tmpDeletedImageFiles);
    }
  }

  _addAnnotation() {
    final annotation = Annotation(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _title.trim(),
      createdTime: DateTime.now(),
      label: _label,
      imagePaths: _imagePaths,
    );

    Provider.of<AnnotationProvider>(context, listen: false).add(annotation);
  }

  _updateAnnotation() {
    final annotation = widget.annotation!.copy(
      title: _title.trim(),
      createdTime: DateTime.now(),
      label: _label,
      imagePaths: _imagePaths,
    );

    Provider.of<AnnotationProvider>(context, listen: false).update(annotation);
  }

  _deleteAnnotation() async {
    if (widget.annotation != null) {
      final action = await showConfirmDialog(
        context: context,
        title: "Remove annotation?",
        content: "Are you sure you want to delete this annotation?",
        actionName: "Remove",
      );
      if (action == true) {
        await context.read<AnnotationProvider>().delete(widget.annotation!.id);

        // return the annotation so it can be undone
        Navigator.of(context).pop(widget.annotation);

        deleteFileList(_tmpAddedImageFiles);
      }
    } else {
      Navigator.of(context).pop(widget.annotation);
      deleteFileList(_tmpAddedImageFiles);
    }
  }

  _addImageFromCamera(ImageSource camera) async {
    try {
      File? imgFile = await pickImage(ImageSource.camera);

      if (imgFile == null) return;

      setState(() {
        _imagePaths.insert(0, imgFile.path);
        _tmpAddedImageFiles.add(imgFile);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  _addManyImagesFromGallery() async {
    try {
      List<File>? imgFileList = await pickManyImages();

      if (imgFileList == null) return;

      final imgPathList = imgFileList.map((e) => e.path).toList();

      setState(() {
        _imagePaths.insertAll(0, imgPathList);
        _tmpAddedImageFiles.addAll(imgFileList);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  _addOrChangeLabel() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PickLabelScreen(labelTitle: _label),
      ),
    );
    setState(() {
      _label = result;
    });
  }
}

class ImagesStaggeredGridView extends StatefulWidget {
  const ImagesStaggeredGridView({
    Key? key,
    required this.imagePaths,
    required this.tmpDeletedImagePaths,
  }) : super(key: key);

  final List<String> imagePaths;
  final List<File> tmpDeletedImagePaths;

  @override
  State<ImagesStaggeredGridView> createState() =>
      _ImagesStaggeredGridViewState();
}

class _ImagesStaggeredGridViewState extends State<ImagesStaggeredGridView> {
  @override
  Widget build(BuildContext context) {
    if (widget.imagePaths.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return StaggeredGridView.countBuilder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        staggeredTileBuilder: (index) {
          int total = widget.imagePaths.length;

          return getStaggeredTile(total: total, index: index);
        },
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageDetailScreen(
                  index: index,
                  imagePaths: widget.imagePaths,
                ),
              ),
            );
            setState(() {});
          },
          onLongPress: () async {
            final result = await showConfirmDialog(
                context: context,
                title: "Delete photos ?",
                content: "You want to remove this image",
                actionName: "Remove");
            if (result == true) {
              setState(() {
                widget.tmpDeletedImagePaths.add(File(widget.imagePaths[index]));
                widget.imagePaths.removeAt(index);
              });
            }
          },
          child: Hero(
            tag: 'viewImg$index',
            child: FadeInImage(
              placeholder: AssetImage(AssetsPath.placeholderImage),
              fadeInDuration: const Duration(milliseconds: 500),
              image: FileImage(
                File(widget.imagePaths[index]),
              ),
              fit: BoxFit.cover,
              placeholderFit: BoxFit.cover,
            ),
          ),
        ),
        itemCount: widget.imagePaths.length,
      );
    }
  }
}
