// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../../../components/zoom_drawer/custom_zoom_drawer.dart';
import '../../../components/zoom_drawer/menu_item.dart';
import '../../../configs/themes/app_colors.dart';
import '../../../controllers/overall_result_controller.dart';
import '../../../controllers/zoom_drawer_controller.dart';
import '../../../components/zoom_drawer/menu_screen.dart';
import './body.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ZoomDrawerController zoomDCtrl = ZoomDrawerController();
    MyZoomDrawerController myZoomDrawerController = Get.find();
    OverallResultController orController = Get.find();
    orController.getAllResults();
    
    return Container(
          decoration: BoxDecoration(gradient: mainGradient()),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: 
            CustomZoomDrawer(
              zoomDrawerController: zoomDCtrl,
              menuScreen: MenuScreen(zoomDrawerController: zoomDCtrl, menuItem: MenuItem.home,ctx: context, overallResult: ()=>orController.getTotalPoint().toString(),),
              mainScreen: Body(
                    toggleDrawer: ()=>myZoomDrawerController.toggleDrawer(zoomDCtrl),
                  ),
            )
          ),
        );
  }
}