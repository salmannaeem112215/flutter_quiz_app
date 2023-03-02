import 'package:cloud_firestore/cloud_firestore.dart';

class QuizRuleModel {
  String id;
  String text;

  QuizRuleModel({required this.id, required this.text});

  QuizRuleModel.fromJson(Map<String, dynamic> json):id = json['id'],text = json['text'];
  QuizRuleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      :id = json.id , text = json['text'] ;   // mo
}
