// To parse this JSON data, do
//
//     final divisionListModel = divisionListModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

DivisionListModel divisionListModelFromJson(String str) => DivisionListModel.fromJson(json.decode(str));

class DivisionListModel {
  DivisionListModel({
    this.status,
    this.data,
  });

  var status;
  List<DivisionName>? data;

  factory DivisionListModel.fromJson(Map<String, dynamic> json) => DivisionListModel(
    status: nullConverter(json["status"]),
    data: List<DivisionName>.from(json["data"].map((x) => DivisionName.fromJson(x))),
  );
}

class DivisionName {
  DivisionName({
    this.divisionId,
    this.countryId,
    this.divisionName,
    this.divisionCode,
  });

  var divisionId;
  var countryId;
  var divisionName;
  var divisionCode;

  factory DivisionName.fromJson(Map<String, dynamic> json) => DivisionName(
    divisionId: nullConverter(json["division_id"]),
    countryId: nullConverter(json["country_id"]),
    divisionName: nullConverter(json["division_name"]),
    divisionCode: nullConverter(json["division_code"]),
  );
}
