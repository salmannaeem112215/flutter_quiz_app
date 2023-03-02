// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../configs/themes//ui_parameters.dart';
import '../../../controllers/question_paper_controller.dart';
import '../../../configs/themes/custom_text_styles.dart';
import '../../../controllers/question_paper/app_icons.dart';
import '../../../models/question_paper_model.dart';
import '../../../widgets/app_icon_text.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.model});

  final QuestionPaperModel model;
  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;

    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: InkWell(
        onTap: () {
          controller.navigateToQuestions(paper: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconImage(context),
                  const SizedBox(width: 10),
                  questionDetails(context),
                ],
              ),
              // Trpophy Icon
              trpohyIcon(padding, context),
            ],
          ),
        ),
      ),
    );
  }

  Expanded questionDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            model.title,
            style: cardTitle(context),
          ),
          // Quiz Area
          Text(
            'Quiz Area: ${model.quizArea}',
            style: quizArea(context),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: Text(model.description),
          ),
          // Questions and Mins
          Row(
            children: [
              AppIconText(
                icon: Icon(
                  Icons.help_outline_sharp,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                text: Text(
                  '${model.questionCount} questions',
                  style: detailText.copyWith(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              AppIconText(
                icon: Icon(
                  Icons.timer,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                text: Text(
                  model.timeInMin(),
                  style: detailText.copyWith(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ClipRRect iconImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        child: SizedBox(
          height: Get.width * 0.15,
          width: Get.width * 0.15,
          child: CachedNetworkImage(
            imageUrl: model.imageUrl!,
            placeholder: ((context, url) => Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )),
            errorWidget: (context, url, error) =>
                Image.asset("assets/images/app_splash_logo.png"),
          ),
          // FadeInImage(
          //   image: NetworkImage(
          //     _questionPaperController.allPaperImages[index],
          //   ),
          //   placeholder:
          //       const AssetImage('assets/images/app_aplash_logo.png'),
          // ),
        ),
      ),
    );
  }

  Positioned trpohyIcon(double padding, BuildContext context) {
    return Positioned(
      bottom: -padding,
      right: -padding,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cardBorderRadius),
                bottomRight: Radius.circular(cardBorderRadius)),
            color: Theme.of(context).primaryColor,
          ),
          child: const Icon(
            AppIcons.trophyOutline,
          ),
        ),
      ),
    );
  }
}
