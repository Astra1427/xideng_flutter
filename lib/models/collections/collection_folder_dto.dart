
import 'package:xideng_flutter/models/model_base.dart';

import 'exercise_plan_collection_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_folder_dto.g.dart';

@JsonSerializable()
class CollectionFolderDTO extends ModelBase {
  String accountId;

  String name;

  bool isPublic;

//[SQLite.Ignore]
  List<ExercisePlanCollectionDTO> exercisePlanCollections;

//[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]
  @JsonKey(includeFromJson: false,includeToJson: false)
  bool isSelected;

  /// <summary>
  /// Use for CollectionFolderPopupPage
  /// </summary>
  @JsonKey(includeFromJson: false,includeToJson: false)
  bool isAdded;

//[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]
  @JsonKey(includeFromJson: false,includeToJson: false)
  bool isDeleted;

  CollectionFolderDTO(
      super.id,
      this.accountId,
      this.name,
      this.isPublic,
      this.exercisePlanCollections,
      {this.isSelected = false, this.isAdded = false, this.isDeleted = false});
//[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]
  Map<String,dynamic> toJson() => _$CollectionFolderDTOToJson(this);
  factory CollectionFolderDTO.fromJson(Map<String,dynamic> json) => _$CollectionFolderDTOFromJson(json);
}
