// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../components/deafault_button.dart';
import '../../../components/my_text_field.dart';
import '../../../components/zoom_drawer/zoom_drawer_open_button.dart';
import '../../../configs/themes/app_colors.dart';
import '../../../controllers/auth_controller.dart';
import '../../../functions/validator.dart' as v;

class Body extends StatelessWidget {
  Body({super.key, this.toggleDrawer});
  final Function()? toggleDrawer;
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ZoomDrawerOpenButton(onTap: toggleDrawer,title: 'Change Password',),
            const Spacer(),
            Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // New Password
                      MyTextField(
                        controler: _newPasswordController,
                        hintText: 'New Password',
                        obsecureText: false,
                        validator: v.Validator.password,
                      ),
                      const SizedBox(height: 20),

                      // Confirm New Passowrd
                      MyTextField(
                        controler: _confirmNewPasswordController,
                        hintText: 'Confirm New  Password',
                        obsecureText: false,
                        validator: (val) {
                          return v.Validator.confirmPassword(
                            val,
                            _newPasswordController.text,
                          );
                        },
                      ),
                      const SizedBox(height: 50),

                      // Change User Password
                      // Login in Button
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DefaultButton(
                            text: 'Change Password',
                            press: () => authController.changePassword(
                                ctx: context,
                                formKey: _formKey,
                                newPassword: _newPasswordController.text),
                          )),

                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
