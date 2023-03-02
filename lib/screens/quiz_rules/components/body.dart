// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../configs/themes/app_colors.dart';
import '../../../controllers/rules_controller.dart';
import '../../../components/zoom_drawer/zoom_drawer_open_button.dart';
import '../../../configs/themes/UI_parameters.dart';
import '../../../widgets/content_area.dart';
import './quiz_rule_tile.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.toggleDrawer});
  final Function() toggleDrawer;
  @override
  Widget build(BuildContext context) {
    QuizRulesController quizRuleController = Get.find();
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: SafeArea(
        child: Column(
          children: [
            ZoomDrawerOpenButton(onTap: toggleDrawer,title: 'Quiz Rules'),
    
            // Heading
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Text('You must follow',
                  style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            ),
    
            // List Tiles
            Expanded(
              child: ContentArea(
                addPadding: false,
                child: Obx(
                  () => ListView.separated(
                      padding: UIParameters.mobileScreenPadding,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => QuizRuleTile(
                          quizRule: quizRuleController.allQuizRules[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: quizRuleController.allQuizRules.length),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
