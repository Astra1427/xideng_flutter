import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';


class HttpUtil{
  static const host = '101.33.206.168';
  static const port = 8001;

  static const baseUrl = '$host/api/';
  static HttpClient client = HttpClient()..findProxy = null;
  static Future<HttpClientResponse> get(String path,{String? token,Map<String,dynamic>? queryParams})async {

    try {
      var request = await client.getUrl(Uri(host: host,port: port,path: path,queryParameters:queryParams));
      if(token!=null) {
        request.headers.add("Authorization", "Bearer $token");
      }
      var response = await request.close();
      return response;
    } catch (e, s) {
      throw s;
    }
    finally{
      debugPrint('get end....');
    }
  }

  static Future<HttpClientResponse> post(String path,{String? token,String? json})async{
    try {

      var request = await client.post(host, port, '/api/$path');

      if(token != null){
        request.headers.add('Authorization', 'Bearer $token');
      }
      if(json != null){
        request.headers.contentType = ContentType('application','json',charset: 'utf-8');
        debugPrint('post::: ${request.uri}');
        request.write(json);
      }

      var response = await request.close();
      debugPrint(response.statusCode.toString());
      return response;
    } catch (e, s) {
      throw s;
    }
    finally{
      debugPrint('post end....');

    }
  }
}
//http://101.33.206.168:8001/api/account/authenticate