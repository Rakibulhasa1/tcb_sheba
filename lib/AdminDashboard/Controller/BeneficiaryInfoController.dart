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

  void getData(String userNid,String token){

    var body = {
      'nid_number' : userNid,
    };
    ApiController().postRequest(endPoint: ApiEndPoints().beneficiaryAllInfo,token: token,body: body).then((value){
      print(value.responseCode);
      print(value.response);
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