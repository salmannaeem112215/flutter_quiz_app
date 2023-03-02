// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/question_paper/questions_controller.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/custom_appbar.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';
import '../../configs/themes/app_colors.dart';
import '../../widgets/questions/countdown_timer.dart';
import '../../widgets/questions/question_number_card.dart';


class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});
  static const String routeName = '/testoverview';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(title: controller.completedTest),
        body: BackgroundDecoration(
            child: Center(
                child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                            color: UIParameters.isDarkMode()
                                ? Theme.of(context).textTheme.bodyLarge!.color
                                : Theme.of(context).primaryColor,
                            time: ''),
                        Obx(() => Text(
                              '${controller.time} Remaining',
                              style: countDownTimerTs(),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                          itemCount: controller.allQuestions.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.width ~/ 75,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                          itemBuilder: (_, index) {
                            AnswerStatus? answerStatus;
                            if (controller.allQuestions[index].selectedAnswer !=
                                null) {
                              answerStatus = AnswerStatus.answered;
                            }
                            return QuestionNumberCard(
                              index: index+1,
                              status: answerStatus,
                              onTap: () => controller.jumpToQuestion(index),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: MainButton(
                  onTap: () {
                    controller.complete();
                  },
                  title: 'Complete',
                ),
              ),
            )
          ],
        ))),
      ),
    );
  }
}
