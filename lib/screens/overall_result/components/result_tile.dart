import 'package:flutter/material.dart';

import '../../../models/result_model.dart';
import '../../../configs/themes/UI_parameters.dart';
import '../../../functions/time_funcs.dart';
import './point_tile.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({super.key, required this.result});
  final Result result;
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
          title: Text(result.quizArea),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(result.quizTitle),

              Text(TimeFuncs.dateTimeToString(result.attemptTime)),
            ],
          ),
          trailing: PointTile(points: result.points),
        ),
      ),
    );
  }
}
