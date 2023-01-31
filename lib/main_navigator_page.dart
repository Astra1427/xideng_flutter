import 'package:flutter/material.dart';
import 'package:xideng_flutter/pages/public_plan_page.dart';

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