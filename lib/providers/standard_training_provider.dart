import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:xideng_flutter/models/app_config.dart';

import '../models/skill/standard_dto.dart';

class StandardTrainingProvider with ChangeNotifier {
  late StandardDTO standardModel;

  set setStandard(StandardDTO model) {
    standardModel = model;
  }

  int countDownSecond = 3;
  bool isImg1 = true;
  bool isCountDown = false;
  bool isPause = false;
  bool isSleep = false;
  bool isFinish = false;
  int currentGroupNumber = 0;
  int currentNumber = 0;

  LinkedList<TrainingTaskItem> taskItems = LinkedList();
  TrainingTaskItem? currentTrainingTaskItem;

  void generateTrainingTaskItemQueue(AppConfigModel configModel) {
    //倒计时
    for (int i = 3; i > 0; i--) {
      taskItems.add(TrainingTaskItem(1000, TrainingPartType.countDown, i));
    }
    //动作
    for (int i = 0; i < standardModel.groupNumber; i++) {
      for (int j = 1; j <= standardModel.number; j++) {
        taskItems.add(TrainingTaskItem(
            configModel.downNumberSecond, TrainingPartType.training_2, j));
        taskItems.add(TrainingTaskItem(
            configModel.upNumberSecond, TrainingPartType.training_1, j));
      }

      if (standardModel.groupNumber == i + 1) {
        //finish
        taskItems.add(TrainingTaskItem(500, TrainingPartType.finish, 0));
        debugPrint('finish...');
        break;
      }

      for (int j = configModel.sleepSecond; j > 0; j--) {
        taskItems.add(TrainingTaskItem(1000, TrainingPartType.sleep, j));
      }
    }

    currentTrainingTaskItem = taskItems.first;
  }

  List<TrainingTaskItem> generateCountDown() {
    var removedItems = taskItems
        .where((element) => element.type == TrainingPartType.countDown || element.type == TrainingPartType.sleep)
        .toList();

    if(currentTrainingTaskItem?.type == TrainingPartType.countDown || currentTrainingTaskItem?.type == TrainingPartType.sleep){
      currentTrainingTaskItem = removedItems.first.previous;
      currentTrainingTaskItem ??= removedItems.last.next;
    }

    for (var entry in removedItems) {
      taskItems.remove(entry);
    }
    List<TrainingTaskItem> items = [];
    for (int i = 3; i > 0; i--) {
      items.add(TrainingTaskItem(1000, TrainingPartType.countDown, i));
    }

    return items;
  }

  void insertTaskAfter(TrainingTaskItem entry) {
    taskItems
        .firstWhere((element) => element == currentTrainingTaskItem)
        .insertAfter(entry);
  }


  void switchPause() {

    isPause = !isPause;
    notifyListeners();
    if (isPause) {
      // currentTrainingTaskItem
      //     ?.insertAfter(TrainingTaskItem(50, TrainingPartType.pause, 0));
    } else {
      var countDownTasks = generateCountDown();


      for (var element in countDownTasks) {
        currentTrainingTaskItem?.insertBefore(element);
      }
      currentTrainingTaskItem
          ?.insertBefore(TrainingTaskItem(500, TrainingPartType.start, 0));
      currentTrainingTaskItem = countDownTasks.first;
    }

  }


  void switchFinish() {
    isFinish = !isFinish;
    notifyListeners();
  }

  Future startContinue() async {
    isPause = false;
    isFinish = false;
    while (currentTrainingTaskItem != null) {
      if (trainingTaskStreamController.isClosed) {
        break;
      }
      trainingTaskStreamController.sink.add(currentTrainingTaskItem!);

      if (isPause) {
        await Future.delayed(const Duration(milliseconds: 200));
        continue;
      }
      if (isFinish) {
        break;
      }

      if (currentTrainingTaskItem != null) {
        await Future.delayed(
            Duration(milliseconds: currentTrainingTaskItem!.delayTime));
      }
      if(currentTrainingTaskItem != null){
        currentTrainingTaskItem = currentTrainingTaskItem!.next;
      }

      notifyListeners();
    }
  }

  var trainingTaskStreamController =
      StreamController<TrainingTaskItem>.broadcast();

  StreamSubscription<TrainingTaskItem> openSubscription(
      ) {
    if (trainingTaskStreamController.isClosed) {
      trainingTaskStreamController =
          StreamController<TrainingTaskItem>.broadcast();
    }
    return trainingTaskStreamController.stream.listen((event) {
      trainingTaskItemAction(event);
      notifyListeners();
    });
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
    isSleep = false;

  }

  @override
  void dispose() {
    debugPrint('trainingProvider dispose');
    disposeData();
    super.dispose();
  }

  void disposeData() {
    taskItems.clear();
    trainingTaskStreamController.close();
    currentTrainingTaskItem = null;
    countDownSecond = 3;
    isImg1 = true;
    isCountDown = false;
    isPause = false;
    isSleep = false;
    isFinish = false;
    currentGroupNumber = 0;
    currentNumber = 0;
    // notifyListeners();
  }
}

class TrainingTaskItem extends LinkedListEntry<TrainingTaskItem> {
  int delayTime;
  TrainingPartType type;
  int value;

  TrainingTaskItem(this.delayTime, this.type, this.value);
}

enum TrainingPartType {
  training_1, //动作 ‘一’
  training_2, //动作 ‘二’
  readSecond, //读秒动作
  countDown, //开始倒计时
  sleep, //组间休息
  start, // 开始
  finish, // 完毕
  pause, // 完毕

}
