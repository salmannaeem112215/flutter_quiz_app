// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import './question_screen.dart';

import '../../models/question_paper_model.dart';

class QuestionStartScreen extends StatelessWidget {
  const QuestionStartScreen({super.key});
  static String routeName = '/qss';
  @override
  Widget build(BuildContext context) {
    final QuestionPaperModel paper = Get.arguments as QuestionPaperModel;  
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed:()=> Get.toNamed(QuestionScreen.routeName,
            arguments: paper, preventDuplicates: false), child: const Text('Start Quiz')),
      ),
    );
  }
}