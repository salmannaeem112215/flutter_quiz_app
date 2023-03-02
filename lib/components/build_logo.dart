import 'package:flutter/material.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  final double? height;
  final double? width;
  final String withOutTextLogo = "assets/images/app_splash_logo.png";
  final String withTextLogo = "assets/images/app_splash_logo.png";

  @override
  Widget build(BuildContext context) {
    if (height != null && width == null) {
      return SizedBox(
        height: height,
        child: Image.asset(
          withOutTextLogo,
        ),
      );
    } else if (height == null && width != null) {
      return SizedBox(
        height: height,
        child: Image.asset(
          withOutTextLogo,
        ),
      );
    } else {
      return SizedBox(
        height: 100,
        child: Image.asset(
          withOutTextLogo,
        ),
      );
    }
  }
}
