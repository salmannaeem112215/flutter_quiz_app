// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/controllers/overall_result_controller.dart';

import '../auth_controller.dart';
import '../question_paper_controller.dart';
import '../../functions/snack_bar_custom.dart';
import '../../functions/time_funcs.dart';
import '../../screens/home/home_screen.dart';
import '../../models/question_paper_model.dart';
import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';
import '../../screens/question/result_screen.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final RxInt questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  final TextEditingController answerTextController = TextEditingController();
  //Timer
  String? quizArea;

  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  
  final allQuestions = <Questions>[]; // 5 selected questions from firestore
  final firestoreQuestions = <Questions>[]; //All questions from firestore


  @override
  void onReady() {
    final questionPaper = Get.arguments as QuestionPaperModel;
    loadData(questionPaper);
    super.onReady();
  }

  

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      // getting data from the server
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();

      // Converting question into Question list
      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();
      // assigning question one by one
      questionPaper.questions = questions;

      // getting question values
      for (Questions question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();
        final answers = answersQuery.docs
            .map((answers) => Answers.fromSnapshot(answers))
            .toList();
        question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print('load error catch');
        print(e.toString());
      }
    }

    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      // questionPaper.questions -15 questions
      firestoreQuestions.assignAll(questionPaper.questions!);

      quizArea = questionPaper.title;
      // assiging 5 questions to all questions only from firestore questions
      assignQuestionsRandomly();
      // allQuestions.assignAll(questionPaper.questions!);

      currentQuestion.value = allQuestions[0];
      _startTimer(questionPaper.timeSeconds);
      if (kDebugMode) {
        print(questionPaper.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  void selectedAnswerForTextField(BuildContext ctx) {
    if (answerTextController.text == "") {
      SnackBarCutom(
          ctx: ctx,
          text: 'Answer not submit! Empty value',
          duration: const Duration(seconds: 1));
    } else {
      currentQuestion.value!.selectedAnswer = answerTextController.text;
      SnackBarCutom(
          ctx: ctx,
          text: 'Answer submit!',
          duration: const Duration(seconds: 1));
    }
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of${allQuestions.length} answered";
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
    answerTextController.text = "";
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
    answerTextController.text = "";
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          timer.cancel();
        } else {
          int minutes = remainSeconds ~/ 60;
          int seconds = remainSeconds % 60;
          time.value =
              '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
          remainSeconds--;
        }
      },
    );
  }

  void complete() {
    _timer!.cancel(); //to avoid memory leakage
    saveTestResults();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    Get.find<QuestionPaperController>().navigateToQuestions(
      paper: questionPaperModel,
      tryAgain: true,
    );
    resetQuiz();
  }

void resetQuiz() {
    //  questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    if (questionPaperModel.questions != null &&
        questionPaperModel.questions!.isNotEmpty) {
      // starting from 1st Question
      questionIndex.value = 0;
      // Assiging Question again
      assignQuestionsRandomly();
      // current Question
      currentQuestion.value = allQuestions[0];
      // Setting user question value to null
      for (var element in allQuestions) {
        element.selectedAnswer = null;
      }
      // resetting timmer
      _startTimer(questionPaperModel.timeSeconds);
      if (kDebugMode) {
        print("...startTimer...");
      }
      if (kDebugMode) {
        print(questionPaperModel.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName,
        (route) => false); //starts from beginning --> saves memory
  }

  int get correctQuestionsCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionsCount out of ${allQuestions.length} are correct';
  }

  int get noCorrect => correctQuestionsCount;

  int get noWrong => allQuestions.length - correctQuestionsCount;

  int get points => noCorrect * 5 - noWrong * 2;

  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) return;
    batch.set(
        userRf
            .doc(user.email)
            .collection('attempts')
            .doc(questionPaperModel.id),
        {
          'quiz_area': questionPaperModel.quizArea,
          'quiz_title':questionPaperModel.title,
          'attempt_time': TimeFuncs.dateTimeToString(DateTime.now()),
          'points': points,

        });
    batch.commit();
    // to update Results
    OverallResultController orController = Get.find();
    orController.getAllResults();
  }

List<int> getUniqueRandomNumbers(int maxRange, int count) {
  List<int> allIndexes = [];
  List<int> selectedIndex = [];
  for (int i = 0; i < maxRange; i++) {
    allIndexes.add(i);
  }
  //select random no
  for (int i = 0; i < count; i++) {
    var rnd = Random();
    int index = rnd.nextInt(maxRange);
    selectedIndex.add(allIndexes[index]);
    allIndexes[index] = allIndexes[maxRange - 1];
    maxRange--;
  }
  return selectedIndex;
}

  void assignQuestionsRandomly() {
    List<int> randomNumbers =
        getUniqueRandomNumbers(firestoreQuestions.length, 5);
    List<Questions> questions5 = [];
    for (int i = 0; i < 5; i++) {
      int r = randomNumbers[i];
      // print("debug: r $r");
      questions5.add(firestoreQuestions[r]);
    }
    allQuestions.clear();
    allQuestions.assignAll(questions5);
  }





}