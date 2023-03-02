// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../components/deafault_button.dart';
import '../../../components/my_text_field.dart';
import '../../../controllers/auth_controller.dart';
import '../../../functions/validator.dart' as v;

class LoginForm extends StatelessWidget {
  LoginForm({super.key, required this.ctx});
  final BuildContext ctx;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   final  AuthController authController = Get.find();
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
          const SizedBox(height: 10),
          // // Forget Password
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       const Spacer(),
          //       GestureDetector(
          //         onTap: () {},
          //         child: const Text(
          //           'Forget Password?',
          //           style: linkTextButtonStyle,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Login in Button
          SizedBox(
            width: 200,
            child: DefaultButton(
              text: 'Login In',
              press: () => authController.loginUserIn(
                ctx: ctx,
                emailTextController: emailTextController,
                passwordTextController: passwordTextController,
                formKey: formKey,
              ),
            ),
          ),

          
        ],
      ),
    );
  }
}
