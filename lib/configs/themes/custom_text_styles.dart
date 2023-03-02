// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import './UI_parameters.dart';
import './app_colors.dart';

TextStyle cardTitle(context) => TextStyle(
    color: UIParameters.isDarkMode()
        ? Theme.of(context).textTheme.bodyLarge!.color
        : Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold);
TextStyle quizArea(context) => TextStyle(
    color: UIParameters.isDarkMode()
        ? Theme.of(context).textTheme.bodyLarge!.color
        : Theme.of(context).primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.bold);

const detailText = TextStyle(fontSize: 12);
// const headerText = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
const linkTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
const linkTextButtonStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);

const questionText = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);
const appBarTS = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: onSurfaceTextColor);

TextStyle countDownTimerTs() => TextStyle(
    letterSpacing: 2,
    color: UIParameters.isDarkMode()
        ? Theme.of(Get.context!).textTheme.bodyLarge!.color
        : Theme.of(Get.context!).primaryColor);
