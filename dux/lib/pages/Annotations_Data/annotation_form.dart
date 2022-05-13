import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class AnnotationFormWidget extends StatelessWidget {
  const AnnotationFormWidget({
    Key? key,
    required this.title,
    required this.onChangedTitle,
    //required this.onChangedContent,
  }) : super(key: key);

  final String title;
  final ValueChanged onChangedTitle;
  // final ValueChanged onChangedContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: null,
          initialValue: title,
          style: TextStyleConstants.titleStyle1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Title",
          ),
          validator: (value) => value!.length > 50
              ? "Title should not exceed 50 characters"
              : null,
          onChanged: onChangedTitle,
          textInputAction: TextInputAction.next,
        ),
        /* TextFormField(
          maxLines: null,
          initialValue: content,
          style: TextStyleConstants.contentStyle2,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Annotation",
          ),
          validator: (value) => value!.isEmpty ? "Blank annotation" : null,
          onChanged: onChangedContent,
          textInputAction: TextInputAction.done,
        ) */
      ],
    );
  }
}
