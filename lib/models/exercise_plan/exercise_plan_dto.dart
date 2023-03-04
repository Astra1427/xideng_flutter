import 'package:xideng_flutter/models/exercise_plan/plan_each_day_dto.dart';

import '../model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_plan_dto.g.dart';

@JsonSerializable()
class ExercisePlanDTO extends ModelBase {
//public new Guid Id { get; set; }
  String accountId;

  /**
   * 0:周 1:天
   */
  int cycle;

  int collectionCount;

  bool isPublic;

  bool isLoop;

  ExercisePlanDTO(
      super.id,
      this.accountId,
      this.cycle,
      this.collectionCount,
      this.isPublic,
      this.isLoop,
      this.name,
      this.description,
      this.coverUrl,
      this.planEachDays,

      this.authorImg,
      this.authorName,
  {this.dayNumber = 0,});
  // [Newtonsoft.Json.JsonIgnore]
  get disIsLoop => isLoop ? "循环" : "单次";

  String name;

  String? description;

  String? coverUrl;

  List<PlanEachDayDTO>? planEachDays;

// [Newtonsoft.Json.JsonIgnore]
  @JsonKey(includeToJson: false,includeFromJson: false)
  int dayNumber;

  String? authorImg;

  String? authorName;
// [Newtonsoft.Json.JsonIgnore]
// [SQLite.Ignore]
// String DisDescription => Description.Length > 8 ? Description.Substring(0, 8)+"……" : Description;
  Map<String,dynamic> toJson() => _$ExercisePlanDTOToJson(this);
  factory ExercisePlanDTO.fromJson(Map<String,dynamic> json) => _$ExercisePlanDTOFromJson(json);
}
