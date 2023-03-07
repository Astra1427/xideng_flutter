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
  late final AppConfigModel configModel;
  late final SkillStyleDTO styleModel;
  int countDownSecond = 3;
  bool isImg1 = true;
  bool isCountDown = false;
  bool isPause = false;
  bool isSleep = false;
  bool isFinish = false;
  int currentGroupNumber = 0;
  int currentNumber = 0;
  late StreamSubscription<TrainingTaskItem> subscription;
  late StandardTrainingProvider trainingProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        var appProvider =
            Provider.of<AppConfigProvider>(context, listen: false);
        if (appProvider.appConfigModel == null) {
          configModel = AppConfigModel.getDefault();
        } else {
          configModel = appProvider.appConfigModel!;
        }

      });

      trainingProvider =
          Provider.of<StandardTrainingProvider>(context, listen: false);
      trainingProvider.setStandard = widget.standardModel;
      trainingProvider.generateTrainingTaskItemQueue(configModel);
      subscription = trainingProvider.openSubscription((event) {
        setState(() {
          trainingTaskItemAction(event);
        });
      });


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
        child: GestureDetector(
          onTap: (){
            if(isFinish){
              return;
            }
            trainingProvider.switchPause();
            setState(() {
              isPause = !isPause;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                  visible: isImg1,
                  child: Image.asset(
                    'images/${styleModel.img1Url}.png',
                    fit: BoxFit.fill,
                  )),
              Visibility(
                  visible: !isImg1,
                  child: Image.asset(
                    'images/${styleModel.img2Url}.png',
                    fit: BoxFit.fill,
                  )),
              Text(
                '$currentNumber / ${widget.standardModel.number}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              Visibility(
                  visible: isCountDown || isSleep, child: buildCountDown()),
              Visibility(visible: isPause, child: buildPausePanel()),
              Visibility(visible: isFinish, child: buildFinishPanel())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountDown() {
    return buildCirclePanel(
      onTap: (){
        trainingProvider.switchPause();
      },
      child: Text(
        countDownSecond.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 45),
      )
    );
  }

  Widget buildPausePanel() {
    return buildCirclePanel(
      onTap: (){
        if(isFinish){
          return;
        }
        trainingProvider.switchPause();
        setState(() {
          isPause = !isPause;
        });
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
    super.dispose();
    subscription.cancel();
    trainingProvider.disposeData();
    debugPrint('dispose....');


  }

  void trainingTaskItemAction(TrainingTaskItem event) {
    initData();
    switch (event.type) {
      case TrainingPartType.training_1:
        currentNumber = event.value;
        isImg1 = true;
        //TODO play 'one' audio
        break;
      case TrainingPartType.training_2:
        // currentNumber = event.value;
        isImg1 = false;
        //TODO play 'two' audio
        break;
      case TrainingPartType.readSecond:
        //TODO play 'value' audio
        //play(value)
        currentNumber = event.value;
        break;
      case TrainingPartType.countDown:
        //TODO play 'value' audio
        //play(value)
        countDownSecond = event.value;
        isCountDown = true;
        break;
      case TrainingPartType.sleep:
        countDownSecond = event.value;
        isSleep = true;
        break;
      case TrainingPartType.start:
        //TODO play 'start' audio
        break;
      case TrainingPartType.finish:
        //TODO play 'finish' audio
        isFinish = true;
        break;
      case TrainingPartType.pause:
        isPause = true;
        break;

    }
  }

  void initData(){
    isCountDown = false;
    isPause = trainingProvider.isPause;
    isSleep = false;

  }
}
