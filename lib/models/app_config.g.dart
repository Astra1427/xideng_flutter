// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigModel _$AppConfigModelFromJson(Map<String, dynamic> json) =>
    AppConfigModel(
      sleepSecond: json['sleepSecond'] as int,
      numberSecond: json['numberSecond'] as int,
      downNumberSecond: json['downNumberSecond'] as int,
      upNumberSecond: json['upNumberSecond'] as int,
      isRespiratoryRhythm: json['isRespiratoryRhythm'] as int,
      startContinueSecond: json['startContinueSecond'] as int,
      backAudioVolume: (json['backAudioVolume'] as num).toDouble(),
      personAudioVolume: (json['personAudioVolume'] as num).toDouble(),
      versionNumber: json['versionNumber'] as String,
      isOffline: json['isOffline'] as bool,
    );

Map<String, dynamic> _$AppConfigModelToJson(AppConfigModel instance) =>
    <String, dynamic>{
      'sleepSecond': instance.sleepSecond,
      'numberSecond': instance.numberSecond,
      'downNumberSecond': instance.downNumberSecond,
      'upNumberSecond': instance.upNumberSecond,
      'isRespiratoryRhythm': instance.isRespiratoryRhythm,
      'startContinueSecond': instance.startContinueSecond,
      'backAudioVolume': instance.backAudioVolume,
      'personAudioVolume': instance.personAudioVolume,
      'versionNumber': instance.versionNumber,
      'isOffline': instance.isOffline,
    };
