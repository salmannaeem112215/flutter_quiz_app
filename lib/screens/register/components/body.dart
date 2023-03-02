// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../configs/themes/custom_text_styles.dart';
import '../../../components/build_logo.dart';
import '../../../components/text_with_link.dart';
import 'register_form.dart';

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
                  "Let's Create an account for you!",
                  style: headerText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                RegisterForm(ctx: context),
                const SizedBox(height: 50),
                TextWithLink(
                  text: 'Already have an account!',
                  linkText: 'Login',
                  press: () => Get.back(),
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
