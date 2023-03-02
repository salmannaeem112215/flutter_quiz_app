// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:study_app/controllers/overall_result_controller.dart';

import '../../components/zoom_drawer/custom_zoom_drawer.dart';
import '../../components/zoom_drawer/menu_item.dart';
import '../../components/zoom_drawer/menu_screen.dart';
import '../../configs/themes/app_colors.dart';
import '../../controllers/zoom_drawer_controller.dart';
import './components/body.dart';

class OverallResultScreen extends StatelessWidget {
  const OverallResultScreen({super.key});
  static String routeName = '/overall_result';
  @override
  Widget build(BuildContext context) {
    ZoomDrawerController zoomDCtrl = ZoomDrawerController();
    MyZoomDrawerController myZoomDrawerController = Get.find();
    OverallResultController orController = Get.find();
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomZoomDrawer(
          zoomDrawerController: zoomDCtrl,
          menuScreen: MenuScreen(
            ctx: context,
            zoomDrawerController: zoomDCtrl,
            menuItem: MenuItem.overallPoint, overallResult: ()=>orController.getTotalPoint().toString(),
            
          ),
          mainScreen: Body(
            toggleDrawer: () => myZoomDrawerController.toggleDrawer(zoomDCtrl),
          ),
        ),
      ),
    );
  }
}
