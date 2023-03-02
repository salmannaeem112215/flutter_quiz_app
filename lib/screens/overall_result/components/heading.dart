// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:study_app/controllers/auth_controller.dart';

import '../../../controllers/overall_result_controller.dart';

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    final OverallResultController orController = Get.find();
    final AuthController authController = Get.find();
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Hi ${authController.getRegisteredName()}, you haved earned " ${orController.getTotalPoint()} " points in the following attempts :',
            style: const TextStyle(fontSize: 18),
          ),
        ));
  }
}
