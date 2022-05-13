import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../models/annotations_model.dart';
import '../Notes_Data/label_card.dart';
import 'images_staggered_grid_view_widget.dart';

class AnnotationCardWidget extends StatelessWidget {
  const AnnotationCardWidget({
    Key? key,
    required this.annotation,
  }) : super(key: key);

  final Annotation annotation;

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: note.bgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: /* note.bgColor == ColorsConstant.bgScaffoldColor
              ? */
              Colors.grey /* : note.bgColor */,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImagesStaggeredGridViewWidget(
            imagePaths: annotation.imagePaths,
            limitedQuantity: LimitedQuantity.yes,
          ),
          /* if (note.imagePaths.isNotEmpty)
            ImagesStaggeredGridViewWidget(
              imagePaths: note.imagePaths,
              limitedQuantity: LimitedQuantity.yes,
            ), */
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (annotation.title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      annotation.title,
                      style: TextStyleConstants.titleStyle2,
                      maxLines: 2,
                    ),
                  ),
                /* Text(
                  annotation.content,
                  style: TextStyleConstants.contentStyle3,
                  maxLines: 5,
                ), */
                if (annotation.label.isNotEmpty)
                  LabelCardWidget(title: annotation.label)
              ],
            ),
          )
        ],
      ),
    );
  }
}
