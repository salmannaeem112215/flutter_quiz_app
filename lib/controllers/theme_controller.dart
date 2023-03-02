// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../configs/themes/app_dark_theme.dart';
import '../configs/themes/app_light_theme.dart';


class ThemeController extends   GetxController{
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;
  @override
  void onInit(){
    initializeThemeData();
    super.onInit();
  }

  initializeThemeData(){
    _darkTheme = DarkTheme().buildDarkTheme();
    _darkTheme = LightTheme().buildLigtTheme();
    _lightTheme = LightTheme().buildLigtTheme();
  }

  //GETTERR 
  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
  
}