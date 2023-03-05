import 'package:xideng_flutter/models/skill/skill_style_dto.dart';
import 'package:xideng_flutter/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan_each_day_dto.g.dart';

@JsonSerializable()
class PlanEachDayDTO extends ModelBase {
  //[PrimaryKey]
  //public new Guid Id { get; set; }
  String planId;

  String? styleID;

  int dayNumber;

  int? groupNumber;

  int? number;

  String time;
  get ExTime {
    try{
      var times = time.split(".").last.split(":");
      return Duration(hours: int.parse(times.first),minutes: int.parse(times[1]),seconds: int.parse(times[3]));
    }catch(e,s){
      return const Duration(hours:0,minutes:0,seconds:0);
    }
  }

  bool isRestDay;

// [Newtonsoft.Json.JsonIgnore]
  @JsonKey(includeToJson: false,includeFromJson: false)
  SkillStyleDTO? style;

// [SQLite.Ignore]
// [Newtonsoft.Json.JsonIgnore]
/*public SkillStyleDTO Style
{
get {
if (style == null && StyleID.HasValue)
{
style = SkillDataCommon.Skills.FirstOrDefault(x=>x.SkillStyles.Any(s=>s.Id == StyleID))?.SkillStyles?.FirstOrDefault(x=>x.Id == StyleID);
}
return style;
}
set { style = value; RaisePropertyChanged(nameof(Style)); }
}*/


  int orderNumber;

  PlanEachDayDTO(
      super.id,
      this.planId,
      this.styleID,
      this.dayNumber,
      this.groupNumber,
      this.number,
      this.time,
      this.isRestDay,
      this.orderNumber,
      {this.style,});
  @override
  String toString() {
    if (isRestDay || style == null)
    {
      return "休息日";
    }

    if (style!.traningType)
    {
      return "$groupNumber 组 $number次";
    }
    else
    {
      return "$groupNumber 组 $number秒";
    }
  }

  Map<String,dynamic> toJson() => _$PlanEachDayDTOToJson(this);
  factory PlanEachDayDTO.fromJson(Map<String,dynamic> json) => _$PlanEachDayDTOFromJson(json);
}
