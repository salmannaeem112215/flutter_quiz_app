// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../firebase_ref/references.dart';
import '../../models/question_paper_model.dart';
import '../../models/quiz_rule.dart';
import '../../firebase_ref/loading_status.dart';

// controller will be called only once
class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs; // now it is observable

  void uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0

    final fireStore = FirebaseFirestore.instance;
    
    await uploadPapersData(fireStore);
    await uploadQuizData(fireStore);
    
    loadingStatus.value = LoadingStatus.completed; //1
  }

  Future<void> uploadPapersData(FirebaseFirestore fs)async{
    List<QuestionPaperModel> questionPapers = []; //list of json files

    //assets will be loaded in the manifestcontent
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");

    // it is reading all content in assets
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    //now it will read address of req files only
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains('.json'))
        .toList(); //list of file names

    // get the data of the req files
    for (var paper in papersInAssets) {
      String paperContent = await rootBundle.loadString(paper);
      final decode = json.decode(paperContent);
      final questionPaperModel = QuestionPaperModel.fromJson(decode);
      questionPapers.add(questionPaperModel);
    }
    
    // Firebase Commands
    final batch = fs.batch();
   
    // Storing Data In Firestore
    for (var paper in questionPapers) {
      // created document
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "quiz_area": paper.quizArea,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count":
            paper.questions == null ? 0 : paper.questions!.length,
      }); //.doc for object

      // inside each document creating document for question
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          "is_mcq":questions.isMcq,
          "question": questions.question,
          "format":questions.format,
          "correct_answer": questions.correctAnswer
        });

      // inside each question creating document for answer
        for (var answers in questions.answers) {
          batch
              .set(questionPath.collection('answers').doc(answers.identifier), {
            "identifier": answers.identifier,
            "answer": answers.answer,
          });
        }
      }
    }
    
    // Uploading  Papers End
    await batch.commit(); // commiting in the database
  }
  Future<void> uploadQuizData(FirebaseFirestore fs)async{
    // Upload Quiz Rules Start
    List<QuizRuleModel> quizRules = []; //list of json files

    const quizRuleInAssets ="assets/DB/rules/quiz_rules.json";//list of file names
      String ruleContent = await rootBundle.loadString(quizRuleInAssets);
      final decode = json.decode(ruleContent);
      for(var quizRule in decode){
        var qr =
        QuizRuleModel.fromJson(quizRule as Map<String, dynamic>);
        quizRules.add(qr);
      }

    final batch = fs.batch();

    // Storing Data in Firebase
    for (var rule in quizRules) {
      batch.set(quizRulesRF.doc(rule.id), {
        "text": rule.text,
      }); //.doc for object
    }
    // Uploading Quiz Completed
    await batch.commit(); // commiting in the database
  }

}
