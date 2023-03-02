// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../configs/themes/ui_parameters.dart';
import '../../configs/themes/app_colors.dart';
import './answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard(
      {super.key,
      required this.index,
      required this.status,
      required this.onTap});
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;

    switch (status) {
      case AnswerStatus.answered:
        Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        wrongAnswerColor;
        break;
      case AnswerStatus.notasnswered:
        Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: UIParameters.cardBorderRadius),
          child: Center(
            child: Text(
              '$index',
              style: TextStyle(
                  color: status == AnswerStatus.notasnswered
                      ? Theme.of(context).primaryColor
                      : null),
            ),
          )),
    );
  }
}
