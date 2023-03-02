import 'package:flutter/material.dart';

import '../configs/themes/custom_text_styles.dart';

class TextWithLink extends StatelessWidget {
  const TextWithLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.press,
  });
  final String text;
  final String linkText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: linkTextStyle
          
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: press,
          child: Text(
            linkText,
            style: linkTextButtonStyle,
          ),
        ),
      ],
    );
  }
}
