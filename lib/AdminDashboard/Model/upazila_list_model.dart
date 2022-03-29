// To parse this JSON data, do
//
//     final upazilaListModel = upazilaListModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

UpazilaListModel upazilaListModelFromJson(String str) => UpazilaListModel.fromJson(json.decode(str));

class UpazilaListModel {
  UpazilaListModel({
    this.status,
    this.data,
  });

  var status;
  List<UpazilaModel>? data;

  factory UpazilaListModel.fromJson(Map<String, dynamic> json) => UpazilaListModel(
    status: nullConverter(json["status"]),
    data: List<UpazilaModel>.from(json["data"].map((x) => UpazilaModel.fromJson(x))),
  );
}

class UpazilaModel {
  UpazilaModel({
    this.upazilaId,
    this.districtId,
    this.upazilaCode,
    this.upazilaNameBangla,
    this.upazilanameEnglish,
  });

  var upazilaId;
  var districtId;
  var upazilaCode;
  var upazilaNameBangla;
  var upazilanameEnglish;

  factory UpazilaModel.fromJson(Map<String, dynamic> json) => UpazilaModel(
    upazilaId: nullConverter(json["upazila_id"]),
    districtId: nullConverter(json["district_id"]),
    upazilaCode: nullConverter(json["upazila_code"]),
    upazilaNameBangla: nullConverter(json["upazila_name_bangla"]),
    upazilanameEnglish: nullConverter(json["upazilaname_english"]),
  );
}
