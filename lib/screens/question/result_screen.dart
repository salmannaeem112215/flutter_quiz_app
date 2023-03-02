// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:study_app/controllers/overall_result_controller.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../../components/zoom_drawer/custom_zoom_drawer.dart';
import '../../components/zoom_drawer/menu_item.dart';
import '../../components/zoom_drawer/menu_screen.dart';
import '../../components/zoom_drawer/zoom_drawer_open_button.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';
import '../../configs/themes/app_colors.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/question_paper/questions_controller.dart';
import '../../widgets/questions/question_number_card.dart';
import './answer_check_screen.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({super.key});
  static const String routeName = '/resultscreen';
  @override
  Widget build(BuildContext context) {
    ZoomDrawerController zoomDCtrl = ZoomDrawerController();
    MyZoomDrawerController myZoomDrawerController = Get.find();
    OverallResultController orController = Get.find();
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomZoomDrawer(
            zoomDrawerController: zoomDCtrl,
            menuScreen: MenuScreen(
              ctx: context,
              zoomDrawerController: zoomDCtrl,
              menuItem: MenuItem.empty, overallResult: ()=>orController.getTotalPoint().toString(),
            ),
            mainScreen: ResultBody(
              toggleDrawer: () =>
                  myZoomDrawerController.toggleDrawer(zoomDCtrl),
            ),
          )),
    );
  }
}

class ResultBody extends StatelessWidget {
  const ResultBody({
    super.key,
    this.toggleDrawer,
  });
  final Function()? toggleDrawer;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    QuestionsController controller = Get.find();
    Color textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    final AuthController authController = Get.find();
    final OverallResultController orController = Get.find();
    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: BackgroundDecoration(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZoomDrawerOpenButton(onTap: toggleDrawer, title: 'Result'),
            const SizedBox(height: 10),
            // controller.correctAnsweredQuestions
            SingleChildScrollView(
              child: SizedBox(
                height: size.height - 80 - 120,
                child: ContentArea(
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SvgPicture.asset('assets/images/bulb.svg'),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 25),
                        child: Text(
                          'Congratulations',
                          style: headerText.copyWith(color: textColor),
                        ),
                      ),
                      Text(
                        'You acheive ${controller.points} points',
                        style: TextStyle(color: textColor),
                      ),
                      Obx(
                        () => Text(
                          'Total Points you have ${orController.getTotalPoint()} points ',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Well Done ${authController.getRegisteredName()}, you have finished the "${controller.questionPaperModel.title}",in Quiz Area "${controller.questionPaperModel.quizArea}" with ${controller.noCorrect} correct and ${controller.noWrong} incorrect answers or ${controller.points} points for this attempt.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Tap below the question number to  view the correct answers',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        // width: double.infinity,
                        child: GridView.builder(
                            itemCount: controller.allQuestions.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: Get.width ~/ 60,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemBuilder: (_, index) {
                              final question = controller.allQuestions[index];
                              AnswerStatus status = AnswerStatus.notasnswered;
                              final selectedAnswer = question.selectedAnswer;
                              final correctAnswer = question.correctAnswer;
                              if (selectedAnswer == correctAnswer) {
                                status = AnswerStatus.correct;
                              } else if (selectedAnswer == null) {
                                status = AnswerStatus.wrong;
                              } else {
                                status = AnswerStatus.wrong;
                              }
                              return QuestionNumberCard(
                                index: index + 1,
                                status: status,
                                onTap: () {
                                  controller.jumpToQuestion(index,
                                      isGoBack: false);
                                  Get.toNamed(AnswerCheckScreen.routeName);
                                },
                              );
                            }),
                      ),
                    ]),
                  ),
                ),
              ),
            ),

            // Bottom Navbar
            ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(children: [
                    Expanded(
                        child: MainButton(
                      onTap: () => controller.tryAgain(),
                      color: Colors.blueGrey,
                      title: "Try Again",
                    )),
                    const SizedBox(width: 5),
                    Expanded(
                        child: MainButton(
                      onTap: () {
                        controller.navigateToHome();
                      },
                      // color: Get.isDarkMode?:,
                      title: "Go Home ",
                    ))
                  ]),
                ))
          ],
        )),
      ),
    );
  }
}
