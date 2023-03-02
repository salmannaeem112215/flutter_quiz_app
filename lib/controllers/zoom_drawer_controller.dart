// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../components/zoom_drawer/menu_item.dart';
import '../screens/change_password/change_password_screen.dart';
import '../screens/overall_result/overall_result_screen.dart';
import '../screens/quiz_rules/quiz_rules.dart';
import './auth_controller.dart';

class MyZoomDrawerController {
  Rxn<User?> user = Rxn();

  void goHome(MenuItem menuItem) {
    if (menuItem != MenuItem.home) {
      Get.back();
    }
  }

  // Added ZoomDrawerController to close but not closing

  void goQuizRules({required ZoomDrawerController zoomDrawerController,required MenuItem menuItem}) {
    if (menuItem == MenuItem.home) {
      toggleDrawer(zoomDrawerController);
      Get.toNamed(QuizRules.routeName);
    } else if (menuItem != MenuItem.quizArea) {
      Get.offAndToNamed(QuizRules.routeName);
    }
  }

  void goOverallPoint({required ZoomDrawerController zoomDrawerController,required MenuItem menuItem}) {
    if (menuItem == MenuItem.home) {
       toggleDrawer(zoomDrawerController);
      Get.toNamed(OverallResultScreen.routeName);

    } else if (menuItem != MenuItem.overallPoint) {
      Get.offAndToNamed(OverallResultScreen.routeName);
    }
  }

  void goChangePassword({required ZoomDrawerController zoomDrawerController,required MenuItem menuItem}) {
    if (menuItem == MenuItem.home) {
      Get.toNamed(ChangePasswordScreen.routeName);
       toggleDrawer(zoomDrawerController);
    } else if (menuItem != MenuItem.changePassword) {
      Get.offAndToNamed(ChangePasswordScreen.routeName);
    }
  }

  void toggleDrawer(ZoomDrawerController zoomDrawerController) {
    zoomDrawerController.toggle?.call();
  }

  void signOut() {
    AuthController authController = Get.find();

    authController.signOut();
  }
}
