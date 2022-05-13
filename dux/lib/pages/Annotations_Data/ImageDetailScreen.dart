import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../constants/app_constants.dart';
import 'BluetoothScreen.dart';

class ImageDetailScreen extends StatefulWidget {
  const ImageDetailScreen({
    Key? key,
    required this.index,
    required this.imagePaths,
  }) : super(key: key);

  final int index;
  final List<String> imagePaths;

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        /* leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(widget.imagePaths);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ), */
        title: Text(
          '${_currentIndex + 1}/${widget.imagePaths.length} pictures',
          style: TextStyleConstants.titleAppBarStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.imagePaths.length == 1) {
                //Navigator.of(context).pop();
                AlertDialog(
                  title: const Text('Needs at least one image'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text(
                            'To add a note, it needs to have at least one image.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              } else {
                setState(() {
                  widget.imagePaths.removeAt(_currentIndex);
                  if (widget.imagePaths.length == _currentIndex) {
                    _currentIndex--;
                  }
                });
              }
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
              onPressed: (() {
                /* Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BluetoothScreen(),
                )); */
              }),
              icon: Icon(Icons.bluetooth))
        ],
      ),
      body: SizedBox(
        child: Hero(
          tag: 'viewImg$_currentIndex',
          child: PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.imagePaths.length,
            builder: (BuildContext context, int index) =>
                PhotoViewGalleryPageOptions(
              imageProvider: FileImage(
                File(widget.imagePaths[index]),
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 4,
              filterQuality: FilterQuality.high,
            ),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
