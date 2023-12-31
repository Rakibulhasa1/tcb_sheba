// To parse this JSON data, do
//
//     final areaDataQueryModel = areaDataQueryModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

AreaDataQueryModel areaDataQueryModelFromJson(String str) => AreaDataQueryModel.fromJson(json.decode(str));

class AreaDataQueryModel {
  AreaDataQueryModel({
    this.status,
    this.areaList,
  });

  var status;
  List<AreaModel>? areaList;

  factory AreaDataQueryModel.fromJson(Map<String, dynamic> json) => AreaDataQueryModel(
    status: nullConverter(json["status"]),
    areaList: List<AreaModel>.from(json["data"].map((x) => AreaModel.fromJson(x))),
  );
}

class AreaModel {
  AreaModel({
    this.areaType,
    this.areaId,
    this.areaName,
    this.beneficiaryTotalQty,
    this.receiverTotalQty,
  });

  var areaType;
  var areaId;
  var areaName;
  var beneficiaryTotalQty;
  var receiverTotalQty;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    areaType: nullConverter(json["area_type"]),
    areaId: nullConverter(json["area_id"]),
    areaName: nullConverter(json["area_name"]),
    beneficiaryTotalQty: nullConverter(json["beneficiary_total_qty"]),
    receiverTotalQty: nullConverter(json["receiver_total_qty"]),
  );
}
