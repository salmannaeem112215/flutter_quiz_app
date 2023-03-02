// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../configs/themes/UI_parameters.dart';
import '../../../controllers/overall_result_controller.dart';
import '../../../models/result_model.dart';
import './result_tile.dart';

class OverallResults extends StatelessWidget {
  const OverallResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OverallResultController orController = Get.find();
    orController.getAllResults();
    return Obx(() {
      final sortBy = orController.sortBy.value == SortBy.date;
      return sortBy
          ? ViewSortByDate(resultsByDate: orController.getResultByDate())
          : ViewSortByQuizArea(
              resultsByQuizArea: orController.getResultByquizArea());
    });
  }
}

class ViewSortByDate extends StatelessWidget {
  const ViewSortByDate({
    super.key,
    required this.resultsByDate,
  });

  final List<Result> resultsByDate;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: UIParameters.mobileScreenPadding,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            ResultTile(result: resultsByDate[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: resultsByDate.length);
  }
}

class ViewSortByQuizArea extends StatelessWidget {
  const ViewSortByQuizArea({super.key, required this.resultsByQuizArea});
  final List<List<Result>> resultsByQuizArea;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Numeracy"),
              Tab(text: "History"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.separated(
                  padding: UIParameters.mobileScreenPadding,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ResultTile(result: resultsByQuizArea[0][index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: resultsByQuizArea[0].length,
                ),
                ListView.separated(
                  padding: UIParameters.mobileScreenPadding,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ResultTile(result: resultsByQuizArea[1][index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: resultsByQuizArea[1].length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
