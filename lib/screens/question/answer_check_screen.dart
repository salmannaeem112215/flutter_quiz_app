// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../configs/themes/custom_text_styles.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/custom_appbar.dart';
import '../../widgets/questions/answer_card.dart';
import '../../components/my_text_field.dart';
import '../../configs/themes/app_colors.dart';
import '../../controllers/question_paper/questions_controller.dart';
import '../../widgets/content_area.dart';
import './result_screen.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});
  static const String routeName = '/answercheckscreen';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          titleWidget: Obx(() => Text(
                'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: appBarTS,
              )),
          showActionIcon: true,
          onMenuActionTap: () {
            Get.toNamed(ResultScreen.routeName);
          },
        ),
        body: BackgroundDecoration(
          child: Obx(() => Column(
                children: [
                  Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(children: [
                          // Question
                          Text(controller.currentQuestion.value!.question),

                          // Answer
                          (controller.currentQuestion.value!.isMcq)
                              ? mcqsAnswer()
                              : textfieldAnswer()
                        ]),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget textfieldAnswer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Customer Answered
        const SizedBox(height: 20),
        const Text(
          'Correct Answer',
          style: questionText,
        ),
        const SizedBox(height: 5),
        MyTextField(
          hintText: controller.currentQuestion.value!.correctAnswer!,
          controler: null,
          validator: (val) {return null;},
          obsecureText: false,
          enabled: false,
        ),

        // User Answered
        const SizedBox(height: 20),
        const Text(
          'Your Answer',
          style: questionText,
        ),
        const SizedBox(height: 5),
        MyTextField(
          hintText: '${controller.currentQuestion.value!.selectedAnswer}',
          controler: null,
          validator: (val) {return null;},
          obsecureText: false,
          enabled: false,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget mcqsAnswer() {
    return GetBuilder<QuestionsController>(
        id: 'answer_review_list', // id is used so that the controller will not rebuild at many places
        builder: (_) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final answer = controller.currentQuestion.value!.answers[index];
                final selectedAns =
                    controller.currentQuestion.value!.selectedAnswer;
                final correctAns =
                    controller.currentQuestion.value!.correctAnswer;
                final String answerText =
                    '${answer.identifier}. ${answer.answer}';

                if (correctAns == selectedAns &&
                    answer.identifier == selectedAns) {
                  //correct ans
                  return CorrectAns(
                    ans: answerText,
                  );
                } else if (selectedAns == null) {
                  //not selected ans
                  return NotAnswered(
                    ans: answerText,
                  );
                } else if (selectedAns != correctAns &&
                    answer.identifier == selectedAns) {
                  //wrong ans
                  return WrongAns(
                    ans: answerText,
                  );
                } else if (correctAns == answer.identifier) {
                  //correct ans
                  return CorrectAns(
                    ans: answerText,
                  );
                }

                return AnswerCard(
                  answer: answerText,
                  ontap: () {},
                  isSelected: false,
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(height: 10);
              },
              itemCount: controller.currentQuestion.value!.answers.length);
        });
  }
}
