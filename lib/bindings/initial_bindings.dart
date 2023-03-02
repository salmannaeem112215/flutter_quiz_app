// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/zoom_drawer_controller.dart';


//implement is used when we have to use some functions only
class InitialBindings implements Bindings {
  //bindings is from getx class
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.put(MyZoomDrawerController(), permanent: true);
    
  }
}
