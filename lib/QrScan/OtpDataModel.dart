// To parse this JSON data, do
//
//     final otpDataModel = otpDataModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

OtpDataModel otpDataModelFromJson(String str) => OtpDataModel.fromJson(json.decode(str));


class OtpDataModel {
  OtpDataModel({
    this.status,
    this.data,
  });

  var status;
  var data;

  factory OtpDataModel.fromJson(Map<String, dynamic> json) => OtpDataModel(
    status: nullConverter(json["status"]),
    data: nullConverter(json["data"]),
  );
}
