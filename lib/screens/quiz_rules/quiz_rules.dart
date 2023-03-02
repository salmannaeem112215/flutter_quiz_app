// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../../controllers/overall_result_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import '../../components/zoom_drawer/custom_zoom_drawer.dart';
import '../../components/zoom_drawer/menu_item.dart';
import '../../configs/themes/app_colors.dart';
import '../../components/zoom_drawer/menu_screen.dart';
import './components/body.dart';

class QuizRules extends StatelessWidget {
  const QuizRules({super.key});

  static String routeName = '/quiz_rules';
  @override
  Widget build(BuildContext context) {
    ZoomDrawerController zoomDrawerController = ZoomDrawerController();
    MyZoomDrawerController myZomDrawerController = Get.find();
    OverallResultController orController = Get.find();
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomZoomDrawer(
          zoomDrawerController: zoomDrawerController,
          menuScreen: MenuScreen(
            ctx: context,
            zoomDrawerController: zoomDrawerController,
            menuItem: MenuItem.quizArea, overallResult: ()=>orController.getTotalPoint().toString(),
          ),
          mainScreen: Body(
            toggleDrawer: () =>
                myZomDrawerController.toggleDrawer(zoomDrawerController),
          ),
        ),
      ),
    );
  }
}
