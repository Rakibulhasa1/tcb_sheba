
import 'dart:convert';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';


DealerDetailsModel dealerDetailsModelFromJson(String str) => DealerDetailsModel.fromJson(json.decode(str));


class DealerDetailsModel {
  DealerDetailsModel({
    this.status,
    this.data,
  });

  String? status;
  DealerInfoModels? data;

  factory DealerDetailsModel.fromJson(Map<String, dynamic> json) => DealerDetailsModel(
    status: json["status"],
    data: DealerInfoModels.fromJson(json["data"]),
  );
}

class DealerInfoModels {
  DealerInfoModels({
    this.dealerId,
    this.dealerNo,
    this.dealerLicenceNo,
    this.dealerName,
    this.districtId,
    this.upazilaId,
    this.unionId,
    this.dealerMobile,
    this.randomPass,
    this.dealerOrgName,
    this.dealerAddress,
    this.dealerEmail,
    this.dealerStatus,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  var dealerId;
  var dealerNo;
  var dealerLicenceNo;
  var dealerName;
  var districtId;
  var upazilaId;
  var unionId;
  var dealerMobile;
  var randomPass;
  var dealerOrgName;
  var dealerAddress;
  var dealerEmail;
  var dealerStatus;
  var createdBy;
  var createdAt;
  var updatedBy;
  var updatedAt;

  factory DealerInfoModels.fromJson(Map<String, dynamic> json) => DealerInfoModels(
    dealerId: nullConverter(json["dealer_id"]),
    dealerNo: nullConverter(json["dealer_no"]),
    dealerLicenceNo: nullConverter(json["dealer_licence_no"]),
    dealerName: nullConverter(json["dealer_name"]),
    districtId: nullConverter(json["district_id"]),
    upazilaId: nullConverter(json["upazila_id"]),
    unionId: nullConverter(json["union_id"]),
    dealerMobile: nullConverter(json["dealer_mobile"]),
    randomPass: nullConverter(json["random_pass"]),
    dealerOrgName: nullConverter(json["dealer_org_name"]),
    dealerAddress: nullConverter(json["dealer_address"]),
    dealerEmail: nullConverter(json["dealer_email"]),
    dealerStatus: nullConverter(json["dealer_status"]),
    createdBy: nullConverter(json["created_by"]),
    createdAt: nullConverter(json["created_at"]),
    updatedBy: nullConverter(json["updated_by"]),
    updatedAt: nullConverter(json["updated_at"]),
  );
}
