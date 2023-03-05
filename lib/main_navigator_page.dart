import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/extensions/string_extension.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/models/account/account_dto.dart';
import 'package:xideng_flutter/models/skill/skill_dto.dart';
import 'package:xideng_flutter/pages/public_plan_page.dart';
import 'package:xideng_flutter/providers/account_provider.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';
import 'package:xideng_flutter/providers/skills_provider.dart';
import 'package:xideng_flutter/services/skill_services.dart';

import 'pages/home_page.dart';
import 'pages/my_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int curIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      debugPrint('main navigator page addPostFrameCallback...');
      Provider.of<AccountProvider>(context,listen: false).loadSavedUserInfo();

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: getCurrentIndexPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            curIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('images/home_6_240.png')), label: '首页'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/weather_116_240.png')), label: '计划'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/user_5_240.png')), label: '我的'),
        ],
      ),
    );
  }

  Widget getCurrentIndexPage(){
    switch(curIndex){
      case 1:
        return const PublicPlanPage();
      case 2:
        return const MyPage();
      default:
        return const HomePage();
    }
  }
}
