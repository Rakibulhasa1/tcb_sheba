
import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));


class UserInfoModel {
  UserInfoModel({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.userInfo,
    this.userAreaInfo,
  });

  UserInfo? userInfo;
  UserAreaInfo? userAreaInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["user_info"]),
    userAreaInfo: UserAreaInfo.fromJson(json["user_area_info"]),
  );

}

class UserAreaInfo {
  UserAreaInfo({
    this.wordId,
    this.wordNameBangla,
    this.wordNameEnglish,
    this.wordCode,
    this.isRoad,
    this.unionId,
    this.unionNameBangla,
    this.unionNameEnglish,
    this.unionCode,
    this.isMunicipality,
    this.upazilaId,
    this.upazilaNameBangla,
    this.upazilanameEnglish,
    this.upazilaCode,
    this.isCityCorporation,
    this.districtId,
    this.districtNameBangla,
    this.districtCode,
    this.isCitycorporation,
    this.divisionId,
    this.divisionName,
    this.countryId,
    this.countryName,
  });

  var wordId;
  var wordNameBangla;
  var wordNameEnglish;
  var wordCode;
  var isRoad;
  var unionId;
  var unionNameBangla;
  var unionNameEnglish;
  var unionCode;
  var isMunicipality;
  var upazilaId;
  var upazilaNameBangla;
  var upazilanameEnglish;
  var upazilaCode;
  var isCityCorporation;
  var districtId;
  var districtNameBangla;
  var districtCode;
  var isCitycorporation;
  var divisionId;
  var divisionName;
  var countryId;
  var countryName;

  factory UserAreaInfo.fromJson(Map<String, dynamic> json) => UserAreaInfo(
    wordId: nullConverter(json["word_id"]),
    wordNameBangla: nullConverter(json["word_name_bangla"]),
    wordNameEnglish: nullConverter(json["word_name_english"]),
    wordCode: nullConverter(json["word_code"]),
    isRoad: nullConverter(json["is_road"]),
    unionId: nullConverter(json["union_id"]),
    unionNameBangla: nullConverter(json["union_name_bangla"]),
    unionNameEnglish: nullConverter(json["union_name_english"]),
    unionCode: nullConverter(json["union_code"]),
    isMunicipality: nullConverter(json["is_municipality"]),
    upazilaId: nullConverter(json["upazila_id"]),
    upazilaNameBangla: nullConverter(json["upazila_name_bangla"]),
    upazilanameEnglish: nullConverter(json["upazilaname_english"]),
    upazilaCode: nullConverter(json["upazila_code"]),
    isCityCorporation: nullConverter(json["is_city_corporation"]),
    districtId: nullConverter(json["district_id"]),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    districtCode: nullConverter(json["district_code"]),
    isCitycorporation: nullConverter(json["is_citycorporation"]),
    divisionId: nullConverter(json["division_id"]),
    divisionName: nullConverter(json["division_name"]),
    countryId: nullConverter(json["country_id"]),
    countryName: nullConverter(json["country_name"]),
  );
}

class UserInfo {
  UserInfo({
    this.usersId,
    this.beneficiaryId,
    this.dealerId,
    this.distributorId,
    this.councilorGenderStatus,
    this.userAreaType,
    this.userFullName,
    this.userMobile,
    this.userImage,
    this.roleId,
    this.userName,
    this.email,
    this.cityAreaId,
    this.generatedCode,
    this.generatedCodeDateTime,
    this.isActive,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  var usersId;
  var beneficiaryId;
  var dealerId;
  var distributorId;
  var councilorGenderStatus;
  var userAreaType;
  var userFullName;
  var userMobile;
  var userImage;
  var roleId;
  var userName;
  var email;
  var cityAreaId;
  var generatedCode;
  var generatedCodeDateTime;
  var isActive;
  var createdAt;
  var createdBy;
  var updatedAt;
  var updatedBy;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    usersId: nullConverter(json["users_id"]),
    beneficiaryId: nullConverter(json["beneficiary_id"]),
    dealerId: nullConverter(json["dealer_id"]),
    distributorId: nullConverter(json["distributor_id"]),
    councilorGenderStatus: nullConverter(json["councilor_gender_status"]),
    userAreaType: nullConverter(json["user_area_type"]),
    userFullName: nullConverter(json["user_full_name"]),
    userMobile: nullConverter(json["user_mobile"]),
    userImage: nullConverter(json["user_image"]),
    roleId: nullConverter(json["role_id"]),
    userName: nullConverter(json["user_name"]),
    email: nullConverter(json["email"]),
    cityAreaId: nullConverter(json["city_area_id"]),
    generatedCode: nullConverter(json["generated_code"]),
    generatedCodeDateTime: nullConverter(json["generated_code_date_time"]),
    isActive: nullConverter(json["is_active"]),
    createdAt: nullConverter(json["created_at"]),
    createdBy: nullConverter(json["created_by"]),
    updatedAt: nullConverter(json["updated_at"]),
    updatedBy: nullConverter(json["updated_by"]),
  );
}
