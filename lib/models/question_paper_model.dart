import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String quizArea;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionPaperModel({
    required this.id,
    required this.title,
    required this.quizArea,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questionCount,
    this.questions,
  });

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        quizArea = json['quiz_area'] as String,
        imageUrl = json['image_url'] as String,
        description = json['description'] as String,
        timeSeconds = json['time_seconds'] as int,
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  // QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
  //     : id = json.id,
  //       title = json['title'],
  //       imageUrl = json['image_url'],
  //       description = json['description'],
  //       timeSeconds = json['time_seconds'] as int,
  //       questionCount = json['question_count'] as int,
  //       questions = [];

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        quizArea = json['quiz_area'],
        imageUrl = json['image_url'],
        description = json['description'],
        timeSeconds = json['time_seconds'] as int,
        questionCount = json['questions_count'] as int,
        questions = []; // mo

  String timeInMin() => "${(timeSeconds / 60).ceil()} mins";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['quiz_area']=quizArea;
    data['image_url'] = imageUrl;
    data['description'] = description;
    data['time_seconds'] = timeSeconds;

    return data;
  }
}

class Questions {
  String id;
  String question;
  bool isMcq;
  List<Answers> answers;
  String format;
  String? correctAnswer;
  String? selectedAnswer;

  Questions(
      {required this.id,
      required this.question,
      required this.isMcq,
      required this.answers,
      required this.format,
      this.correctAnswer,});

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        isMcq = json['is_mcq'],
        answers =
            (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        format=json['format'],
        correctAnswer = json['correct_answer'];
  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot["question"],
        isMcq=snapshot["is_mcq"],
        answers = [],
        format = snapshot["format"],
        correctAnswer = snapshot["correct_answer"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['is_mcq']=isMcq;
    if (answers.isNotEmpty) {
      data['answers'] = answers.map((v) => v.toJson()).toList();
    }
    data['format']=format;
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['Answer'];
  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
}
