// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDTO _$AccountDTOFromJson(Map<String, dynamic> json) => AccountDTO(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      gender: json['gender'] as int?,
      accountStatus: json['accountStatus'] as int,
      accountLevel: json['accountLevel'] as int,
      introduce: json['introduce'] as String?,
      jwtToken: json['jwtToken'] as String,
      refreshToken: json['refreshToken'] as String,
      createTime: DateTime.parse(json['createTime'] as String),
    );

Map<String, dynamic> _$AccountDTOToJson(AccountDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'phoneNumber': instance.phoneNumber,
      'birthdate': instance.birthdate?.toIso8601String(),
      'gender': instance.gender,
      'accountStatus': instance.accountStatus,
      'accountLevel': instance.accountLevel,
      'introduce': instance.introduce,
      'jwtToken': instance.jwtToken,
      'refreshToken': instance.refreshToken,
      'createTime': instance.createTime.toIso8601String(),
    };
