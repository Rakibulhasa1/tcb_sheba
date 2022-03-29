// To parse this JSON data, do
//
//     final districtListModel = districtListModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

DistrictListModel districtListModelFromJson(String str) => DistrictListModel.fromJson(json.decode(str));

class DistrictListModel {
  DistrictListModel({
    this.status,
    this.data,
  });

  var status;
  List<DistrictName>? data;

  factory DistrictListModel.fromJson(Map<String, dynamic> json) => DistrictListModel(
    status: nullConverter(json["status"]),
    data: List<DistrictName>.from(json["data"].map((x) => DistrictName.fromJson(x))),
  );

}

class DistrictName {
  DistrictName({
    this.districtId,
    this.divisionId,
    this.districtNameBangla,
    this.districtNameEngish,
    this.districtOfficeName,
    this.districtCode,
  });

  var districtId;
  var divisionId;
  var districtNameBangla;
  var districtNameEngish;
  var districtOfficeName;
  var districtCode;

  factory DistrictName.fromJson(Map<String, dynamic> json) => DistrictName(
    districtId: nullConverter(json["district_id"]),
    divisionId: nullConverter(json['division_id']),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    districtNameEngish: nullConverter(json["district_name_engish"]),
    districtOfficeName: nullConverter(json["district_office_name"]),
    districtCode: nullConverter(json["district_code"]),
  );
}
