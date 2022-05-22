// To parse this JSON data, do
//
//     final informationForChanceReceive = informationForChanceReceiveFromJson(jsonString);

// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

InformationForChanceReceive informationForChanceReceiveFromJson(String str) => InformationForChanceReceive.fromJson(json.decode(str));

class InformationForChanceReceive {
  InformationForChanceReceive({
    this.status,
    this.member,
  });

  var status;
  Member? member;

  factory InformationForChanceReceive.fromJson(Map<String, dynamic> json) => InformationForChanceReceive(
    status: nullConverter(json["status"]),
    member: Member.fromJson(json["member"]),
  );

}

class Member {
  Member({
    this.assignInfo,
    this.packageDetailsInfo,
    this.dealerDetailsInfo,
  });

  AssignInfo? assignInfo;
  List<PackageDetailsInfo>? packageDetailsInfo;
  List<DealerDetailsInfo>? dealerDetailsInfo;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    assignInfo: AssignInfo.fromJson(json["assign_info"]),
    packageDetailsInfo: List<PackageDetailsInfo>.from(json["package_details_info"].map((x) => PackageDetailsInfo.fromJson(x))),
    dealerDetailsInfo: List<DealerDetailsInfo>.from(json["dealer_details_info"].map((x) => DealerDetailsInfo.fromJson(x))),
  );
}

class AssignInfo {
  AssignInfo({
    this.assignId,
    this.assignDate,
    this.distributionPlace,
    this.packageId,
    this.dealerId,
    this.stepId,
    this.stepName,
    this.packageName,
    this.dealerLicenceNo,
    this.dealerName,
    this.dealerMobile,
    this.dealerOrgName,
    this.dealerAddress,
    this.dealerEmail,
  });

  var assignId;
  var assignDate;
  var packageId;
  var distributionPlace;
  var dealerId;
  var stepId;
  var stepName;
  var packageName;
  var dealerLicenceNo;
  var dealerName;
  var dealerMobile;
  var dealerOrgName;
  var dealerAddress;
  var dealerEmail;

  factory AssignInfo.fromJson(Map<String, dynamic> json) => AssignInfo(
    assignId: nullConverter(json["assign_id"]),
    assignDate: nullConverter(json["assign_date"]),
    packageId: nullConverter(json["package_id"]),
    distributionPlace: nullConverter(json["distribution_place"]),
    dealerId: nullConverter(json["dealer_id"]),
    stepId: nullConverter(json["step_id"]),
    stepName: nullConverter(json["step_name"]),
    packageName: nullConverter(json["package_name"]),
    dealerLicenceNo: nullConverter(json["dealer_licence_no"]),
    dealerName: nullConverter(json["dealer_name"]),
    dealerMobile: nullConverter(json["dealer_mobile"]),
    dealerOrgName: nullConverter(json["dealer_org_name"]),
    dealerAddress: nullConverter(json["dealer_address"]),
    dealerEmail: nullConverter(json["dealer_email"]),
  );
}

class DealerDetailsInfo{
  DealerDetailsInfo({
    this.trackSellNumber,
    this.destributorName,
    this.destributorMobile,
  });

  var trackSellNumber;
  var destributorName;
  var destributorMobile;

  factory DealerDetailsInfo.fromJson(Map<String, dynamic> json) => DealerDetailsInfo(
    trackSellNumber: nullConverter(json["track_sell_number"]),
    destributorName: nullConverter(json["destributor_name"]),
    destributorMobile: nullConverter(json["destributor_mobile"]),
  );
}

class PackageDetailsInfo {
  PackageDetailsInfo({
    this.productQry,
    this.productIsActive,
    this.productUnit,
    this.productName,
  });

  var productQry;
  var productIsActive;
  var productName;
  var productUnit;

  factory PackageDetailsInfo.fromJson(Map<String, dynamic> json) => PackageDetailsInfo(
    productQry: nullConverter(json["product_qty"]),
    productIsActive: nullConverter(json["product_is_active"]),
    productUnit: nullConverter(json["product_unit"]),
    productName: nullConverter(json["product_name"]),
  );
}
