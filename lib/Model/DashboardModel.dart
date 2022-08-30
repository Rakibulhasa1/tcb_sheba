

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
    this.dealerAssignInfo,
  });

  List<AreaWiseData>? divisionWiseQty;
  List<PieChartInfo>? pieChartInfo;
  var totalBeneficiary;
  var totalReceiver;
  List<DealerAssignInfo>? dealerAssignInfo;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    divisionWiseQty: List<AreaWiseData>.from(json["area_wise_pie_area"].map((x) => AreaWiseData.fromJson(x))),
    pieChartInfo: List<PieChartInfo>.from(json["pie_chart_info"].map((x) => PieChartInfo.fromJson(x))),
    totalBeneficiary: nullConverter(json["total_beneficiary"]),
    totalReceiver: nullConverter(json["total_receiver"]),
    dealerAssignInfo: List<DealerAssignInfo>.from(json["dealer_assign_info"].map((x) => DealerAssignInfo.fromJson(x))),
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

class DealerAssignInfo {
  DealerAssignInfo({
    this.assignId,
    this.assignDate,
    this.distributionPlace,
    this.packageId,
    this.dealerId,
    this.stepId,
    this.assignStatus,
    this.stepName,
    this.packageName,
    this.dealerLicenceNo,
    this.dealerName,
    this.dealerMobile,
    this.dealerOrgName,
    this.dealerAddress,
    this.dealerEmail,
    this.createdAt,
    this.updatedAt,
    this.unionNameBangla,
    this.upazilaNameBangla,
    this.assignUnionName,
    this.assignUpazilaName,
  });

  var assignId;
  var assignDate;
  var distributionPlace;
  var packageId;
  var dealerId;
  var stepId;
  var assignStatus;
  var stepName;
  var packageName;
  var dealerLicenceNo;
  var dealerName;
  var dealerMobile;
  var dealerOrgName;
  var dealerAddress;
  var dealerEmail;
  var createdAt;
  var updatedAt;
  var unionNameBangla;
  var upazilaNameBangla;
  var assignUnionName;
  var assignUpazilaName;

  factory DealerAssignInfo.fromJson(Map<String, dynamic> json) => DealerAssignInfo(
    assignId: json["assign_id"],
    assignDate: json["assign_date"],
    distributionPlace: json["distribution_place"],
    packageId: json["package_id"],
    dealerId: json["dealer_id"],
    stepId: json["step_id"],
    assignStatus: json["assign_status"],
    stepName: json["step_name"],
    packageName: json["package_name"],
    dealerLicenceNo: json["dealer_licence_no"],
    dealerName: json["dealer_name"],
    dealerMobile: json["dealer_mobile"],
    dealerOrgName: json["dealer_org_name"],
    dealerAddress: json["dealer_address"],
    dealerEmail: json["dealer_email"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    unionNameBangla: json["union_name_bangla"],
    upazilaNameBangla: json["upazila_name_bangla"],
    assignUnionName: json["assign_union_name"],
    assignUpazilaName: json["assign_upazila_name"],
  );

}


