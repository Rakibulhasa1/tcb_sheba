import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/Model/DealerDetailsModel.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';

class DealerInfoController extends ChangeNotifier{

  DealerInfoModels? dealerInfoModels;
  ApiResponse apiResponse = ApiResponse(isWorking: true);


  void getDealerData(){
    ApiController().postRequest(endPoint: ApiEndPoints().dealerData,token: GetStorage().read('token')).then((value) {
      if(value.responseCode==200){
        try{
          DealerDetailsModel dealerDetailsModel = dealerDetailsModelFromJson(value.response.toString());
          dealerInfoModels = dealerDetailsModel.data;
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }catch(e){
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
      }else{
        apiResponse = ApiResponse(
          isWorking: false,
          responseError: true,
        );
      }
    });
    notifyListeners();
  }

}