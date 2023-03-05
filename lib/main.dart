import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xideng_flutter/main_navigator_page.dart';
import 'package:xideng_flutter/pages/home_page.dart';
import 'package:xideng_flutter/providers/account_provider.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';
import 'package:xideng_flutter/providers/skills_provider.dart';
import 'package:xideng_flutter/providers/theme_provider.dart';
import 'package:xideng_flutter/styles/main_style.dart';

import 'themes/common_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context)=> AccountProvider()),
        ChangeNotifierProvider(create: (context)=> AppConfigProvider()),
        ChangeNotifierProvider(create: (context)=> SkillsProvider())
      ],
      child: Consumer<AppThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme,

            themeMode: provider.currentThemeMode,
            title: '熄灯',
            home: const MainNavigationPage(),

          );
        },
      ),
    );
  }


}
