import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/models/app_config.dart';
import 'package:xideng_flutter/pages/skills/standard_training_page.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';

import '../../models/skill/skill_style_dto.dart';
import '../../models/skill/standard_dto.dart';
import '../common/NumberStepper.dart';

class TrainingSettingsDialog extends StatefulWidget {
  const TrainingSettingsDialog({Key? key, required this.styleModel})
      : super(key: key);
  final SkillStyleDTO styleModel;

  @override
  State<TrainingSettingsDialog> createState() => _TrainingSettingsDialogState();
}

class _TrainingSettingsDialogState extends State<TrainingSettingsDialog> {
  AppConfigModel configModel = AppConfigModel.getDefault();
  late StandardDTO standardModel;

  @override
  void initState() {
    super.initState();
    standardModel = widget.styleModel.standards?.first ?? StandardDTO.getDefault(widget.styleModel.id);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var appProvider = Provider.of<AppConfigProvider>(context, listen: false);
      if (appProvider.appConfigModel == null) {
        appProvider.loadAppConfigModel();
      }
      setState(() {
        configModel = appProvider.appConfigModel!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('训练设置'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('动作 "一" 的时间：${configModel.downNumberSecond / 1000} s(秒)'),
            NumberStepper(
              content: (configModel.downNumberSecond / 1000).toString(),
              value: configModel.downNumberSecond.toDouble(),
              min: 1000 * 0.5,
              max: 1000 * 10,
              stepNumber: 500,
              onValueChanged: (value, type) {
                setState(() {
                  configModel.downNumberSecond = value.toInt();
                });
              },
            ),
            const Divider(height: 1),
            Text('动作 "二" 的时间：${configModel.upNumberSecond} s(秒)'),
            NumberStepper(
              content: (configModel.upNumberSecond / 1000).toString(),
              value: configModel.upNumberSecond.toDouble(),
              min: 1000 * 0.5,
              max: 1000 * 10,
              stepNumber: 500,
              onValueChanged: (value, type) {
                setState(() {
                  configModel.upNumberSecond = value.toInt();
                });
              },
            ),
            const Divider(height: 1),
            Text('组间休息的时间：${configModel.sleepSecond} s(秒)'),
            NumberStepper(
              content: (configModel.sleepSecond).toString(),
              value: configModel.sleepSecond.toDouble(),
              min: 10,
              max: 10000,
              stepNumber: 1,
              onValueChanged: (value, type) {
                setState(() {
                  configModel.sleepSecond = value.toInt();
                });
              },
            ),
            Text('开始倒计时的时间：${configModel.startContinueSecond} s(秒)'),
            NumberStepper(
              content: (configModel.startContinueSecond).toString(),
              value: configModel.startContinueSecond.toDouble(),
              min: 3,
              max: 100,
              stepNumber: 1,
              onValueChanged: (value, type) {
                setState(() {
                  configModel.startContinueSecond = value.toInt();
                });
              },
            ),
            OutlinedButton(
              onPressed: () async {
                var items = ['自由选择'];
                if (widget.styleModel.standards != null) {
                  items.insertAll(0, widget.styleModel.standards!.map((e) => e.disGrade.toString()).toList());
                }
                var selectedStandard =
                    await context.showSelectionDialog('选择级别', items);
                if (selectedStandard == null) {
                  return;
                }
                setState(() {
                  if (widget.styleModel.standards != null && items.indexOf(selectedStandard) < 3 ) {
                    standardModel = widget
                        .styleModel.standards![items.indexOf(selectedStandard)];
                  } else {
                    standardModel = StandardDTO.getDefault(widget.styleModel.id);
                  }
                });
              },
              child: Text(standardModel.disGrade.toString()),
            ),
            Text(standardModel.toString()),
            if(standardModel.grade == 4)
              buildGradeSettings()

          ],
        ),
      ),
      actions: [
        TextButton(onPressed: ()async{
          await Provider.of<AppConfigProvider>(context,listen: false).setAppConfigModel(configModel);
          if(!mounted){
            return;
          }
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StandardTrainingPage(standardModel: standardModel)));
        }, child: const Text('设置好了，开始训练'),)
      ],
    );
  }

  Widget buildGradeSettings(){



    return Column(
      children: [
        NumberStepper(onValueChanged: (value,type){
          setState(() {
            standardModel.groupNumber = value.toInt();
          });
        }, content: '${standardModel.toString().split('组')[0]}组', value: standardModel.groupNumber.toDouble(), stepNumber: 1, min: 1, max: 100),
        NumberStepper(onValueChanged: (value,type){
          setState(() {
            standardModel.number = value.toInt();
          });
        }, content: standardModel.toString().split('组')[1], value: standardModel.number.toDouble(), stepNumber: 1, min: 1, max: 100),

      ],
    );
  }
}
