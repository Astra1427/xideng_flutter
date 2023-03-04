// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBase _$ModelBaseFromJson(Map<String, dynamic> json) => ModelBase(
      json['id'] as String,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$ModelBaseToJson(ModelBase instance) => <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
    };
