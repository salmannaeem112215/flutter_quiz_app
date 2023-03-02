// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_ref/references.dart';
import '../models/quiz_rule.dart';


class QuizRulesController extends GetxController{
  final allQuizRules = <QuizRuleModel>[].obs;

  @override
  void onReady(){
    getAllQuizRules();
    super.onReady();
  }

  Future<void> getAllQuizRules() async{
   try {
      //query snapshot is the obj of cloud firestore
      QuerySnapshot<Map<String, dynamic>> data =
          await quizRulesRF.get(); //.get to get the data from the firebase
      
      final allRules = data.docs.map((rule) {
        return QuizRuleModel.fromSnapshot(rule);
      }).toList();
      
      allQuizRules.assignAll(allRules);
    } catch (e) {
      // ignore: avoid_print
      print('debug: Throw Catch Quiz Rules Controller \n$e');
    }
  }
}