import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tcb/AdminDashboard/Model/BeneficiaryAllInfoModel.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';

class BeneficiaryInfoController extends ChangeNotifier{

  BeneficiaryAllInfoModel? userDataResponse;

  BeneficiaryInfo? userData;
  List<ReceiverInfo> receiverInfo = [];
  List<PackageDetailsInfoArray> packageDetailsInfoArray = [];

  ApiResponse getUserDataResponse = ApiResponse(isWorking: true);

  void getData(String userId,String token,bool isScan){
    getUserDataResponse = ApiResponse(isWorking: true);
    var body = {
      if(isScan)
        'nid_number' : userId,
      if(!isScan)
        'beneficiary_id' : userId,
    };
    log("$body");
    ApiController().postRequest(endPoint: ApiEndPoints().beneficiaryAllInfo,body: body).then((value){
      if(value.responseCode==200){
        try{
          userDataResponse = beneficiaryAllInfoModelFromJson(value.response.toString());
          if(userDataResponse!.status!='Token is Expired'){

            userData  = userDataResponse!.userData!.beneficiaryInfo;
            receiverInfo = userDataResponse!.userData!.receiverInfo!;
            packageDetailsInfoArray = userDataResponse!.userData!.packageDetailsInfoArray!;
            getUserDataResponse = ApiResponse(isWorking: false,responseError: false);
          }else{
            getUserDataResponse = ApiResponse(
              isWorking: false,
              responseError: true,
              errorMessage: 'Token is Expired',
            );
          }
        }catch(e){
          getUserDataResponse = ApiResponse(
            isWorking: false,
            responseError: true,
            errorMessage: 'error',
          );
        }
        notifyListeners();
      }else{
        getUserDataResponse = ApiResponse(isWorking: false,responseError: true,errorMessage: 'error',);
        notifyListeners();
      }
    });
  }

}