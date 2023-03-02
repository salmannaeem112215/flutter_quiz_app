// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../login/login_screen.dart';
import './components/home_page.dart';

class HomeScreen extends GetView<AuthController> {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return Obx(
      () => authController.isLoggedIn.value
          ? const HomePage()
          : const LoginScreen(),
    );
  }
}
