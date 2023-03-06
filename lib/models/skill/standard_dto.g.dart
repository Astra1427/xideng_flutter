// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardDTO _$StandardDTOFromJson(Map<String, dynamic> json) => StandardDTO(
      json['id'] as String,
      json['styleId'] as String,
      json['groupNumber'] as int,
      json['number'] as int,
      json['grade'] as int,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$StandardDTOToJson(StandardDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'styleId': instance.styleId,
      'groupNumber': instance.groupNumber,
      'number': instance.number,
      'grade': instance.grade,
    };
