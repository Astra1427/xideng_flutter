import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfigModel{
   int sleepSecond ;
/// <summary>
/// 动作间隔时间 毫秒 【已弃用】
/// </summary>
   @Deprecated('请使用 downNumberSecond 和 upNumberSecond来控制动作间隔时间')
 int numberSecond ;
/// <summary>
/// Down动作时间 毫秒
/// </summary>
 int downNumberSecond ;
/// <summary>
/// Up动作时间 毫秒
/// </summary>
 int upNumberSecond ;
/// <summary>
/// 呼吸律动 0 关闭 1开启
/// </summary>
 int isRespiratoryRhythm ;
 int startContinueSecond ;
 double backAudioVolume ;
 double personAudioVolume ;
 String versionNumber ;

/// <summary>
/// 是否为离线模式 ， [Only Native]
/// </summary>
 bool isOffline ;

   AppConfigModel(
   {
     required this.sleepSecond,
     required this.numberSecond,
     required this.downNumberSecond,
     required this.upNumberSecond,
     required this.isRespiratoryRhythm,
     required this.startContinueSecond,
     required this.backAudioVolume,
     required this.personAudioVolume,
     required this.versionNumber,
     required this.isOffline});

   factory AppConfigModel.fromJson(Map<String,dynamic> json) => _$AppConfigModelFromJson(json);
   Map<String,dynamic> toJson()=>_$AppConfigModelToJson(this);

    factory AppConfigModel.getDefault() => AppConfigModel(
        numberSecond: 1200,
        sleepSecond: 45,
        isRespiratoryRhythm: 0,
        startContinueSecond: 3,
        backAudioVolume: 1,
        personAudioVolume: 1,
        // TODO:get version
        // versionNumber: VersionTracking.CurrentVersion,
        versionNumber: '0.0.1',
        upNumberSecond: 2000,
        downNumberSecond: 3000,
        isOffline: false);
}