import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:xideng_flutter/models/app_config.dart';

import '../models/skill/standard_dto.dart';
import '../services/audio_service.dart';

class StandardTrainingProvider with ChangeNotifier {
  ///倒计时秒数
  int countDownSecond = 3;

  ///显示图片 1
  bool isImg1 = true;

  ///显示隐藏倒计时
  bool isCountDown = false;

  ///显示隐藏暂停
  bool isPause = false;

  /// 显示隐藏组间休息
  bool isSleep = false;

  /// 显示隐藏完毕
  bool isFinish = false;

  /// 当前的组数
  int currentGroupNumber = 0;

  /// 当前的动作数
  int currentNumber = 0;

  /// 任务链表
  LinkedList<TrainingTaskItem> taskItems = LinkedList();

  /// 当前的任务
  /// 马上就会执行（执行完上一个任务就执行当前任务）
  TrainingTaskItem? currentTrainingTaskItem;

  /// 当前的动作任务
  /// 当前的动作任务不一定马上就会执行
  /// 双游标设计，目的是防止用户高频次点击时因动作数变为1
  TrainingTaskItem? currentAction;

  /// 根据 AppConfigModel 和 StandardDTO  生成任务链表
  void generateTrainingTaskItemQueue(
      AppConfigModel configModel, StandardDTO standardModel) {
    //生成 倒计时
    for (int i = 3; i > 0; i--) {
      taskItems.add(TrainingTaskItem(1000, TrainingPartType.countDown, i));
    }

    //生成开始
    taskItems.add(TrainingTaskItem(1000, TrainingPartType.start, 0));

    //生成 动作/组
    for (int i = 1; i <= standardModel.groupNumber; i++) {
      //生成动作
      for (int j = 1; j <= standardModel.number; j++) {
        if (standardModel.getSkillStyleDTO()?.traningType == true) {
          taskItems.add(TrainingTaskItem(1000, TrainingPartType.readSecond, j));
        } else {
          //为了观感 先显示 动作2
          taskItems.add(TrainingTaskItem(
              configModel.downNumberSecond, TrainingPartType.training_2, j));
          taskItems.add(TrainingTaskItem(
              configModel.upNumberSecond, TrainingPartType.training_1, j));
        }
      }
      //生成 组
      taskItems.add(TrainingTaskItem(50, TrainingPartType.newGroup, i));
      //如果i == 所有组数，那么生成一个 '完毕' 的task
      if (standardModel.groupNumber == i) {
        //finish
        taskItems.add(TrainingTaskItem(500, TrainingPartType.finish, 0));
        debugPrint('finish...');
        //不用再添加组间休息的task了，所以直接break;
        break;
      }
      //生成 组间休息的task
      for (int j = configModel.sleepSecond; j > 0; j--) {
        //tag传组数
        taskItems
            .add(TrainingTaskItem(1000, TrainingPartType.sleep, j, tag: i));
      }
      taskItems.add(TrainingTaskItem(50, TrainingPartType.start, 0));
    }

    //设置当前的动作为 排在第一位的 '动作2'任务
    currentAction = taskItems.firstWhere((element) =>
        element.type == TrainingPartType.training_2 ||
        element.type == TrainingPartType.readSecond);
    //设置当前任务为 任务链表的首个任务
    currentTrainingTaskItem = taskItems.first;
  }

  /// 生成倒计时（countDown）任务
  List<TrainingTaskItem> generateCountDown() {
    //生成之前先移除taskItems里已存在的倒计时任务、start任务，
    // 如果当前的任务类型为sleep那么就能移除所有与当前任务tag值相同的sleep任务，这样可以实现跳过当前的组间休息时间。
    var removedItems = taskItems
        .where((element) =>
            element.type == TrainingPartType.countDown ||
            //element.type == TrainingPartType.sleep || 不能直接移除所有sleep,因为这样会导致还没执行的sleep也被移除。
            (currentTrainingTaskItem?.type == TrainingPartType.sleep &&
                element.type == TrainingPartType.sleep &&
                currentTrainingTaskItem?.tag == element.tag) ||
            element.type == TrainingPartType.start)
        .toList();

    debugPrint(
        'current::: ${currentTrainingTaskItem?.type}______${currentTrainingTaskItem?.value}');

    //如果当前的任务类型为countDown 或者 sleep，那么在移除removedItems之前得先确定移除后的'当前任务'
    //使用场景为：当已经在倒计时了，用户又需要暂停的时候。
    if (removedItems.isNotEmpty &&
        (currentTrainingTaskItem?.type == TrainingPartType.countDown ||
            currentTrainingTaskItem?.type == TrainingPartType.sleep)) {
      //如果removedItems存在上一个任务就把removedItems的上一个任务设为当前任务，
      currentTrainingTaskItem = removedItems.first.previous;
      //如果removedItems不存在上一个任务，就把removedItems的下一个任务设为当前任务
      currentTrainingTaskItem ??= removedItems.last.next;
    }

    //从taskItems中移除removedItems
    for (var entry in removedItems) {
      taskItems.remove(entry);
    }
    //生成新的倒计时任务
    List<TrainingTaskItem> items = [];
    for (int i = 3; i > 0; i--) {
      items.add(TrainingTaskItem(1000, TrainingPartType.countDown, i));
    }
    //返回出去
    return items;
  }

  void insertTaskAfter(TrainingTaskItem entry) {
    taskItems
        .firstWhere((element) => element == currentTrainingTaskItem)
        .insertAfter(entry);
  }

  /// 切换暂停
  void switchPause() {
    //切换暂停
    isPause = !isPause;
    notifyListeners();

    if (isPause) {
      // currentTrainingTaskItem
      //     ?.insertAfter(TrainingTaskItem(50, TrainingPartType.pause, 0));
      //暂停对流的监听
      _subscription?.pause();
    } else {
      //生成倒计时任务
      var countDownTasks = generateCountDown();
      //将倒计时任务插入到当前动作任务（currentAction）之前。
      for (var element in countDownTasks) {
        currentAction?.insertBefore(element);
      }
      //将'开始'任务插入到currentAction 之前。
      currentAction
          ?.insertBefore(TrainingTaskItem(500, TrainingPartType.start, 0));
      //设置当前任务为倒计时任务的首个（也就是 倒计时：3）
      currentTrainingTaskItem = countDownTasks.first;
      //恢复对流的监听
      _subscription?.resume();
    }
  }

  //切换完毕
  void switchFinish() {
    isFinish = !isFinish;
    notifyListeners();
  }

  /// 开始训练（往流中添加task）
  Future startTraining() async {
    //重置暂停和完毕状态
    isPause = false;
    isFinish = false;
    //迭代链表,从当前任务开始
    while (currentTrainingTaskItem != null) {
      if (trainingTaskStreamController.isClosed) {
        break;
      }

      if (isPause) {
        //如果暂停了，每200毫秒检测一次暂停状态，数字越小反应越快，但对性能的要求也越高
        await Future.delayed(const Duration(milliseconds: 200));
        continue;
      }
      if (isFinish) {
        break;
      }

      //将当前任务放入流中
      trainingTaskStreamController.sink.add(currentTrainingTaskItem!);

      if (currentTrainingTaskItem != null) {
        //每个任务都有的执行时间
        await Future.delayed(
            Duration(milliseconds: currentTrainingTaskItem!.delayTime));
      }
      if (currentTrainingTaskItem != null) {
        if (currentTrainingTaskItem!.next?.type != TrainingPartType.countDown &&
            currentTrainingTaskItem!.next?.type != TrainingPartType.sleep &&
            currentTrainingTaskItem!.next?.type != TrainingPartType.start) {
          //设置当前动作任务
          currentAction = currentTrainingTaskItem!.next;
        }
        //设置当前任务
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
    //打开并返回一个对流的监听器
    return _subscription = trainingTaskStreamController.stream.listen((event) {
      debugPrint('${event.type}______${event.value}');
      //执行task
      trainingTaskItemAction(event);
      notifyListeners();
    });
  }

  /// 根据task的type执行对应的操作
  void trainingTaskItemAction(TrainingTaskItem event) async {
    //初始化数据
    initData();
    switch (event.type) {
      case TrainingPartType.training_1:
        currentNumber = event.value;
        isImg1 = true;
        //TODO play 'one' audio
        AudioService.twoPlayer.load();
        AudioService.twoPlayer.play();
        break;
      case TrainingPartType.training_2:
        // currentNumber = event.value;
        isImg1 = false;
        //TODO play 'two' audio

        AudioService.onePlayer.load();
        AudioService.onePlayer.play();
        break;
      case TrainingPartType.readSecond:
        //TODO play 'value' audio
        //play(value)
        currentNumber = event.value;
        break;
      case TrainingPartType.countDown:
        //TODO play 'value' audio
        switch (event.value) {
          case 3:
            AudioService.threePlayer.load();
            AudioService.threePlayer.play();
            break;
          case 2:
            AudioService.twoPlayer.load();
            AudioService.twoPlayer.play();
            break;
          case 1:
            AudioService.onePlayer.load();
            AudioService.onePlayer.play();
            break;
        }
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
        AudioService.startPlayer.load();
        AudioService.startPlayer.play();
        break;
      case TrainingPartType.finish:
        //TODO play 'finish' audio
        AudioService.finishPlayer.load();
        AudioService.finishPlayer.play();
        isFinish = true;
        break;
      case TrainingPartType.pause:
        isPause = true;
        break;
      case TrainingPartType.newGroup:
        currentGroupNumber = event.value;
        AudioService.recoveryPlayer.load();
        AudioService.recoveryPlayer.play();
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
  // 每个任务都有一个执行时间
  int delayTime;
  TrainingPartType type;
  int value;
  int? tag;

  TrainingTaskItem(this.delayTime, this.type, this.value, {this.tag});
}

enum TrainingPartType {
  /// 动作 ‘一’
  training_1,

  /// 动作 ‘二’
  training_2,

  /// 读秒动作
  readSecond,

  /// 开始倒计时
  countDown,

  /// 组间休息
  sleep,

  /// 开始
  start,

  /// 完毕
  finish,

  /// 暂停
  pause,

  /// 新的一组
  newGroup
}
