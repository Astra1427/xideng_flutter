import 'package:xideng_flutter/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_plan_collection_dto.g.dart';

@JsonSerializable()
class ExercisePlanCollectionDTO extends ModelBase {
  String exercisePlanId;
  String collectionFolderId;

  ExercisePlanCollectionDTO(
      super.id, this.exercisePlanId, this.collectionFolderId);
  Map<String,dynamic> toJson() => _$ExercisePlanCollectionDTOToJson(this);
  factory ExercisePlanCollectionDTO.fromJson(Map<String,dynamic> json) => _$ExercisePlanCollectionDTOFromJson(json);
}
