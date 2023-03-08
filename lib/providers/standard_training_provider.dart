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
    for (int i = 1; i <= standardModel.groupNumber; i++) {
      for (int j = 1; j <= standardModel.number; j++) {
        taskItems.add(TrainingTaskItem(
            configModel.downNumberSecond, TrainingPartType.training_2, j));
        taskItems.add(TrainingTaskItem(
            configModel.upNumberSecond, TrainingPartType.training_1, j));
      }

      taskItems.add(TrainingTaskItem(50, TrainingPartType.newGroup, i));
      if (standardModel.groupNumber == i) {
        //finish
        taskItems.add(TrainingTaskItem(500, TrainingPartType.finish, 0));
        debugPrint('finish...');
        break;
      }
      for (int j = configModel.sleepSecond; j > 0; j--) {
        taskItems.add(TrainingTaskItem(1000, TrainingPartType.sleep, j));
      }

    }

    currentAction = taskItems.firstWhere((element) => element.type == TrainingPartType.training_2);
    currentTrainingTaskItem = taskItems.first;
  }

  //双游标设计，防止用户高频次点击时动作数变为1
  TrainingTaskItem? currentAction;

  List<TrainingTaskItem> generateCountDown() {
    var removedItems = taskItems
        .where((element) =>
            element.type == TrainingPartType.countDown ||
            //element.type == TrainingPartType.sleep || 不能直接移除所有sleep，移除index小于currentAction的sleep
                (currentTrainingTaskItem?.type == TrainingPartType.sleep && element.type == TrainingPartType.sleep) ||
            element.type == TrainingPartType.start)
        .toList();

    debugPrint(
        'current::: ${currentTrainingTaskItem?.type}______${currentTrainingTaskItem?.value}');

    if (removedItems.isNotEmpty && (currentTrainingTaskItem?.type == TrainingPartType.countDown ||
        currentTrainingTaskItem?.type == TrainingPartType.sleep)) {
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
      _subscription?.pause();
    } else {
      var countDownTasks = generateCountDown();

      for (var element in countDownTasks) {
        currentAction?.insertBefore(element);
      }
      currentAction
          ?.insertBefore(TrainingTaskItem(500, TrainingPartType.start, 0));
      currentTrainingTaskItem = countDownTasks.first;
      _subscription?.resume();
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

      if (isPause) {
        await Future.delayed(const Duration(milliseconds: 200));
        continue;
      }
      if (isFinish) {
        break;
      }
      trainingTaskStreamController.sink.add(currentTrainingTaskItem!);

      if (currentTrainingTaskItem != null) {
        await Future.delayed(
            Duration(milliseconds: currentTrainingTaskItem!.delayTime));
      }
      if (currentTrainingTaskItem != null) {

        if (currentTrainingTaskItem!.next?.type != TrainingPartType.countDown &&
            currentTrainingTaskItem!.next?.type != TrainingPartType.sleep &&
            currentTrainingTaskItem!.next?.type != TrainingPartType.start) {
          currentAction = currentTrainingTaskItem!.next;
        }

        currentTrainingTaskItem = currentTrainingTaskItem!.next;
      }

      notifyListeners();
    }
  }

  var trainingTaskStreamController =
      StreamController<TrainingTaskItem>.broadcast();

  StreamSubscription<TrainingTaskItem>? _subscription;

  StreamSubscription<TrainingTaskItem> openSubscription() {
    if (trainingTaskStreamController.isClosed) {
      trainingTaskStreamController =
          StreamController<TrainingTaskItem>.broadcast();
    }
    return _subscription = trainingTaskStreamController.stream.listen((event) {
      debugPrint('${event.type}______${event.value}');
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
        currentNumber = 0;

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
      case TrainingPartType.newGroup:
        currentGroupNumber = event.value;
        break;
    }
  }

  void initData() {
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
    _subscription?.cancel();
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
  newGroup // 新的一组

}
