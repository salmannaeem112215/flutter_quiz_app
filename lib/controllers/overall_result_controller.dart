// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:study_app/controllers/auth_controller.dart';

import '../firebase_ref/references.dart';
import '../models/result_model.dart';

enum SortBy{
  date,
  quizArea,
}

class OverallResultController extends GetxController{
  final sortBy  = SortBy.date.obs; 

  final results = <Result>[

  ].obs;

  @override
   void onReady() {
    getAllResults();
    super.onReady();
  }


  Future<void> getAllResults() async {
    AuthController authController = Get.find();
    try{
    String? userEmail = "";
      // getting data from the server
    
      userEmail=authController.getUser()!.email;
      final QuerySnapshot<Map<String, dynamic>> resultQuerry =
          await userRf
              .doc(userEmail)
              .collection("attempts")
              .get();

      // Converting question into Question list
      final firestoreResults = resultQuerry.docs
          .map((snapshot) => Result.fromSnapshot(snapshot))
          .toList();
      // assigning question one by one
      results.assignAll(firestoreResults);
    } catch (e) {
      if (kDebugMode) {
        print('load error catch');
        print(e.toString());
      }
    }
  }



  List<Result> getResultByDate(){
    return List.of(results)
      ..sort((r1, r2) => r2.attemptTime.compareTo(r1.attemptTime));
  }
  
  List<List<Result>> getResultByquizArea(){
    List<Result> numeracy = <Result>[];
    List<Result> history = <Result>[];

    for (var result in results) {
        result.quizArea==Result.kQUIZAREA[0]?
        numeracy.add(result):
        history.add(result);
     }

    return [numeracy,history];
  }

    int getTotalPoint(){
    int totalPoints=0;
    for (var result in results) {totalPoints+=result.points; }
    return totalPoints;
  }

  void removeFromLast(){
    results.removeLast();
  }                                              

}