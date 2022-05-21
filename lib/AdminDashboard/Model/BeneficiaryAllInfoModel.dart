// To parse this JSON data, do
//
//     final beneficiaryAllInfoModel = beneficiaryAllInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

BeneficiaryAllInfoModel beneficiaryAllInfoModelFromJson(String str) => BeneficiaryAllInfoModel.fromJson(json.decode(str));

class BeneficiaryAllInfoModel {
  BeneficiaryAllInfoModel({
    this.status,
    this.userData,
  });

  String? status;
  UserData? userData;

  factory BeneficiaryAllInfoModel.fromJson(Map<String, dynamic> json) => BeneficiaryAllInfoModel(
    status: json["status"],
    userData: UserData.fromJson(json["data"]),
  );
}

class UserData {
  UserData({
    this.beneficiaryInfo,
    this.receiverInfo,
    this.packageDetailsInfoArray,
  });

  BeneficiaryInfo? beneficiaryInfo;
  List<ReceiverInfo>? receiverInfo;
  List<PackageDetailsInfoArray>? packageDetailsInfoArray;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    beneficiaryInfo: BeneficiaryInfo.fromJson(json["beneficiary_info"]),
    receiverInfo: List<ReceiverInfo>.from(json["receiver_info"].map((x) => ReceiverInfo.fromJson(x))),
    packageDetailsInfoArray: List<PackageDetailsInfoArray>.from(json["package_details_info_array"].map((x) => PackageDetailsInfoArray.fromJson(x))),
  );
}

class BeneficiaryInfo {
  BeneficiaryInfo({
    this.familyCardNumber,
    this.nidNumber,
    this.dateOfBirth,
    this.addressType,
    this.permanentAddressVillage,
    this.beneficiaryNameBangla,
    this.beneficiaryNameEnglish,
    this.beneficiaryFatherName,
    this.beneficiaryMotherName,
    this.beneficiaryGender,
    this.beneficiaryMaritialStatus,
    this.beneficiarySpouseName,
    this.beneficiaryOccupationName,
    this.beneficiaryMobile,
    this.beneficiaryNidFile,
    this.beneficiaryImageFile,
    this.wordNameBangla,
    this.unionNameBangla,
    this.unionCode,
    this.upazilaNameBangla,
    this.districtNameBangla,
    this.divisionName,
    this.countryName,
  });

  var familyCardNumber;
  var nidNumber;
  var dateOfBirth;
  var addressType;
  var permanentAddressVillage;
  var beneficiaryNameBangla;
  var beneficiaryNameEnglish;
  var beneficiaryFatherName;
  var beneficiaryMotherName;
  var beneficiaryGender;
  var beneficiaryMaritialStatus;
  var beneficiarySpouseName;
  var beneficiaryOccupationName;
  var beneficiaryMobile;
  var beneficiaryNidFile;
  var beneficiaryImageFile;
  var wordNameBangla;
  var unionNameBangla;
  var unionCode;
  var upazilaNameBangla;
  var districtNameBangla;
  var divisionName;
  var countryName;

  factory BeneficiaryInfo.fromJson(Map<String, dynamic> json) => BeneficiaryInfo(
    familyCardNumber: nullConverter(json["family_card_number"]),
    nidNumber: nullConverter(json["nid_number"]),
    dateOfBirth: nullConverter(json["date_of_birth"]),
    addressType: nullConverter(json["address_type"]),
    permanentAddressVillage: nullConverter(json["permanent_address_village"]),
    beneficiaryNameBangla: nullConverter(json["beneficiary_name_bangla"]),
    beneficiaryNameEnglish: nullConverter(json["beneficiary_name_english"]),
    beneficiaryFatherName: nullConverter(json["beneficiary_father_name"]),
    beneficiaryMotherName: nullConverter(json["beneficiary_mother_name"]),
    beneficiaryGender: nullConverter(json["beneficiary_gender"]),
    beneficiaryMaritialStatus: nullConverter(json["beneficiary_maritial_status"]),
    beneficiarySpouseName: nullConverter(json["beneficiary_spouse_name"]),
    beneficiaryOccupationName: nullConverter(json["beneficiary_occupation_name"]),
    beneficiaryMobile: nullConverter(json["beneficiary_mobile"]),
    beneficiaryNidFile: nullConverter(json["beneficiary_nid_file"]),
    beneficiaryImageFile: nullConverter(json["beneficiary_image_file"]),
    wordNameBangla: nullConverter(json["word_name_bangla"]),
    unionNameBangla: nullConverter(json["union_name_bangla"]),
    unionCode: nullConverter(json["union_code"]),
    upazilaNameBangla: nullConverter(json["upazila_name_bangla"]),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    divisionName: nullConverter(json["division_name"]),
    countryName: nullConverter(json["country_name"]),
  );
}

class ReceiverInfo {
  ReceiverInfo({
    this.packageId,
    this.packageDetails,
    this.assignDate,
    this.distributionPlace,
    this.packageName,
    this.dealerLicenceNo,
    this.dealerName,
    this.dealerMobile,
    this.dealerOrgName,
    this.dealerAddress,
    this.dealerEmail,
    this.stepId,
    this.stepName,
    this.deliveryStartDateTime,
    this.deliveryEndDateTime,
    this.otpCode,
    this.receivedDate,
    this.succesOtpCode,
    this.latitude,
    this.longitude,
  });

  var packageId;
  var packageDetails;
  var assignDate;
  var distributionPlace;
  var packageName;
  var dealerLicenceNo;
  var dealerName;
  var dealerMobile;
  var dealerOrgName;
  var dealerAddress;
  var dealerEmail;
  var stepId;
  var stepName;
  var deliveryStartDateTime;
  var deliveryEndDateTime;
  var otpCode;
  var receivedDate;
  var succesOtpCode;
  var latitude;
  var longitude;

  factory ReceiverInfo.fromJson(Map<String, dynamic> json) => ReceiverInfo(
    packageDetails: "",
    packageId: nullConverter(json["package_id"]),
    assignDate: nullConverter(json["assign_date"]),
    distributionPlace: nullConverter(json["distribution_place"]),
    packageName: nullConverter(json["package_name"]),
    dealerLicenceNo: nullConverter(json["dealer_licence_no"]),
    dealerName: nullConverter(json["dealer_name"]),
    dealerMobile: nullConverter(json["dealer_mobile"]),
    dealerOrgName: nullConverter(json["dealer_org_name"]),
    dealerAddress: nullConverter(json["dealer_address"]),
    dealerEmail: nullConverter(json["dealer_email"]),
    stepId: nullConverter(json["step_id"]),
    stepName: nullConverter(json["step_name"]),
    deliveryStartDateTime: nullConverter(json["delivery_start_date_time"]),
    deliveryEndDateTime: nullConverter(json["delivery_end_date_time"]),
    otpCode: nullConverter(json["otp_code"]),
    receivedDate: nullConverter(json["received_date"]),
    succesOtpCode: nullConverter(json["succes_otp_code"]),
    latitude: nullConverter(json["latitude"]),
    longitude: nullConverter(json["longitude"]),
  );
}

class PackageDetailsInfoArray {
  PackageDetailsInfoArray({
    this.packageDetailsId,
    this.packageId,
    this.productId,
    this.productQty,
    this.productIsActive,
    this.productUnit,
    this.productName,
    this.productStatus,
  });

  var packageDetailsId;
  var packageId;
  var productId;
  var productQty;
  var productIsActive;
  var productUnit;
  var productName;
  var productStatus;

  factory PackageDetailsInfoArray.fromJson(Map<String, dynamic> json) => PackageDetailsInfoArray(
    packageDetailsId: nullConverter(json["package_details_id"]),
    packageId: nullConverter(json["package_id"]),
    productId: nullConverter(json["product_id"]),
    productQty: nullConverter(json["product_qty"]),
    productUnit: nullConverter(json["product_unit"]),
    productName: nullConverter(json["product_name"]),
    productStatus: nullConverter(json["product_status"]),
  );

}
