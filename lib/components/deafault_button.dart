import 'package:flutter/material.dart';

import '../configs/themes/custom_text_styles.dart';
import '../configs/themes/app_colors.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.text, required this.press});
  final String text;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(gradient: mainGradient()),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => press(),
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent
        ),
        child: Text(
          text,
          style: headerText,
        ),
      ),
    );
  }
}
