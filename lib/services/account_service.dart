import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/models/account/account_dto.dart';
import 'package:xideng_flutter/net/http_util.dart';
import 'package:xideng_flutter/services/service_response.dart';

import '../providers/account_provider.dart';

class AccountService{
  Future<ServiceResponse<AccountDTO>> authenticate(String email,String pwd)async {
    var response = await HttpUtil.post('account/authenticate',json:'{"email": "$email","password": "$pwd"}');

    if(response.statusCode == HttpStatus.badRequest){
      return ServiceResponse(false, '账号密码错误');
    }
    else if(response.statusCode != HttpStatus.ok){
      return ServiceResponse(false, '登录服务器不存在！');
    }

    var rawJson = await response.transform(utf8.decoder).join();


    debugPrint(rawJson);
    return ServiceResponse(true, '登录成功',dataModel: AccountDTO.fromJson(json.decode(rawJson)));
  }

  static DateTime? _lastSendTime;
  Future<ServiceResponse<int>> sendVerifyCode(String email)async{


    if(_lastSendTime != null){
      int inSecond = DateTime.now().difference(_lastSendTime!).inSeconds;
      if(inSecond < 60){
        return ServiceResponse(false, '请等待${60-inSecond}秒后再尝试发送验证码',dataModel: 60-inSecond);
      }
    }

    _lastSendTime = DateTime.now();
    //request email code
     var response = await HttpUtil.post('account/SendRegisterEmail',json: {'email':email}.toJson());
    if(response.statusCode != 200){
      _lastSendTime = null;
      return ServiceResponse(false, '获取邮箱验证码失败',dataModel: 3);
    }
    return ServiceResponse(true, '邮箱验证码发送成功',dataModel: 60);
  }
  
}