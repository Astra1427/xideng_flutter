import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';


extension MapExtension on Map{
  String toRawJson(){
    try {
      return json.encode(this);
    } catch (e, s) {
      log('json encode error::: $e \n $this',stackTrace: s);
      return '';
    }

  }
}