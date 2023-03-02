// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../../components/zoom_drawer/custom_zoom_drawer.dart';
import '../../components/zoom_drawer/menu_item.dart';
import '../../components/zoom_drawer/menu_screen.dart';
import '../../configs/themes/app_colors.dart';
import '../../controllers/overall_result_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import './components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  static String routeName = '/change_password';
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
            menuItem: MenuItem.changePassword, overallResult: ()=>orController.getTotalPoint().toString(),
          ),
          mainScreen: Body(
            toggleDrawer: () => myZoomDrawerController.toggleDrawer(zoomDCtrl),
          ),
        ),
      ),
    );
  }
}
