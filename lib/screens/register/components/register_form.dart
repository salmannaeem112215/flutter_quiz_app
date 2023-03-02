// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../controllers/auth_controller.dart';
import '../../../components/deafault_button.dart';
import '../../../components/my_text_field.dart';
import '../../../functions/validator.dart' as v;

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key, required this.ctx});

  final BuildContext ctx;
  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controler: emailTextController,
              hintText: 'Email',
              obsecureText: false,
              validator: v.Validator.email,
            ),
          ),
          const SizedBox(height: 10),

          // User Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controler: usernameTextController,
              hintText: 'Username',
              obsecureText: false,
              validator: v.Validator.firstName,
            ),
          ),
          const SizedBox(height: 10),

          // Passoword
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controler: passwordTextController,
              hintText: 'Password',
              obsecureText: true,
              validator: v.Validator.password,
            ),
          ),

          // ConfirmPassword
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controler: passwordConfirmTextController,
              hintText: 'Confirm Password',
              obsecureText: true,
              validator: (val) {
                return v.Validator.confirmPassword(
                  val,
                  passwordTextController.text,
                );
              },
            ),
          ),

          const SizedBox(height: 20),
          // Login in Button
          SizedBox(
            width: 200,
            child: DefaultButton(
              text: 'Sign Up',
              press: () => authController.signUserUp(
                ctx: ctx,
                formKey: formKey,
                emailTextController: emailTextController,
                passwordTextController: passwordTextController,
                userTextController: usernameTextController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
