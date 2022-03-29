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



  List<DistrictName> disName=[];
  List<UpazilaModel> upaName = [];
  List<UnionModel> unionName = [];
  List<WordModel> wordName = [];


  List<DivisionWiseQty>? divisionListAndQty = [];
  List<PieChartInfo> pieChartDataList = [];


  ApiResponse notifyDashboardData = ApiResponse(isWorking: true,);

  ApiResponse notifyDistrictData = ApiResponse(isWorking: true,);
  ApiResponse notifyUpazilaData = ApiResponse(isWorking: true,);
  ApiResponse notifyUnionData = ApiResponse(isWorking: true,);
  ApiResponse notifyWordData = ApiResponse(isWorking: true,);


  ApiResponse notifyAreaDistrictData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaUpazilaData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaUnionData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaWordData = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaCityCorp = ApiResponse(isWorking: true,);
  ApiResponse notifyAreaPowrosoba = ApiResponse(isWorking: true,);



  ApiResponse notifyDropDown = ApiResponse(isWorking: true,);
  List<StepModel> stepModel = [];

  void getStepData(){
    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().stepList).then((value) {
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
    ApiController().postRequest(token: GetStorage().read('token'), endPoint: '${ApiEndPoints().dashboard}${prams}').then((value) {
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

    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().pieChart,body: body).then((value) {

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
      "address_type" : addressType,
    };

    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().pieChart,body: body).then((value) {

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
      "address_type" : addressType,
    };

    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().pieChart,body: body).then((value) {

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
      "address_type" : addressType,
    };

    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().pieChart,body: body).then((value) {

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
      "address_type" : addressType,
    };

    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().pieChart,body: body).then((value) {

      print(value.response);

      if(value.responseCode==200){
        try{
          AreaDataQueryModel area = areaDataQueryModelFromJson(value.response.toString());
          unionAreaList = area.areaList!;
          notifyAreaUnionData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
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
      "address_type" : addressType,
    };
    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().pieChart,body: body).then((value) {

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


  /// ....................................

  void getDistrict(String divId,String? uploadType){
    var body = {
      "division_id" : divId,
      if(uploadType!=null)
        "address_type" : uploadType,
    };
    ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().districtList,body: body).then((value) {

      if(value.responseCode==200){
        DistrictListModel districtListModel = districtListModelFromJson(value.response.toString());
        disName = districtListModel.data!;
        notifyDistrictData = ApiResponse(
          isWorking: false,
          responseError: false,
        );
        try{
          DistrictListModel districtListModel = districtListModelFromJson(value.response.toString());
          disName = districtListModel.data!;
          notifyDistrictData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyDistrictData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        notifyDistrictData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getUapzila({required String districtId,required String addressType}){
    var body = {
      'district_id' : districtId,
      'address_type' :  addressType,
    };
    ApiController().postRequest(body: body,token: GetStorage().read('token'), endPoint: ApiEndPoints().upazilaList,).then((value) {
      if(value.responseCode==200){
        try{
          UpazilaListModel upazila = upazilaListModelFromJson(value.response.toString());
          upaName = upazila.data!;
          notifyUpazilaData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyUpazilaData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        notifyUpazilaData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getUnion({required String upazilaId,String? addressType}){

    var body = {
      'upazila_id' : upazilaId,
      if(addressType!=null)
        'address_type' : addressType,
    };
    ApiController().postRequest(body: body,token: GetStorage().read('token'), endPoint: ApiEndPoints().unionList,).then((value) {
      if(value.responseCode==200){
        try{
          UnionListModel myUnion = unionListModelFromJson(value.response.toString());
          unionName = myUnion.union!;
          notifyUnionData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyUnionData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        notifyUnionData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

  void getWord({required String unionId,String? addressType}){
    var body = {
      'union_id' : unionId,
      if(addressType!=null)
        'address_type' : addressType,
    };
    ApiController().postRequest(body: body,token: GetStorage().read('token'), endPoint: ApiEndPoints().wordList,).then((value) {
      if(value.responseCode==200){
        try{
          WordListModel myWord = wordListModelFromJson(value.response.toString());
          wordName = myWord.data!;
          notifyWordData = ApiResponse(
            isWorking: false,
            responseError: false,
          );
        }
        catch(e){
          notifyWordData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
        notifyListeners();
      }else{
        notifyWordData = ApiResponse(
          isWorking: false,
          responseError: true,
        );
        notifyListeners();
      }
    });
  }

}