// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/app_circle_button.dart';
import '../../configs/themes/app_colors.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});
  static String routeName = '/intro';

  @override
  Widget build(BuildContext context) {
  AuthController authController = Get.find();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.star,
              size: 65,
            ),
            const SizedBox(height: 40),
            const Text(
              "This is a study app if you want to use it t can be benifial for you in case you want to be very qualifying student who can top in the subject ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            AppCircularButton(
              child: const Icon(
                Icons.arrow_forward,
                size: 35,
              ),
              onTap: () {
                authController.navigateToHome();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
