import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';

class DataResponse{

  void getAdminData({required BuildContext context,required prams}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getDashboardData(prams: prams);
    });
  }

  void getStepData({required BuildContext context}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getStepData();
    });
  }





  void getDistrictArea({required BuildContext context,String? addressType,String? divisionId}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getDistrictArea(addressType: addressType,divisionId: divisionId);
    });
  }

  void getUpazilaArea({required BuildContext context,String? addressType,String? districtId}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getUpazilaArea(addressType: addressType,districtId: districtId);
    });
  }

  void getCityCorpArea({required BuildContext context,String? addressType,String? districtId}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getCityCorpArea(addressType: addressType,districtId: districtId);
    });
  }


  void getUnionArea({required BuildContext context,String? addressType,String? upazilaId}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getUnionArea(addressType: addressType,upazilaId: upazilaId);
    });
  }

  void getPowrosobaArea({required BuildContext context,String? addressType,String? upazilaId}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getPowrosobaArea(addressType: addressType,upazilaId: upazilaId);
    });
  }

  void getWordArea({required BuildContext context,required String unionId,required String addressType}){
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getWordArea(unionId: unionId,addressType: addressType);
    });
  }

}