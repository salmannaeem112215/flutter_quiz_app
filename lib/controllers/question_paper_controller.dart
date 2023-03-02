// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_ref/references.dart';
import '../models/question_paper_model.dart';
import '../screens/question/question_start_screen.dart';
import '../services/firebase_storage_services.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs; //obs for reactive
  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["biology", "physics", "maths", "chemistry"];
    try {
      //query snapshot is the obj of cloud firestore
      QuerySnapshot<Map<String, dynamic>> data =
          await questionPaperRF.get(); //.get to get the data from the firebase

      final allPaperList = data.docs.map((paper) {
        return QuestionPaperModel.fromSnapshot(paper);
      }).toList();
      allPapers.assignAll(allPaperList);

      for (var paper in imgName) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper);
        paper = imgUrl!;
      }
      // no duplication it will replace any changes
      allPapers.assignAll(allPaperList);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {

        Get.toNamed(QuestionStartScreen.routeName,
            arguments: paper, preventDuplicates: false);
    
  }

}
