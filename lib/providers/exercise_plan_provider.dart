import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/common/extensions/string_extension.dart';
import 'package:xideng_flutter/models/exercise_plan/exercise_plan_dto.dart';

class ExercisePlanProvider with ChangeNotifier{
  List<ExercisePlanDTO> exercisePlans = [];
  final savedExercisePlansKey = 'savedExercisePlansKey';
  Future setExercisePlans(List<ExercisePlanDTO> model)async{


    exercisePlans = model;
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList(savedExercisePlansKey, model.map((e) => e.toJson().toRawJson()).toList());
  }

  Future loadExercisePlans()async{
    var prefs = await SharedPreferences.getInstance();

    var json = prefs.getStringList(savedExercisePlansKey);
    if(json == null) {
      return;
    }
    exercisePlans = json.map((e) => ExercisePlanDTO.fromJson(e.toMap())).toList();
    notifyListeners();
  }

}