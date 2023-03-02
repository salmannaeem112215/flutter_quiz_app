import 'package:cloud_firestore/cloud_firestore.dart';

import '../functions/time_funcs.dart';

class Result {
  static List<String> kQUIZAREA = ['Numeracy', 'History'];
  String quizId;
  String quizTitle;
  String quizArea;
  DateTime attemptTime;
  int points;

  Result({
    required this.quizId,
    required this.quizTitle,
    required this.quizArea,
    required this.points,
    required this.attemptTime,
  });


  Result.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json):
   quizId = json.id,
   quizTitle = json['quiz_title'] as String,
   quizArea = json['quiz_area'] as String,
   attemptTime=TimeFuncs.stringToDateTime(json['attempt_time'] as String),
   points = json['points'] as int;

}
