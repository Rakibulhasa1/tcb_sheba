// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Authrization/Model/UserProfileModel.dart';

class LoginDataController extends ChangeNotifier{

  UserProfileModel? userProfileModel;

  ApiResponse apiResponse = ApiResponse(
    isWorking: true,
  );

  void getUserData(UserProfileModel userProfileModel){
    this.userProfileModel = userProfileModel;
    notifyListeners();
  }



  void getResponse(Map<String , dynamic> body){
    ApiController().loginResponse(endPoint: ApiEndPoints().login,body: body).then((value){

      if(value.responseCode==200){
        try{
          userProfileModel = userProfileModelFromJson(value.response.toString());
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        apiResponse = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });

  }

}