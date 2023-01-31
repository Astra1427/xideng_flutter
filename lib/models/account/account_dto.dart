import 'package:json_annotation/json_annotation.dart';

part 'account_dto.g.dart';

@JsonSerializable()
class AccountDTO{
  String id;
  String email;
  String name;
  String? photoUrl;
  String? phoneNumber;
  DateTime? birthdate;
  int? gender;
  int accountStatus;
  int accountLevel;
  String? introduce;
  String jwtToken;
  String refreshToken;
  DateTime createTime;

  AccountDTO(
  {
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.phoneNumber,
    this.birthdate,
    this.gender,
    required this.accountStatus,
    required this.accountLevel,
    this.introduce,
    required this.jwtToken,
    required this.refreshToken,
    required this.createTime
});

  factory AccountDTO.fromJson(Map<String,dynamic> json) {
    var newAccount = _$AccountDTOFromJson(json);
    if(newAccount.photoUrl == null || newAccount.photoUrl!.isEmpty){
      newAccount.photoUrl = 'https://qlogo4.store.qq.com/qzone/2573019279/2573019279/100?1650630063';
    }
    return newAccount;
  }
  Map<String,dynamic> toJson() => _$AccountDTOToJson(this);

}

/*
{
    "id": "7dab05d6-0bd6-40f7-83dc-0309dc5db786",
    "email": "1427917847@qq.com",
    "name": "test",
    "photoUrl": null,
    "phoneNumber": null,
    "birthdate": null,
    "gender": null,
    "accountStatus": 0,
    "accountLevel": 1,
    "introduce": "这个人懒死了，什么都没有写╮(￣▽￣\")╭ ",
    "jwtToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwdXJwb3NlIjoieGRBY2Nlc3NQdXJwb3NlIiwiaWQiOiI3ZGFiMDVkNi0wYmQ2LTQwZjctODNkYy0wMzA5ZGM1ZGI3ODYiLCJuYmYiOjE2NzQ4OTAxMzQsImV4cCI6MTY3NDg5NzMzNCwiaWF0IjoxNjc0ODkwMTM0LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo4MDAxIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6ODAwMSJ9.If4MJ4OhTnEWkq_VaDhYQ0nU6qdTkX4LRAs6YCSoEgA",
    "refreshToken": "XQsBSO4ZlY9T/y8oG6eGMGlriuZ8CDGGVo+zCbc0p3cKyOe8K+wQQy/PRbHU2HnW/+MvR1RzMKsnMGpEwbkURA==",
    "createTime": "2022-04-10T16:36:10.338627"
}
* */