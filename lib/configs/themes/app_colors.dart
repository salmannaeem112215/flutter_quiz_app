// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import './UI_parameters.dart';
import './app_dark_theme.dart';
import './app_light_theme.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFFf3accb);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notAnsweredColor = Color(0xFF2a3c65);

const Color greyShadowEffect =Color(0xA63D3D3D);
const Color whiteShadowEffect =Color.fromARGB(166, 255, 255, 255);

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorLight, primaryColorLight]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorDark, primaryColorDark]);

LinearGradient mainGradient() =>
    UIParameters.isDarkMode() ? mainGradientDark:mainGradientLight ;

Color customScaffoldColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);
Color answerSelectedCOlor() => UIParameters.isDarkMode()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;
Color answerBorderColor() => UIParameters.isDarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);
