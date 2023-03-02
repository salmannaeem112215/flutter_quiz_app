// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../configs/themes/app_colors.dart';
import '../../controllers/auth_controller.dart';
import './components/body.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Login Screen'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: const Body(),
      ),
    );
  }
}
