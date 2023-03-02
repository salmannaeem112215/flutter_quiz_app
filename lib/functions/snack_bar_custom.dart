import 'package:flutter/material.dart';

import '../constants.dart';

class SnackBarCutom {
  SnackBarCutom({
    required BuildContext ctx,
    Widget? widget,
    String? text,
    Duration duration = const Duration(seconds: 4),
  }) {
    Widget content;
    if (widget != null && text == null) {
      content = widget;
    } else if (widget == null && text != null) {
      content = SizedBox(
        width: double.infinity,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      content = const SizedBox();
    }
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: kPrimaryColor.withOpacity(0.9),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        padding: const EdgeInsets.all(20),
        content: content,
      ),
    );
  }
}
