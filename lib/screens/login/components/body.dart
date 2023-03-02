// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../configs/themes/custom_text_styles.dart';
import '../../../components/build_logo.dart';
import '../../../components/text_with_link.dart';
import '../../register/register_screen.dart';
import './login_form.dart';


class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                const BuildLogo(),
                const SizedBox(height: 20),
                const Text(
                  "Welcome back you've been missed!",
                  style: headerText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                LoginForm(ctx: context),
                const SizedBox(height: 50),
                TextWithLink(
                  text: 'Don\'t have an account!',
                  linkText: 'Sign up',
                  press: ()=> Get.toNamed(RegisterScreen.routeName),
                ),
                const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
  }
}