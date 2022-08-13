import 'package:flutter/cupertino.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/Model/MasterApiModel.dart';

class MasterApiController extends ChangeNotifier{

  MasterData? masterData;

  void getMasterData(){
    ApiController().getMasterResponse(endPoint: 'master-info').then((value) {
      MasterApiModel data = masterApiModelFromJson(value.response.toString());
      masterData = data.masterData;
      notifyListeners();
    });
  }

}