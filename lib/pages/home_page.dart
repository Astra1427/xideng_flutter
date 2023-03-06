import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/components/home/running_plan.dart';
import 'package:xideng_flutter/components/home/skill_item.dart';
import 'package:xideng_flutter/models/app_config.dart';
import 'package:xideng_flutter/providers/skills_provider.dart';
import 'package:xideng_flutter/providers/theme_provider.dart';
import 'package:xideng_flutter/styles/main_style.dart';

import '../models/skill/skill_dto.dart';
import '../providers/app_config_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SkillDTO> skills = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var appConfigProvider =
          Provider.of<AppConfigProvider>(context, listen: false);
      appConfigProvider.loadAppConfigModel();
      if (await appConfigProvider.isFirstStart()) {
        appConfigProvider.setFirstStart();
        appConfigProvider.setAppConfigModel(AppConfigModel.getDefault());
        context.showMsg("这是您第一次使用app，程序将会下载一些必要的数据，请确保网络连接正常。");
        var skillsJson = await DefaultAssetBundle.of(context)
            .loadString("res/data/XiDengSkillsDataJson.json");

        var skills = (jsonDecode(skillsJson) as List<dynamic>)
            .map((element) => SkillDTO.fromJson(element))
            .toList();

        if (!mounted) {
          return;
        }
        await Provider.of<SkillsProvider>(context, listen: false)
            .setSkills(skills);
      }
      if (!mounted) {
        return;
      }

      var skillsProvider = Provider.of<SkillsProvider>(context, listen: false);
      await skillsProvider.loadSkillsFromLocal();
      setState(() {
        skills = skillsProvider.skills;
        print("skills.length:${skills.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          const RunningPlan(),
          const SizedBox(
            height: 10,
          ),
          buildSkills()
        ],
      ),
    );
  }

  //chart_4_240.png
  //arrow_63_240.png
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('熄灯',
          style:
              TextStyle(color: Theme.of(context).appBarTheme.foregroundColor)),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage('images/book_64.png'),
            )),
        Consumer<AppThemeProvider>(builder: (context, provider, child) {
          return IconButton(
              onPressed: () {
                provider.switchThemeModel();
              },
              icon: Icon(provider.currentThemeMode == ThemeMode.light
                  ? Icons.dark_mode_sharp
                  : Icons.light_mode_sharp));
        }),
        // TODO: More Button
        /*IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_sharp)),*/
      ],
    );
  }

  Widget buildSkills() {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        for (var skill in skills)
          SkillItem(
            skillModel: skill,
          )
      ],
    );
  }
}
