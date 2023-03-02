// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../components/zoom_drawer/zoom_drawer_open_button.dart';
import '../../../configs/themes/app_colors.dart';
import '../../../configs/themes/custom_text_styles.dart';
import '../../../configs/themes/UI_parameters.dart';
import '../../../controllers/question_paper/app_icons.dart';
import '../../../controllers/question_paper_controller.dart';
import '../../../widgets/content_area.dart';
import '../../overall_result/overall_result_screen.dart';
import '../../quiz_rules/quiz_rules.dart';
import './question_card.dart';

class Body extends StatelessWidget {
  const Body({super.key, this.toggleDrawer});
  final Function()? toggleDrawer;
  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    final padding = UIParameters.mobileScreenPadding;
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZoomDrawerOpenButton(onTap: toggleDrawer, title: 'Home'),

            // Top Bar
            Padding(
              padding: EdgeInsets.only(
                  left: padding.left,
                  right: padding.right,
                  bottom: padding.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          AppIcons.peace,
                        ),
                        Text(
                          "HEllo Friend",
                          style: detailText.copyWith(
                            color: onSurfaceTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "What do you want to learn today?",
                    style: headerText,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getButton('Rules', Icons.rule_outlined, () => Get.toNamed(QuizRules.routeName),100),
                  const Spacer(),
                  getButton('Overall Attempt', Icons.school_rounded, () => Get.toNamed(OverallResultScreen.routeName),180),
                  // Overall Attempt Button
                ],
              ),
            ),
            // Quizes
            Expanded(
              child: ContentArea(
                addPadding: false,
                child: Obx(
                  () => ListView.separated(
                      padding: UIParameters.mobileScreenPadding,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => QuestionCard(
                            model: questionPaperController.allPapers[index],
                          ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: questionPaperController.allPapers.length),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget getButton(String text, IconData iconData,Function() onTap,double width){
    return Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(gradient: mainGradient()),
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(iconData),
                          const SizedBox(width: 5),
                          Text(
                            text,
                            style: appBarTS,
                          ),
                        ],
                      ),
                    ),
                  );
  }


}
