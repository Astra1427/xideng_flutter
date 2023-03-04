import 'package:xideng_flutter/models/model_base.dart';
import 'package:xideng_flutter/models/skill/skill_style_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill_dto.g.dart';

@JsonSerializable()
class SkillDTO extends ModelBase {
  String name;

  String? description;

  String? imgUrl;

  String ownerId;

  int orderNumber;


//[SQLite.Ignore]
  List<SkillStyleDTO> skillStyles;

  SkillDTO(super.id, this.name, this.description, this.imgUrl, this.ownerId,
      this.orderNumber, this.skillStyles);

  //[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]

  void SkillFunc(Object obj) async {
    // await Shell.Current.GoToAsync($"StylePage?id={this.Id}");
  }

  Map<String,dynamic> toJson() => _$SkillDTOToJson(this);
  factory SkillDTO.fromJson(Map<String,dynamic> json) => _$SkillDTOFromJson(json);

}
