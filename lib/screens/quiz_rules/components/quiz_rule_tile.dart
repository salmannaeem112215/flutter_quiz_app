import 'package:flutter/material.dart';

import '../../../configs/themes/UI_parameters.dart';
import '../../../models/quiz_rule.dart';

class QuizRuleTile extends StatelessWidget {
  const QuizRuleTile({super.key, required this.quizRule});
  final QuizRuleModel quizRule;
  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;
    return Container(
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: Theme.of(context).cardColor),
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: ListTile(
            title: Text('#${quizRule.id.substring(3)}'),
            subtitle: Text(quizRule.text),
          ),
        ));
  }
}
