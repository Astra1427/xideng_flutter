import 'dart:convert';

extension MapExtension on Map{
  String toJson(){
    return json.encode(this);
  }
}