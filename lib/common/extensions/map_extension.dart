import 'dart:convert';

extension MapExtension on Map{
  String toRawJson(){
    return json.encode(this);
  }
}