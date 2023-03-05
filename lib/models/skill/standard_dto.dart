import 'package:xideng_flutter/models/skill/skill_style_dto.dart';
import 'package:xideng_flutter/models/model_base.dart';

import 'package:json_annotation/json_annotation.dart';

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
  SkillStyleDTO? style;

//[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]
  get skillStyleDTO {
    if (style == null)
// style = SkillDataCommon.Skills.FirstOrDefault(x => x.SkillStyles.Any(s => s.Id == StyleId)).SkillStyles.FirstOrDefault(x => x.Id == StyleId);
      return style;
  }

  StandardDTO(super.id, this.styleId, this.groupNumber, this.number, this.grade,
      {this.style});

  @override
  String toString() {
    if (style == null)
    {
      return "休息日";
    }

    if (!style!.traningType) {
      return "$groupNumber 组 $number次";

    } else {
      return "$groupNumber 组 $number秒";
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

  Map<String,dynamic> toJson() => _$StandardDTOToJson(this);
  factory StandardDTO.fromJson(Map<String,dynamic> json) => _$StandardDTOFromJson(json);
}
