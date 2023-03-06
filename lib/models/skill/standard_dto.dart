import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/nav_key.dart';
import 'package:xideng_flutter/models/skill/skill_style_dto.dart';
import 'package:xideng_flutter/models/model_base.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:xideng_flutter/providers/skills_provider.dart';

part 'standard_dto.g.dart';

@JsonSerializable()
class StandardDTO extends ModelBase {
  String styleId;

  int groupNumber;

  int number;

  int grade;

  get disGrade {
    switch (grade) {
      case 1:
        return "初级标准";
      case 2:
        return "中级标准";
      case 3:
        return "高级标准";
      case 4:
        return "自由训练";
      default:
        return "----";
    }
  }

//[Newtonsoft.Json.JsonIgnore]
  @JsonKey(includeFromJson: false,includeToJson:false)
  SkillStyleDTO? style;

//[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]
  get skillStyleDTO {
    if (style == null) {
      return style;
    }
  }

  SkillStyleDTO? getSkillStyleDTO() {

    if(NavKey.navKey.currentState==null) {
      return null;
    }

    return style ??= Provider.of<SkillsProvider>(
            NavKey.navKey.currentState!.context,
            listen: false)
        .skills
        .firstWhere(
            (element) => element.skillStyles.any((s) => s.id == styleId))
        .skillStyles
        .firstWhere((element) => element.id == styleId);
  }

  StandardDTO(super.id, this.styleId, this.groupNumber, this.number, this.grade,
      {this.style});

  @override
  String toString() {
    if (getSkillStyleDTO() == null) {
      return "休息日";
    }

    if (!style!.traningType) {
      return "$groupNumber 组 $number 次";
    } else {
      return "$groupNumber 组 $number 秒";
    }
  }

/* StandardDTO(StandardDTO standard)
{
  this.Id = standard.Id;
  this.StyleId = standard.StyleId;
  this.GroupNumber = standard.GroupNumber;
  this.Number = standard.Number;
  this.Grade = standard.Grade;
  this.style = standard.style;
}*/

  Map<String, dynamic> toJson() => _$StandardDTOToJson(this);

  factory StandardDTO.fromJson(Map<String, dynamic> json) =>
      _$StandardDTOFromJson(json);

  factory StandardDTO.getDefault(String styleId) =>
      StandardDTO('0', styleId, 1, 1, 4);
}
