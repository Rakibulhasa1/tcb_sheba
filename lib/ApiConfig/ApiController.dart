
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/BeneficeryDashboard/Model/user_update_data_model.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/show_toast.dart';


class ApiController{

  Future<ApiResponse<dynamic>> loginResponse({required String endPoint,required Map<String,dynamic> body})async{

    final String url = ApiEndPoints().baseUrl+endPoint;



    try{
      return await http.post(Uri.parse(url),body: body).then((value){
        log("$url ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
        }
      });
    }catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
    }
  }

  Future<ApiResponse<dynamic>> getResponse({required String endPoint})async{

    final String url = ApiEndPoints().baseUrl+endPoint;
    String token = GetStorage().read('token')??"";
    var header ={
      'Accept': 'application/json',
      'Authorization': token,
    };

    try{
      return await http.get(Uri.parse(url),headers: header).then((value){
        log("$url ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          printf(e);
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
        }
      });
    }catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
    }
  }

  Future<ApiResponse<dynamic>> getMasterResponse({required String endPoint})async{

    final String url = ApiEndPoints().baseUrl+endPoint;
    final header ={
      'Accept': 'application/json',
    };

    try{
      return await http.get(Uri.parse(url),headers: header).then((value){
        log("$url ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          printf(e);
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
        }
      });
    }catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
    }
  }

  Future<ApiResponse<dynamic>> postRequest({required String endPoint,body})async{

    final String url = ApiEndPoints().baseUrl+endPoint;
    String token = GetStorage().read('token')??"";
    final header ={
      'Authorization': token,
    };
    try{
      return await http.post(Uri.parse(url),headers: header,body: body).then((value){
        log("$url ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
        }
      });
    }
    catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
    }
  }

  Future<ApiResponse<dynamic>> deleteRequest({required String endPoint,Map<String, dynamic>? body})async{

    final String url = ApiEndPoints().baseUrl+endPoint;

    String token = GetStorage().read('token')??"";

    final header ={
      'Accept': 'application/json',
      'Authorization': token
    };
    try{
      return await http.delete(Uri.parse(url),headers: header,body: body).then((value){
        log("$url ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
        }
      });
    }catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
    }
  }

  Future<ApiResponse<dynamic>> editRequest({required String endPoint,Map<String, dynamic>? body})async{

    final String url = ApiEndPoints().baseUrl+endPoint;
    String token = GetStorage().read('token')??"";
    final header ={
      'Accept': 'application/json',
      'Authorization': token
    };
    try{
      return await http.put(Uri.parse(url),headers: header,body: body).then((value){
        log("$url ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
        }
      });
    }
    catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection',responseCode: 500);
    }

  }



  Future<ApiResponse<String>> updateUserNid({required UserUpdateDataModel dataModel,required String endPoint}) async {


    final String url = ApiEndPoints().baseUrl+endPoint;
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    var streamBackImage = http.ByteStream(DelegatingStream.typed(dataModel.fontNid.openRead()));
    var lengthBack = await dataModel.fontNid.length();


    var multipartFile = http.MultipartFile(
      'beneficiary_image_file', streamBackImage, lengthBack, filename: basename(dataModel.fontNid.path),
    );

    request.files.add(multipartFile);

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': GetStorage().read('b_token'),
    });

    request.fields.addAll({
      'beneficiary_id': dataModel.beneficeryId,
    });

    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    if(response.statusCode==200){
      return ApiResponse<String>(response: "success",responseCode: response.statusCode,errorMessage: "Something wrong\nPlease try again", responseError: true,);
    }else{
      return ApiResponse<String>(errorMessage: "Something wrong\nPlease try again", responseError: true,responseCode: 500);
    }
  }

  Future<ApiResponse<String>> userRegistration({required RegistrationBeneficeryModel dataModel,required String endPoint,required Map<String,String> body}) async {


    final String url = ApiEndPoints().baseUrl+endPoint;
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);


    var userImage = http.ByteStream(DelegatingStream.typed(dataModel.profileImage.openRead()));
    var userImageLength = await dataModel.profileImage.length();

    var nidFont = http.ByteStream(DelegatingStream.typed(dataModel.nidImage.openRead()));
    var nidFontLength = await dataModel.nidImage.length();

    var nidBack = http.ByteStream(DelegatingStream.typed(dataModel.nid2Image.openRead()));
    var nidBackLength = await dataModel.nid2Image.length();


    var userImgMulti = http.MultipartFile(
      'user_image', userImage, userImageLength, filename: basename(dataModel.profileImage.path),
    );

    var userFontMulti = http.MultipartFile(
      'nid_font_part', nidFont, nidFontLength, filename: basename(dataModel.nidImage.path),
    );

    var userBackMulti = http.MultipartFile(
      'nid_back_part', nidBack, nidBackLength, filename: basename(dataModel.nid2Image.path),
    );

    request.files.addAll({
      userBackMulti,
      userFontMulti,
      userImgMulti,
    });

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': GetStorage().read('token')??"",
    });

    request.fields.addAll(body);

    var response = await request.send();
    var responseData;
    response.stream.transform(utf8.decoder).listen((event) {
      var response = json.decode(event.toString());
      ShowToast.myToast(response['data'], Colors.black, 2);
    });

    if(response.statusCode==200){
      return ApiResponse<String>(response: responseData.toString(),responseCode: response.statusCode,errorMessage: "Something wrong\nPlease try again", responseError: false);
    }else{
      return ApiResponse<String>(response: responseData.toString(),responseCode: response.statusCode,errorMessage: "Something wrong\nPlease try again", responseError: true,);
    }
  }


  Future<ApiResponse<String>> updateUserProfile({required File imageFile,required String userId,required String endPoint}) async {


    final String url = ApiEndPoints().baseUrl+endPoint;
    var uri = Uri.parse(url);
    printf("$uri");
    var request = http.MultipartRequest("POST", uri);

    var streamBackImage = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var lengthBack = await imageFile.length();


    var multipartFile = http.MultipartFile(
      'beneficiary_image_file', streamBackImage, lengthBack, filename: basename(imageFile.path),
    );

    request.files.add(multipartFile);

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': GetStorage().read('token')??"",
    });

    request.fields.addAll({
      'beneficiary_id': userId,
    });

    var response = await request.send();
    printf(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      printf(value);
    });

    if(response.statusCode==200){
      return ApiResponse<String>(response: "success",responseCode: response.statusCode,errorMessage: "Something wrong\nPlease try again", responseError: true);
    }else{
      return ApiResponse<String>(errorMessage: "Something wrong\nPlease try again", responseError: true,responseCode: 500);
    }
  }


  dynamic responseDataPrepare({required http.Response value}){
    switch(value.statusCode){
      case 200 :
        return ApiResponse(response: value.body,responseError: false, responseCode: value.statusCode);

      case 405 :
        return ApiResponse(response: value.body,responseError: false, responseCode: value.statusCode);

      case 404 :
        return ApiResponse(response: value.body,responseError: true,errorMessage: 'Data Not Found', responseCode: value.statusCode);

      case 500 :
        return ApiResponse(responseError: true,errorMessage: 'Server Error', responseCode: value.statusCode);

      case 403 :
        return ApiResponse(responseError: true,errorMessage: '403 Forbidden', responseCode: value.statusCode);

      case 503 :
        return ApiResponse(responseError: true,errorMessage: 'Service Unavailable', responseCode: value.statusCode);

      case 504 :
        return ApiResponse(responseError: true,errorMessage: 'Gateway Timeout', responseCode: value.statusCode);

      case 401 :
        return ApiResponse(responseError: true,errorMessage: 'Unauthorized', responseCode: value.statusCode);

      default:
        return ApiResponse(responseError: true,errorMessage: 'Unknown Error',responseCode: value.statusCode);
    }
  }

}


