import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';

import '../../models/app_config.dart';
import '../../models/skill/skill_style_dto.dart';
import '../../models/skill/standard_dto.dart';
import '../../providers/standard_training_provider.dart';

class StandardTrainingPage extends StatefulWidget {
  const StandardTrainingPage({Key? key, required this.standardModel})
      : super(key: key);
  final StandardDTO standardModel;

  @override
  State<StandardTrainingPage> createState() => _StandardTrainingPageState();
}

class _StandardTrainingPageState extends State<StandardTrainingPage> {
  String content = '';
  late final SkillStyleDTO styleModel;

  late StreamSubscription<TrainingTaskItem> subscription;
  late StandardTrainingProvider trainingProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var appProvider = Provider.of<AppConfigProvider>(context,listen: false);
      var configModel = appProvider.appConfigModel ?? AppConfigModel.getDefault();

       trainingProvider =
          Provider.of<StandardTrainingProvider>(context, listen: false);
      trainingProvider.setStandard = widget.standardModel;
      trainingProvider.generateTrainingTaskItemQueue(configModel);
      subscription = trainingProvider.openSubscription();

      await trainingProvider.startContinue();
    });

    var style = widget.standardModel.getSkillStyleDTO();

    if (style == null) {
      context.showMsg('今天是休息日');
      return;
    }
    setState(() {
      styleModel = style;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.standardModel.getSkillStyleDTO()?.name ?? ''} ${widget.standardModel.toString()}'),
      ),
      body: Center(
        child: Consumer2<StandardTrainingProvider,AppConfigProvider>(builder:(context,trainingProvider,appProvider,child){




          return GestureDetector(
            onTap: (){
              if(trainingProvider.isFinish){
                return;
              }
              trainingProvider.switchPause();

            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                    visible: trainingProvider.isImg1,
                    child: Image.asset(
                      'images/${styleModel.img1Url}.png',
                      fit: BoxFit.fill,
                    )),
                Visibility(
                    visible: !trainingProvider.isImg1,
                    child: Image.asset(
                      'images/${styleModel.img2Url}.png',
                      fit: BoxFit.fill,
                    )),
                Text(
                  '${trainingProvider.currentNumber} / ${widget.standardModel.number}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
                Visibility(
                    visible: trainingProvider.isCountDown || trainingProvider.isSleep, child: buildCountDown(trainingProvider)),
                Visibility(visible: trainingProvider.isPause, child: buildPausePanel(trainingProvider)),
                Visibility(visible: trainingProvider.isFinish, child: buildFinishPanel())
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildCountDown(StandardTrainingProvider trainingProvider) {
    return buildCirclePanel(
      onTap: (){
        trainingProvider.switchPause();
      },
      child: Text(
        trainingProvider.countDownSecond.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 45),
      )
    );
  }

  Widget buildPausePanel(StandardTrainingProvider trainingProvider) {
    return buildCirclePanel(
      onTap: (){
        if(trainingProvider.isFinish){
          return;
        }
        trainingProvider.switchPause();

      },
      child: const Icon(
        Icons.play_arrow_rounded,
        size: 60,
      )
    );
  }

  Widget buildFinishPanel(){
    return buildCirclePanel(
      child: Text('完毕',style: const TextStyle(color: Colors.white, fontSize: 45),),
    );
  }

  Widget buildCirclePanel({Widget? child, void Function()? onTap}) {
    var screenSize = MediaQuery.of(context).size;
    //圆的宽度
    var circleWidth = screenSize.width > screenSize.height
        ? screenSize.height * 0.5
        : screenSize.width * 0.5;
    return InkWell(
      onTap:onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: circleWidth,
        height: circleWidth,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.black.withOpacity(.85)),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    subscription.cancel();

    // Provider.of<StandardTrainingProvider>(context,listen: false).disposeData();
    trainingProvider.disposeData();
    debugPrint('dispose....');
    super.dispose();


  }


}
