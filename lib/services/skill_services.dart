
import 'dart:convert';
import 'dart:io';

import 'package:xideng_flutter/common/extensions/string_extension.dart';
import 'package:xideng_flutter/net/apis.dart';
import 'package:xideng_flutter/net/http_util.dart';
import 'package:xideng_flutter/services/service_response.dart';

import '../models/skill/skill_dto.dart';

class SkillService{
  Future<ServiceResponse<List<SkillDTO>>> getSkillsWithDefault(String token)async{
    var response = await HttpUtil.get(SkillApis.GetSkillsWithDefault,token:token );

    var checkResponse = await HttpUtil.responseBasicCheck(response,msg: "获取六艺十式失败！");

    if(checkResponse.isSuccess) {
      return ServiceResponse(true, "操作成功",dataModel:checkResponse.dataModel!.toMap().values.map((value) => SkillDTO.fromJson(value)).toList());
    }else{
      return ServiceResponse(false,checkResponse.msg);
    }

  }
}