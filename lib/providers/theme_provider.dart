import 'package:flutter/material.dart';

import '../styles/main_style.dart';

class AppThemeProvider with ChangeNotifier{
  ThemeMode currentThemeMode = ThemeMode.dark;
  // ThemeData? currentThemeData = dar
  void switchThemeModel(){
    if(currentThemeMode == ThemeMode.light){
      currentThemeMode = ThemeMode.dark;
    }else{
      currentThemeMode = ThemeMode.light;
    }
    print(currentThemeMode);
    notifyListeners();
  }

  /*void switchThemeData(){
    if(currentThemeData == null){
      currentThemeData = ThemeData.dark();
    }
  }*/
}