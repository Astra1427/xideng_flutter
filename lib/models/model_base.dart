import 'package:json_annotation/json_annotation.dart';

part 'model_base.g.dart';


@JsonSerializable()
class ModelBase {
  String id;
  String? createTime  =DateTime.now().toString();

  ModelBase(this.id);
}
