import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/common/extensions/string_extension.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/models/app_config.dart';

class AppConfigProvider with ChangeNotifier {
  final String firstStartKey = 'firstStartKey';

  final String appConfigModelKey = 'appConfigModelKey';

  AppConfigModel? appConfigModel;

  Future<bool> isFirstStart() async {
    var prefs = await SharedPreferences.getInstance();

    return !prefs.containsKey(firstStartKey);
  }

  Future setFirstStart() async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString(firstStartKey, "1");
  }

  Future setAppConfigModel(AppConfigModel? model) async {
    if(model == null){
      return ;
    }
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(appConfigModelKey, model.toJson().toRawJson());
  }

  Future loadAppConfigModel() async {
    var prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(appConfigModelKey);
    if (json == null) {
      return;
    }
    appConfigModel = AppConfigModel.fromJson(json.toMap());
    notifyListeners();
  }

}
