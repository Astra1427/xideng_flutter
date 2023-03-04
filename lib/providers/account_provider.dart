import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/common/extensions/string_extension.dart';
import 'package:xideng_flutter/models/account/account_dto.dart';

class AccountProvider with ChangeNotifier{
  AccountDTO? currentUser ;


  void setCurrentUser(AccountDTO? newUser){
    currentUser = newUser;
    saveCurrentUserInfo();
    notifyListeners();
  }
  final String savedUserKey = 'SUK';

  Future<bool> saveCurrentUserInfo()async{
    var prefs = await SharedPreferences.getInstance();
    if(currentUser == null) return false;
    var result = await prefs.setString(savedUserKey, currentUser!.toJson().toRawJson());
    return result;
  }

  loadSavedUserInfo()async{
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(savedUserKey);

    if(result == null){
      setCurrentUser(null);
    }else{
      setCurrentUser(AccountDTO.fromJson(result.toMap()));
    }
  }

  localToCloud(){

  }

  cloudToLocal(){

  }

}