// To parse this JSON data, do
//
//     final informationForReceiveProduct = informationForReceiveProductFromJson(jsonString);

// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

InformationForReceiveProduct informationForReceiveProductFromJson(String str) => InformationForReceiveProduct.fromJson(json.decode(str));

class InformationForReceiveProduct {
  InformationForReceiveProduct({
    this.status,
    this.member,
  });

  var status;
  Member? member;

  factory InformationForReceiveProduct.fromJson(Map<String, dynamic> json) => InformationForReceiveProduct(
    status: nullConverter(json["status"]),
    member: Member.fromJson(json["member"]),
  );
}

class Member {
  Member({
    this.assignInfo,
    this.beneficiaryReceiveInfo,
    this.packageDetailsInfo,
    this.dealerDetailsInfo,
  });

  AssignInfo? assignInfo;
  BeneficiaryReceiveInfo? beneficiaryReceiveInfo;
  List<PackageDetailsInfo>? packageDetailsInfo;
  List<DealerDetailsInfo>? dealerDetailsInfo;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    assignInfo: AssignInfo.fromJson(json["assign_info"]),
    beneficiaryReceiveInfo: BeneficiaryReceiveInfo.fromJson(json["beneficiary_receive_info"]),
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


class BeneficiaryReceiveInfo {
  BeneficiaryReceiveInfo({
    this.receiverRecordId,
    this.beneficiaryId,
    this.stepId,
    this.receivedDate,
    this.assignId,
    this.packageId,
    this.otpCode,
    this.latitude,
    this.longitude,
  });

  var receiverRecordId;
  var beneficiaryId;
  var stepId;
  var receivedDate;
  var assignId;
  var packageId;
  var otpCode;
  var latitude;
  var longitude;

  factory BeneficiaryReceiveInfo.fromJson(Map<String, dynamic> json) => BeneficiaryReceiveInfo(
    receiverRecordId: nullConverter(json["receiver_record_id"]),
    beneficiaryId: nullConverter(json["beneficiary_id"]),
    stepId: nullConverter(json["step_id"]),
    receivedDate: nullConverter(json["received_date"]),
    assignId: nullConverter(json["assign_id"]),
    packageId: nullConverter(json["package_id"]),
    otpCode: nullConverter(json["otp_code"]),
    latitude: nullConverter(json["latitude"]),
    longitude: nullConverter(json["longitude"]),
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
    this.productIsActive,
    this.productUnit,
    this.productName,
    this.productQty,
  });

  var productQty;
  var productIsActive;
  var productName;
  var productUnit;

  factory PackageDetailsInfo.fromJson(Map<String, dynamic> json) => PackageDetailsInfo(
    productQty: nullConverter(json["product_qty"]),
    productIsActive: nullConverter(json["product_is_active"]),
    productUnit: nullConverter(json["product_unit"]),
    productName: nullConverter(json["product_name"]),
  );
}
