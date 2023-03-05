import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/common/extensions/string_extension.dart';
import '../common/utils.dart';
import '../models/skill/skill_dto.dart';

class SkillsProvider with ChangeNotifier {
  List<SkillDTO> skills = [];

  final String savedSkillsKey = 'SSK';

  Future<bool> loadSkillsFromLocal() async {
    var prefs = await SharedPreferences.getInstance();

    var skillsJson = prefs.getStringList(savedSkillsKey);
    if (skillsJson == null) {
      return false;
    } else {
      skills = skillsJson.map((e) => SkillDTO.fromJson(e.toMap())).toList();
      notifyListeners();
      return true;
    }
  }

  Future setSkills(List<SkillDTO> ss) async{
    skills = ss;
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();

    var jsonList = ss.map((e) => e.toJson().toRawJson()).toList();
    await prefs.setStringList(savedSkillsKey, jsonList);
  }
}
