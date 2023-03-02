import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import './menu_screen.dart';

class CustomZoomDrawer extends StatelessWidget {
  const CustomZoomDrawer({
    super.key,
    required this.mainScreen, required this.zoomDrawerController, required this.menuScreen,
  });
  final Widget mainScreen;
  final MenuScreen menuScreen;
  final ZoomDrawerController zoomDrawerController;
  @override
  Widget build(BuildContext context) {
      return ZoomDrawer(
        borderRadius: 50.0,
        controller: zoomDrawerController,
        angle: 0,
        style: DrawerStyle.defaultStyle,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        drawerShadowsBackgroundColor: Colors.transparent,
        menuBackgroundColor: const Color.fromARGB(0, 146, 61, 61),
        shadowLayer1Color: Colors.transparent,
        shadowLayer2Color: Colors.transparent,
        mainScreenOverlayColor: Colors.transparent,
        menuScreenOverlayColor: Colors.transparent,
        // Drawer Body
        menuScreen: menuScreen,
        // Main Home Screen Body
        mainScreen: mainScreen,
      
    );
  }
}
