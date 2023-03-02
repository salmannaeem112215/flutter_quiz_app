// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../widgets/questions/countdown_timer.dart';
import '../../components/my_text_field.dart';
import '../../configs/themes/app_colors.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/common/question_screenholder.dart';
import '../../configs/themes/UI_parameters.dart';
import '../../widgets/content_area.dart';
import '../../controllers/question_paper/questions_controller.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/custom_appbar.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/questions/answer_card.dart';
import './test_overview_screen.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({super.key});
  static const String routeName = "/questionsscreen";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppbar(),
        body: BackgroundDecoration(
          child: Obx(
            () => Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                    child: ContentArea(child: QuestionScreenHolder()),
                  ),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: questionText,
                            ),
                            controller.currentQuestion.value!.isMcq
                                ? mcqOptions()
                                : textformOptions(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                bottomButtons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomAppBar customAppbar() {
    return CustomAppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(color: onSurfaceTextColor, width: 2),
              ),
            ),
            child: Obx(() => CountdownTimer(
                  time: controller.time.value,
                  color: onSurfaceTextColor,
                )),
          ),
          showActionIcon: true,
          titleWidget: Obx(
            () => Text(
              'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
              style: appBarTS,
            ),
          ));
  }

  ColoredBox bottomButtons(BuildContext context) {
    return ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: MainButton(
                            onTap: () {
                              controller.isLastQuestion
                                  ? Get.toNamed(TestOverviewScreen.routeName)
                                  : controller.prevQuestion();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : onSurfaceTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Visibility(
                            visible: controller.loadingStatus.value ==
                                LoadingStatus.completed,
                            child: MainButton(
                              onTap: () {
                                controller.isLastQuestion
                                    ? controller.complete()
                                    : controller.nextQuestion();
                              },
                              title: controller.isLastQuestion
                                  ? 'Complete'
                                  : 'Next',
                            )),
                      )
                    ],
                  ),
                ),
              );
  }

  Widget textformOptions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        MyTextField(
          controler: controller.answerTextController,
          hintText: controller.currentQuestion.value!.format,
          validator: (value) {return null;},
          obsecureText: false,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              width: 100,
              child: MainButton(
                onTap: () {
                  controller.selectedAnswerForTextField(context);
                },
                title: 'Submit',
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget mcqOptions() {
    return GetBuilder<QuestionsController>(
        id: 'answers_list',
        builder: (context) {
          return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 25),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final answer = controller.currentQuestion.value!.answers[index];
                return AnswerCard(
                  answer: '${answer.identifier}.${answer.answer}',
                  ontap: () {
                    controller.selectedAnswer(answer.identifier);
                  },
                  isSelected: answer.identifier ==
                      controller.currentQuestion.value!.selectedAnswer,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    height: 10,
                  ),
              itemCount: controller.currentQuestion.value!.answers.length);
        });
  }
}
