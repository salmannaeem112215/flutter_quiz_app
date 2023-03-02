// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:study_app/functions/snack_bar_custom.dart';

import '../../controllers/zoom_drawer_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../configs/themes/app_colors.dart';
import './drawer_button.dart';
import './menu_item.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen(
      {super.key,
      required this.zoomDrawerController,
      required this.menuItem,
      required this.ctx,
      required this.overallResult});
  final ZoomDrawerController zoomDrawerController;
  final MenuItem menuItem;
  final BuildContext ctx;
  final String Function()? overallResult;
  @override
  Widget build(BuildContext context) {
    final MyZoomDrawerController myZoomDrawerController = Get.find();
    final AuthController authController = Get.find();
    return Container(
      padding: const EdgeInsets.only(left: 20),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          // gradient: mainGradient(),
          color: Colors.transparent),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style:
                    TextButton.styleFrom(foregroundColor: onSurfaceTextColor))),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    controller.toggleDrawer(zoomDrawerController);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username 1
                    const SizedBox(height: 25),
                    // ignore: prefer_const_constructors
                    Text(
                      '${authController.getRegisteredName()}',
                      // 'Change ',
                      // 'Change me',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: onSurfaceTextColor),
                    ),

                    const Spacer(
                      flex: 1,
                    ),
                    DrawerButton(
                      icon: Icons.home_rounded,
                      label: "Home",
                      onPressed: () {
                        myZoomDrawerController.goHome(menuItem);
                      },
                      isSelected: menuItem == MenuItem.home,
                    ),
                    DrawerButton(
                      icon: Icons.rule,
                      label: "Quiz Rule",
                      onPressed: () => controller.goQuizRules(
                        menuItem: menuItem,
                        zoomDrawerController: zoomDrawerController,
                      ),
                      isSelected: menuItem == MenuItem.quizArea,
                    ),
                    DrawerButton(
                      icon: Icons.school_rounded,
                      label: "Overall Points",
                      onPressed: () => controller.goOverallPoint(
                        menuItem: menuItem,
                        zoomDrawerController: zoomDrawerController,
                      ),
                      isSelected: menuItem == MenuItem.overallPoint,
                    ),
                    DrawerButton(
                      icon: Icons.drive_file_rename_outline_rounded,
                      label: "Change Password",
                      onPressed: () => myZoomDrawerController.goChangePassword(
                        menuItem: menuItem,
                        zoomDrawerController: zoomDrawerController,
                      ),
                      isSelected: menuItem == MenuItem.changePassword,
                    ),
                    const Divider(height: 0),

                    const Spacer(flex: 4),
                    DrawerButton(
                      icon: Icons.logout,
                      label: "log out",
                      onPressed: () async {
                        SnackBarCutom(
                          ctx: ctx,
                          text: 'Your Overall Points is ${overallResult!()}',
                        );
    await Future.delayed(const Duration(seconds: 3));

                        myZoomDrawerController.signOut();
                      },
                      isSelected: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
