// To parse this JSON data, do
//
//     final userInformationModel = userInformationModelFromJson(jsonString);

// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

UserInformationModel userInformationModelFromJson(String str) => UserInformationModel.fromJson(json.decode(str));
class UserInformationModel {
  UserInformationModel({
    this.status,
    this.member,
  });

  String? status;
  Member? member;

  factory UserInformationModel.fromJson(Map<String, dynamic> json) => UserInformationModel(
    status: json["status"],
    member: Member.fromJson(json["member"]),
  );
}

class Member {
  Member({
    this.receivingStatus,
    this.benificiaryInfo,
  });

  String? receivingStatus;
  BenificiaryInfo? benificiaryInfo;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    receivingStatus: json["receiving_status"],
    benificiaryInfo: BenificiaryInfo.fromJson(json["benificiary_info"]),
  );
}


class BenificiaryInfo {
  BenificiaryInfo({
    this.beneficiaryId,
    this.beneficiarySl,
    this.familyCardNumber,
    this.otpCode,
    this.nidType,
    this.nidNumber,
    this.addressType,
    this.beneficiaryNameBangla,
    this.beneficiaryNameEnglish,
    this.beneficiaryMobile,
    this.beneficiaryImageFile,
    this.wordNameBangla,
    this.unionNameBangla,
    this.upazilaNameBangla,
    this.districtNameBangla,
    this.divisionName,
  });

  var beneficiaryId;
  var beneficiarySl;
  var familyCardNumber;
  var otpCode;
  var nidType;
  var nidNumber;
  var addressType;
  var beneficiaryNameBangla;
  var beneficiaryNameEnglish;
  var beneficiaryMobile;
  var beneficiaryImageFile;
  var wordNameBangla;
  var unionNameBangla;
  var upazilaNameBangla;
  var districtNameBangla;
  var divisionName;

  factory BenificiaryInfo.fromJson(Map<String, dynamic> json) => BenificiaryInfo(
    beneficiaryId: nullConverter(json["beneficiary_id"]),
    beneficiarySl: nullConverter(json["beneficiary_sl"]),
    familyCardNumber: nullConverter(json["family_card_number"]),
    otpCode: nullConverter(json["otp_code"]),
    nidType: nullConverter(json["nid_type"]),
    nidNumber: nullConverter(json["nid_number"]),
    addressType: nullConverter(json["address_type"]),
    beneficiaryNameBangla: nullConverter(json["beneficiary_name_bangla"]),
    beneficiaryNameEnglish: nullConverter(json["beneficiary_name_english"]),
    beneficiaryMobile: nullConverter(json["beneficiary_mobile"]),
    beneficiaryImageFile: nullConverter(json["beneficiary_image_file"]),
    wordNameBangla: nullConverter(json["word_name_bangla"]),
    unionNameBangla: nullConverter(json["union_name_bangla"]),
    upazilaNameBangla: nullConverter(json["upazila_name_bangla"]),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    divisionName: nullConverter(json["division_name"]),
  );
}
