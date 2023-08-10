
import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';


DistrictListModel districtListModelFromJson(String str) => DistrictListModel.fromJson(json.decode(str));

class DistrictListModel {
  DistrictListModel({
    this.status,
    this.districtName,
  });

  String? status;
  List<DistrictName>? districtName;

  factory DistrictListModel.fromJson(Map<String, dynamic> json) => DistrictListModel(
    status: json["status"],
    districtName: List<DistrictName>.from(json["data"].map((x) => DistrictName.fromJson(x))),
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
    this.isCitycorporation,
  });

  var districtId;
  var divisionId;
  var districtNameBangla;
  var districtNameEngish;
  var districtOfficeName;
  var districtCode;
  var isCitycorporation;

  factory DistrictName.fromJson(Map<String, dynamic> json) => DistrictName(
    districtId: nullConverter(json["district_id"]),
    divisionId: nullConverter(json["division_id"]),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    districtNameEngish: nullConverter(json["district_name_engish"]),
    districtOfficeName: nullConverter(json["district_office_name"]),
    districtCode: nullConverter(json["district_code"]),
    isCitycorporation: nullConverter(json["is_citycorporation"]),
  );
}
