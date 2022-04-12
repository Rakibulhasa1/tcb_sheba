import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/QrScan/UserInformationModel.dart';

class GetBeneficeryController extends ChangeNotifier{

  BenificiaryInfo? myUserInfo;
  ApiResponse getUserDataResponse = ApiResponse(isWorking: true);

  void getData(){

    var body = {
      'nid_number' : '-${GetStorage().read('user_nid')}',
    };
    ApiController().postRequest(endPoint: ApiEndPoints().qrCodeSearch,token: GetStorage().read('b_token'),body: body).then((value){
      print(value.responseCode);
      if(value.responseCode==200){
        try{
          UserInformationModel usersData = userInformationModelFromJson(value.response.toString());
          if(usersData.status!='Token is Expired'){
            myUserInfo = usersData.member!.benificiaryInfo;
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