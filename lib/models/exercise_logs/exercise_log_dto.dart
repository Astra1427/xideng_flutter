import 'package:xideng_flutter/models/model_base.dart';

import '../skill/skill_style_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_log_dto.g.dart';

@JsonSerializable()
class ExerciseLogDTO extends ModelBase {
  //[SQLite.Ignore]
  String? skillName;

  String accountId;

  /// <summary>
  /// Exercise Project
  /// </summary>
  String styleId;

  /// <summary>
  /// Exersice Date
  /// </summary>
  DateTime exerciseDateTime;

  /// <summary>
  /// Exercise Time
  /// </summary>
  int exerciseTime;

  /// <summary>
  /// Feeling
  /// </summary>
  String feeling;

  /// <summary>
  /// Dis Feeling max char : 11
  /// </summary>
  //[SQLite.Ignore]
  @JsonKey(includeToJson: false, includeFromJson: false)
  String disFeeling;

  int groupNumber;

  int number;

  //[Newtonsoft.Json.JsonIgnore]
  @JsonKey(includeToJson: false, includeFromJson: false)
  SkillStyleDTO? style;

  //[SQLite.Ignore]
  //[Newtonsoft.Json.JsonIgnore]
  get skillStyleDTO {
    if (style == null) {
      // style = SkillDataCommon.Skills.FirstOrDefault(x => x.SkillStyles.Any(s => s.Id == StyleId)).SkillStyles.FirstOrDefault(x => x.Id == StyleId);
    }
    return style;
  }

  ExerciseLogDTO(
    super.id,
    this.skillName,
    this.accountId,
    this.styleId,
    this.exerciseDateTime,
    this.exerciseTime,
    this.feeling,
    this.groupNumber,
    this.number, {
    this.style,
    this.disFeeling = "",
  });

/* override String ToString()
  {
  if (!Style.TraningType)
  {
  return $"{GroupNumber} 组 {Number}次";
  }
  else
  {
  return $"{GroupNumber} 组 {Number}秒";
  }
  }*/

  @override
  String toString() {
    if (style == null) {
      return "休息日";
    }

    if (!style!.traningType) {
      return "$groupNumber 组 $number次";
    } else {
      return "$groupNumber 组 $number秒";
    }
  }

  Map<String, dynamic> toJson() => _$ExerciseLogDTOToJson(this);

  factory ExerciseLogDTO.fromJson(Map<String, dynamic> json) =>
      _$ExerciseLogDTOFromJson(json);
}
