
// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

class DashboardModel {
  DashboardModel({
    this.status,
    this.data,
  });

  var status;
  DashboardData? data;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    status: nullConverter(json["status"]),
    data: DashboardData.fromJson(json["data"]),
  );
}

class DashboardData {
  DashboardData({
    this.divisionWiseQty,
    this.pieChartInfo,
    this.totalBeneficiary,
    this.totalReceiver,
  });

  List<AreaWiseData>? divisionWiseQty;
  List<PieChartInfo>? pieChartInfo;
  var totalBeneficiary;
  var totalReceiver;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    divisionWiseQty: List<AreaWiseData>.from(json["area_wise_pie_area"].map((x) => AreaWiseData.fromJson(x))),
    pieChartInfo: List<PieChartInfo>.from(json["pie_chart_info"].map((x) => PieChartInfo.fromJson(x))),
    totalBeneficiary: nullConverter(json["total_beneficiary"]),
    totalReceiver: nullConverter(json["total_receiver"]),
  );

}

class AreaWiseData {
  AreaWiseData({
    this.areaType,
    this.areaId,
    this.areaName,
    this.beneficiaryTotalQty,
    this.receiverTotalQty,
  });

  var areaType;
  var areaId;
  var divisionNameFull;
  var areaName;
  int? beneficiaryTotalQty;
  int? receiverTotalQty;

  factory AreaWiseData.fromJson(Map<String, dynamic> json) => AreaWiseData(
    areaType: nullConverter(json["area_type"]),
    areaId: nullConverter(json["area_id"]),
    areaName: nullConverter(json["area_name"]),
    beneficiaryTotalQty: json["beneficiary_total_qty"],
    receiverTotalQty: json["receiver_total_qty"],
  );
}

class PieChartInfo {
  PieChartInfo({
    this.beneficiaryOccupationName,
    this.receiverTotalQty,
  });

  var beneficiaryOccupationName;
  int? receiverTotalQty;

  factory PieChartInfo.fromJson(Map<String, dynamic> json) => PieChartInfo(
    beneficiaryOccupationName: nullConverter(json["beneficiary_occupation_name"]??""),
    receiverTotalQty: json["receiver_total_qty"]??0,
  );
}


