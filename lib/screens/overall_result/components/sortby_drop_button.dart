// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../controllers/overall_result_controller.dart';

class SortByDropButton extends StatefulWidget {
  const SortByDropButton({Key? key}) : super(key: key);

  @override
  State<SortByDropButton> createState() => _SortByDropButtonState();
}

class _SortByDropButtonState extends State<SortByDropButton> {
  String _selectedItem = 'Date'; // default selected item
  


  @override
  Widget build(BuildContext context) {
    OverallResultController overallResultController = Get.find();

    onChange(String? newValue){
      if(newValue==_selectedItem) return;
        setState(() {
          _selectedItem = newValue!;
          if(newValue=='Date'){
          overallResultController.sortBy.value = SortBy.date;
          }else{
          overallResultController.sortBy.value = SortBy.quizArea;
          }
        });
    }

    return DropdownButton<String>(
      value: _selectedItem,
      onChanged: onChange,
      items: <String>['Date', 'Quiz Area'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
