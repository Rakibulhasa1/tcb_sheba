// To parse this JSON data, do
//
//     final beneficeryNidSearchModel = beneficeryNidSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

BeneficeryNidSearchModel beneficeryNidSearchModelFromJson(String str) => BeneficeryNidSearchModel.fromJson(json.decode(str));

class BeneficeryNidSearchModel {
  BeneficeryNidSearchModel({
    required this.status,
    required this.member,
  });

  String status;
  Member member;

  factory BeneficeryNidSearchModel.fromJson(Map<String, dynamic> json) => BeneficeryNidSearchModel(
    status: json["status"],
    member: Member.fromJson(json["member"]),
  );
}

class Member {
  Member({
    this.beneficiaryId,
    this.beneficiarySl,
    this.familyCardNumber,
    this.beneficiaryAddDate,
    this.otpCode,
    this.otpCodeDateTime,
    this.nidType,
    this.nidNumber,
    this.dateOfBirth,
    this.addressType,
    this.permanentAddressUnionId,
    this.permanentAddressWordId,
    this.permanentAddressVillage,
    this.permanentAddressHoldingNo,
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
    this.beneficiaryStatus,
    this.isDeliverdCard,
    this.cardDeliveryTime,
    this.councilorGenderStatus,
    this.isApproved,
    this.approvedTime,
    this.approvedUserId,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.dataUploadMasterInfoId,
    this.uploadDateTime,
    this.uploadNo,
    this.uploadFileName,
    this.createdUserName,
    this.wordId,
    this.wordNameBangla,
    this.wordNameEnglish,
    this.wordCode,
    this.isRoad,
    this.unionId,
    this.unionNameBangla,
    this.unionNameEnglish,
    this.unionCode,
    this.isMunicipality,
    this.upazilaId,
    this.upazilaNameBangla,
    this.upazilanameEnglish,
    this.upazilaCode,
    this.isCityCorporation,
    this.districtId,
    this.districtNameBangla,
    this.districtCode,
    this.isCitycorporation,
    this.divisionId,
    this.divisionName,
    this.countryId,
    this.countryName,
  });

  String? beneficiaryId;
  String? beneficiarySl;
  String? familyCardNumber;
  String? beneficiaryAddDate;
  String? otpCode;
  String? otpCodeDateTime;
  String? nidType;
  String? nidNumber;
  String? dateOfBirth;
  String? addressType;
  String? permanentAddressUnionId;
  String? permanentAddressWordId;
  String? permanentAddressVillage;
  String? permanentAddressHoldingNo;
  String? beneficiaryNameBangla;
  String? beneficiaryNameEnglish;
  String? beneficiaryFatherName;
  String? beneficiaryMotherName;
  String? beneficiaryGender;
  String? beneficiaryMaritialStatus;
  String? beneficiarySpouseName;
  String? beneficiaryOccupationName;
  String? beneficiaryMobile;
  String? beneficiaryNidFile;
  String? beneficiaryImageFile;
  String? beneficiaryStatus;
  String? isDeliverdCard;
  String? cardDeliveryTime;
  String? councilorGenderStatus;
  String? isApproved;
  String? approvedTime;
  String? approvedUserId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? dataUploadMasterInfoId;
  String? uploadDateTime;
  String? uploadNo;
  String? uploadFileName;
  String? createdUserName;
  String? wordId;
  String? wordNameBangla;
  String? wordNameEnglish;
  String? wordCode;
  String? isRoad;
  String? unionId;
  String? unionNameBangla;
  String? unionNameEnglish;
  String? unionCode;
  String? isMunicipality;
  String? upazilaId;
  String? upazilaNameBangla;
  String? upazilanameEnglish;
  String? upazilaCode;
  String? isCityCorporation;
  String? districtId;
  String? districtNameBangla;
  String? districtCode;
  String? isCitycorporation;
  String? divisionId;
  String? divisionName;
  String? countryId;
  String? countryName;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    beneficiaryId: nullConverter(json["beneficiary_id"]),
    beneficiarySl: nullConverter(json["beneficiary_sl"]),
    familyCardNumber: nullConverter(json["family_card_number"]),
    otpCode: nullConverter(json["otp_code"]),
    nidType: nullConverter(json["nid_type"]),
    nidNumber: nullConverter(json["nid_number"]),
    dateOfBirth: nullConverter(json["date_of_birth"]),
    addressType: nullConverter(json["address_type"]),
    permanentAddressUnionId: nullConverter(json["permanent_address_union_id"]),
    permanentAddressWordId: nullConverter(json["permanent_address_word_id"]),
    permanentAddressVillage: nullConverter(json["permanent_address_village"]),
    permanentAddressHoldingNo: nullConverter(json["permanent_address_holding_no"]),
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
    beneficiaryStatus: nullConverter(json["beneficiary_status"]),
    isDeliverdCard: nullConverter(json["is_deliverd_card"]),
    cardDeliveryTime: nullConverter(json["card_delivery_time"]),
    councilorGenderStatus: nullConverter(json["councilor_gender_status"]),

    uploadFileName: nullConverter(json["upload_file_name"]),
    createdUserName: nullConverter(json["created_user_name"]),
    wordId: nullConverter(json["word_id"]),
    wordNameBangla: nullConverter(json["word_name_bangla"]),
    wordNameEnglish: nullConverter(json["word_name_english"]),
    wordCode: nullConverter(json["word_code"]),
    isRoad: nullConverter(json["is_road"]),
    unionId: nullConverter(json["union_id"]),
    unionNameBangla: nullConverter(json["union_name_bangla"]),
    unionNameEnglish: nullConverter(json["union_name_english"]),
    unionCode: nullConverter(json["union_code"]),
    isMunicipality: nullConverter(json["is_municipality"]),
    upazilaId: nullConverter(json["upazila_id"]),
    upazilaNameBangla: nullConverter(json["upazila_name_bangla"]),
    upazilanameEnglish: nullConverter(json["upazilaname_english"]),
    upazilaCode: nullConverter(json["upazila_code"]),
    isCityCorporation: nullConverter(json["is_city_corporation"]),
    districtId: nullConverter(json["district_id"]),
    districtNameBangla: nullConverter(json["district_name_bangla"]),
    districtCode: nullConverter(json["district_code"]),
    isCitycorporation: nullConverter(json["is_citycorporation"]),
    divisionId: nullConverter(json["division_id"]),
    divisionName: nullConverter(json["division_name"]),
    countryId: nullConverter(json["country_id"]),
    countryName: nullConverter(json["country_name"]),
  );

}
