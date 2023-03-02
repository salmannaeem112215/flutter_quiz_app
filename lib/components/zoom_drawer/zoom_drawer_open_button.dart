import 'package:flutter/material.dart';

import '../../configs/themes/UI_parameters.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/question_paper/app_icons.dart';
import '../../widgets/app_circle_button.dart';

class ZoomDrawerOpenButton extends StatelessWidget {
  const ZoomDrawerOpenButton({
    super.key,
    required this.onTap,
    required this.title,
  });
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    final padding = UIParameters.mobileScreenPadding;
    return Padding(
      padding: EdgeInsets.only(
        top: padding.top,
        left: padding.left,
        right: padding.right,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppCircularButton(
            onTap: onTap,
            child: const Icon(
              AppIcons.menuLeft,
            ),
          ),
          const Spacer(),
          Text(title, style: headerText),
          const Spacer(),
        ],
      ),
    );
  }
}
