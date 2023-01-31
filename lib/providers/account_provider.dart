import 'package:flutter/material.dart';
import 'package:xideng_flutter/models/account/account_dto.dart';

class AccountProvider with ChangeNotifier{
  AccountDTO? currentUser ;


  void setCurrentUser(AccountDTO? newUser){
    currentUser = newUser;
    notifyListeners();
  }

}