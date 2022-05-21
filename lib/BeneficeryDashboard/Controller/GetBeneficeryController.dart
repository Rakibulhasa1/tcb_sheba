import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/QrScan/InformationForReceiveProduct.dart';
import 'package:tcb/QrScan/UserInformationModel.dart';

class GetBeneficeryController extends ChangeNotifier{

  BenificiaryInfo? myUserInfo;
  UserInformationModel? usersData;
  InformationForReceiveProduct? informationForReceiver;
  ApiResponse getUserDataResponse = ApiResponse(isWorking: true);

  void getData(String userNid,String token){

    var body = {
      'nid_number' : userNid,
    };
    ApiController().postRequest(endPoint: ApiEndPoints().qrCodeSearch,token: token,body: body).then((value){
      print(value.responseCode);
      print(value.response);
      if(value.responseCode==200){
        try{
          usersData = userInformationModelFromJson(value.response.toString());
          if(usersData!.status!='Token is Expired'){
            myUserInfo = usersData!.member!.benificiaryInfo;
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

        try{
          informationForReceiver = informationForReceiveProductFromJson(value.response.toString());
        }catch(e){

        }
        notifyListeners();
      }else{
        getUserDataResponse = ApiResponse(isWorking: false,responseError: true,errorMessage: 'error',);
        notifyListeners();
      }
    });
  }
}