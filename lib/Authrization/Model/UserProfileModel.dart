
// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));


class UserProfileModel {
  UserProfileModel({
    this.status,
    this.data,
    this.token,
  });

  String? status;
  Data? data;
  String? token;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
  );
}

class Data {
  Data({
    this.usersId,
    this.dealerId,
    this.distributorId,
    this.userAreaType,
    this.userFullName,
    this.userMobile,
    this.userImage,
    this.userName,
    this.email,
  });

  var usersId;
  var dealerId;
  var distributorId;
  var userAreaType;
  var userFullName;
  var userMobile;
  var userImage;
  var userName;
  var email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersId: nullConverter(json["users_id"]),
    dealerId: nullConverter(json["dealer_id"]),
    distributorId: nullConverter(json["distributor_id"]),
    userAreaType: nullConverter(json["user_area_type"]),
    userFullName: nullConverter(json["user_full_name"]),
    userMobile: nullConverter(json["user_mobile"]),
    userImage: nullConverter(json["user_image"]),
    userName: nullConverter(json["user_name"]),
    email: nullConverter(json["email"]),
  );
}
