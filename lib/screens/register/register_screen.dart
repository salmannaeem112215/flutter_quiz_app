import 'package:flutter/material.dart';

import '../../configs/themes/app_colors.dart';
import './components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static String routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Register'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: const Body(),
      ),
    );
  }
}
