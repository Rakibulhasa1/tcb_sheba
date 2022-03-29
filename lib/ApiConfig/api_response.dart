
class ApiResponse<T> {
  T? response;
  bool? responseError;
  String? errorMessage;
  int? responseCode;
  bool? isWorking;

  ApiResponse({this.response,this.errorMessage,this.responseError,this.responseCode,this.isWorking});
}