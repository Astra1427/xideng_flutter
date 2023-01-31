import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/components/home/running_plan.dart';
import 'package:xideng_flutter/providers/theme_provider.dart';
import 'package:xideng_flutter/styles/main_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          RunningPlan()
        ],
      ),
    );
  }

  //chart_4_240.png
  //arrow_63_240.png
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('熄灯',style: TextStyle(color:  Theme.of(context).appBarTheme.foregroundColor)),
      actions: [

        IconButton(
            onPressed: () {

            },
            icon: ImageIcon(AssetImage('images/book_64.png'),)),
        Consumer<AppThemeProvider>(builder: (context,provider,child){
          return IconButton(onPressed: (){
            provider.switchThemeModel();
          }, icon: Icon(provider.currentThemeMode == ThemeMode.light ? Icons.dark_mode_sharp : Icons.light_mode_sharp));
        }),
        // TODO: More Button
        /*IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_sharp)),*/
      ],
    );
  }
}
