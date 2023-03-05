import 'package:xideng_flutter/models/model_base.dart';
import 'package:xideng_flutter/models/skill/standard_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill_style_dto.g.dart';

@JsonSerializable()
class SkillStyleDTO extends ModelBase{
//[PrimaryKey]
  // new Guid Id;
   String skillId;
 String name;
   String img1Url;
//[SQLite.Ignore]
//[Newtonsoft.Json.JsonIgnore]
 //ImageSource Img1 => Uri.CheckSchemeName(Img1Url) ? ImageSource.FromUri(new Uri(Img1Url)) : Utility.GetImage(Img1Url);
 String img2Url;
//[SQLite.Ignore]
//[Newtonsoft.Json.JsonIgnore]
 //ImageSource Img2 => Uri.CheckSchemeName(Img2Url) ? ImageSource.FromUri(new Uri(Img2Url)) : Utility.GetImage(Img2Url);
 String? videoUrl;
 String traningPart;
 String actionDescription;
 String analysis;
 String slowSteady;
 int orderNumber;

/// <summary>
/// False is the number of groups
/// True is the time
/// </summary>
 bool traningType;
/// <summary>
/// ture is single
/// false is double
/// </summary>
 bool isSingle;


//[SQLite.Ignore]
 List<StandardDTO>? standards;

 String skillName;

//[Newtonsoft.Json.JsonIgnore]
//[SQLite.Ignore]

  void skillStyleFunc(Object obj)async
{
  // await Shell.Current.GoToAsync($"SkillStyleDetailPage?SkillID={this.SkillId}&SkillStyleID={this.Id}");
}

  SkillStyleDTO(
      super.id,
      this.skillId,
      this.name,
      this.img1Url,
      this.img2Url,

      this.traningPart,
      this.actionDescription,
      this.analysis,
      this.slowSteady,
      this.orderNumber,
      this.traningType,
      this.isSingle,
      this.standards,
      this.skillName,
      {this.videoUrl,});

 Map<String,dynamic> toJson() => _$SkillStyleDTOToJson(this);
 factory SkillStyleDTO.fromJson(Map<String,dynamic> json) => _$SkillStyleDTOFromJson(json);
}