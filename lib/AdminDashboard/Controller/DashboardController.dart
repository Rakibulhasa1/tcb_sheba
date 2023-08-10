// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:tcb/AdminDashboard/Model/area_data_query_model.dart';
import 'package:tcb/AdminDashboard/Model/district_list_model.dart';
import 'package:tcb/AdminDashboard/Model/division_data_query_model.dart';
import 'package:tcb/AdminDashboard/Model/division_list_model.dart';
import 'package:tcb/AdminDashboard/Model/step_list_model.dart';
import 'package:tcb/AdminDashboard/Model/union_list_model.dart';
import 'package:tcb/AdminDashboard/Model/upazila_list_model.dart';
import 'package:tcb/AdminDashboard/Model/word_list_model.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Model/DashboardModel.dart';

class DashboardController extends ChangeNotifier{

  DashboardData? data;
  List<AreaModel> districtAreaList = [];
  List<AreaModel> cityCorpAreaList = [];
  List<AreaModel> powrosobaAreaList = [];
  List<AreaModel> upazilaAreaList = [];
  List<AreaModel> unionAreaList = [];
  List<AreaModel> wordAreaList = [];



  List<AreaWiseData>? divisionListAndQty = [];
  List<PieChartInfo> pieChartDataList = [];
  ApiResponse notifyDashboardData = ApiResponse(isWorking: true,);



  ApiResponse notifyAreaDistrictData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaUpazilaData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaUnionData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaWordData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaCityCorp = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaPowrosoba = ApiResponse(isWorking: true,);



  ApiResponse notifyDropDown = ApiResponse(isWorking: true,);
  List<StepModel> stepModel = [];

  void getStepData(){
    ApiController().postRequest(endPoint: ApiEndPoints().stepList).then((value) {
      if(value.responseCode==200){
        try{
          StepListModel stepListModel = stepListModelFromJson(value.response.toString());
          stepModel = stepListModel.data!;
          notifyDropDown = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyDropDown = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        notifyDropDown = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getDashboardData({String? prams}){
    ApiController().postRequest( endPoint: '${ApiEndPoints().dashboard}${prams}').then((value) {
      if(value.responseCode==200){
        try{
          DashboardModel dashboardModel = dashboardModelFromJson(value.response.toString());
          data = dashboardModel.data;
          divisionListAndQty = dashboardModel.data!.divisionWiseQty;
          pieChartDataList = dashboardModel.data!.pieChartInfo!;
          notifyDashboardData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyDashboardData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        notifyDashboardData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  ///.......................................

  void getDistrictArea({String? addressType, String? divisionId}){


    var body = {
      if(divisionId!=null)
        "division_id" : divisionId,
    };

    ApiController().postRequest( endPoint: ApiEndPoints().getAreaData,body: body).then((value) {

      print(value.response);

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          districtAreaList = area.areaList!;
          notifyAreaDistrictData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyAreaDistrictData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      } else{
        notifyAreaDistrictData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });

  }

  void getCityCorpArea({String? addressType,String? districtId}){

    var body = {
      "district_id" : districtId,
    };

    ApiController().postRequest( endPoint: ApiEndPoints().getAreaData,body: body).then((value) {

      print(value.response);

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          cityCorpAreaList = area.areaList!;
          notifyAreaCityCorp = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyAreaCityCorp = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      } else{
        notifyAreaCityCorp = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getUpazilaArea({String? addressType,String? districtId}){
    var body = {
      "district_id" : districtId,
    };

    ApiController().postRequest(endPoint: ApiEndPoints().getAreaData,body: body).then((value) {

      print(value.response);

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          upazilaAreaList = area.areaList!;
          notifyAreaUpazilaData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyAreaUpazilaData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      } else{
        notifyAreaUpazilaData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getPowrosobaArea({String? addressType,String? upazilaId}){
    var body = {
      "upazila_id" : upazilaId,
    };

    ApiController().postRequest( endPoint: ApiEndPoints().getAreaData,body: body).then((value) {

      print(value.response);

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          powrosobaAreaList = area.areaList!;
          notifyAreaPowrosoba = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyAreaPowrosoba = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      } else{
        notifyAreaPowrosoba = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getUnionArea({String? addressType,String? upazilaId}){
    var body = {
      "upazila_id" : upazilaId,
    };

    ApiController().postRequest(endPoint: ApiEndPoints().getAreaData,body: body).then((value) {

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          unionAreaList = area.areaList!;
          notifyAreaUnionData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
          print(unionAreaList.length);
        }
        catch(e){
          notifyAreaUnionData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      } else{
        notifyAreaUnionData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getWordArea({String? addressType,String? unionId}){
    var body = {
      "union_id" : unionId,
    };
    ApiController().postRequest(endPoint: ApiEndPoints().getAreaData,body: body).then((value) {

      print(value.response);

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          wordAreaList = area.areaList!;
          notifyAreaWordData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyAreaWordData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      } else{
        notifyAreaWordData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });

  }


}