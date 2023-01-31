import 'package:flutter/material.dart';

import '../styles/main_style.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: ThemeData.dark()
        .appBarTheme
        .copyWith(backgroundColor: appBarBackColor),
    scaffoldBackgroundColor: mainBackColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: selectedBottomNavigationBarItemColor,
        unselectedItemColor: unselectedBottomNavigationBarItemColor),
);
