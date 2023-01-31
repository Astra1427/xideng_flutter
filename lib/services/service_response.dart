class ServiceResponse<T>{
  bool isSuccess;
  String msg;
  T? dataModel;
  ServiceResponse(this.isSuccess, this.msg,{this.dataModel});
}