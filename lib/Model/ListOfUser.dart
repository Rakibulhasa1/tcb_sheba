// To parse this JSON data, do
//
//     final listOfUser = listOfUserFromJson(jsonString);

// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

ListOfUser listOfUserFromJson(String str) => ListOfUser.fromJson(json.decode(str));

class ListOfUser {
  ListOfUser({
    this.status,
    this.data,
  });

  var status;
  Data? data;

  factory ListOfUser.fromJson(Map<String, dynamic> json) => ListOfUser(
    status: nullConverter(json["status"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.total,
    this.data,
  });

  var total;
  List<BeneficiaryData>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: nullConverter(json["total"]),
    data: List<BeneficiaryData>.from(json["data"].map((x) => BeneficiaryData.fromJson(x))),
  );
}

class BeneficiaryData {
  BeneficiaryData({
    this.beneficiaryId,
    this.beneficiarySl,
    this.familyCardNumber,
    this.otpCode,
    this.nidNumber,
    this.addressType,
    this.beneficiaryNameBangla,
    this.beneficiaryNameEnglish,
    this.beneficiaryMobile,
    this.beneficiaryImageFile,
    this.wordNameBangla,
    this.unionNameBangla,
    this.upazilaNameBangla,
    this.upazilaCode,
    this.districtNameBangla,
    this.divisionName,
    this.countryName,

    this.receiveDate,
    this.stepName,
    this.dealerName,
  });

  var beneficiaryId;
  var beneficiarySl;
  var familyCardNumber;
  var otpCode;
  var nidNumber;
  var addressType;
  var beneficiaryNameBangla;
  var beneficiaryNameEnglish;
  var beneficiaryMobile;
  var beneficiaryImageFile;
  var wordNameBangla;
  var unionNameBangla;
  var upazilaNameBangla;
  var upazilaCode;
  var districtNameBangla;
  var divisionName;
  var countryName;

  var receiveDate;
  var stepName;
  var dealerName;

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) => BeneficiaryData(
    beneficiaryId: nullConverter(json["beneficiary_id"]),
    beneficiarySl: nullConverter(json["beneficiary_sl"]),
    familyCardNumber: nullConverter(json["family_card_number"]),
    otpCode: nullConverter(json["otp_code"]),
    nidNumber: nullConverter(json["nid_number"]),
    addressType: nullConverter(json["address_type"]),
    beneficiaryNameBangla: nullConverter(json["beneficiary_name_bangla"]),
    beneficiaryNameEnglish: nullConverter(json["beneficiary_name_english"]),
    beneficiaryMobile: nullConverter(json["beneficiary_mobile"]),
    beneficiaryImageFile: nullConverter(json["beneficiary_image_file"]),
    wordNameBangla: nullConverter(json["word_name_bangla"]),
    unionNameBangla: nullConverter(json["union_name_bangla"]),
    upazilaNameBangla: nullConverter(json["upazila_name_bangla"]),
    upazilaCode: nullConverter(json["upazila_code"]),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    divisionName: nullConverter(json["division_name"]),
    countryName: nullConverter(json["country_name"]),


    receiveDate: nullConverter(json["received_date"]),
    stepName: nullConverter(json["step_name"]),
    dealerName: nullConverter(json["dealer_name"]),

  );
}
