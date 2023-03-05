import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xideng_flutter/services/service_response.dart';


class HttpUtil{
  static const host = '101.33.206.168';
  static const port = 8001;

  static const baseUrl = 'http://$host/api/';
  static HttpClient client = HttpClient()..findProxy = null;
  static Future<HttpClientResponse?> get(String path,{String? token,Map<String,dynamic>? queryParams})async {

    try {
      var request = await client.getUrl(Uri(host: host,port: port,path: '/api/$path',queryParameters:queryParams,scheme: "http"));
      if(token!=null) {
        request.headers.add("Authorization", "Bearer $token");
      }
      var response = await request.close();
      return response;
    } catch (e, s) {
      log(e.toString(),time:DateTime.now(),stackTrace: s);
      // throw s;
      return null;
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

  static Future<ServiceResponse<String>> responseBasicCheck(HttpClientResponse? response,{String msg = ""})async{
    if(response == null){

      return ServiceResponse(false, "获取失败，response is null");
    }
    else if(response.statusCode == HttpStatus.unauthorized){
      return ServiceResponse(false, "请登录！");
    }else if(response.statusCode != HttpStatus.ok){
      return ServiceResponse(true, msg);
    }
    var json = await response.transform(utf8.decoder).join();
    return ServiceResponse(true, "",dataModel: json);
  }
}
//http://101.33.206.168:8001/api/account/authenticate