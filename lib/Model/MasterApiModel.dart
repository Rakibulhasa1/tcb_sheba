
import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

MasterApiModel masterApiModelFromJson(String str) => MasterApiModel.fromJson(json.decode(str));

class MasterApiModel {
  MasterApiModel({
    this.status,
    this.masterData,
  });

  String? status;
  MasterData? masterData;

  factory MasterApiModel.fromJson(Map<String, dynamic> json) => MasterApiModel(
    status: json["status"],
    masterData: MasterData.fromJson(json["data"]),
  );
}

class MasterData {
  MasterData({
    this.masterDataId,
    this.logo,
    this.temsCondition,
    this.policyContext,
    this.webSiteTitle,
    this.webSiteFooterTitle,
    this.webSiteLink,
    this.otpStatus,
    this.nidScanDelivery,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  var masterDataId;
  var logo;
  var temsCondition;
  var policyContext;
  var webSiteTitle;
  var webSiteFooterTitle;
  var webSiteLink;
  var otpStatus;
  var nidScanDelivery;
  var createdBy;
  var createdAt;
  var updatedBy;
  var updatedAt;

  factory MasterData.fromJson(Map<String, dynamic> json) => MasterData(
    masterDataId: nullConverter(json["master_data_id"]),
    logo: nullConverter(json["logo"]),
    temsCondition: nullConverter(json["tems_condition"]),
    policyContext: nullConverter(json["policy_context"]),
    webSiteTitle: nullConverter(json["web_site_title"]),
    webSiteFooterTitle: nullConverter(json["web_site_footer_title"]),
    webSiteLink: nullConverter(json["web_site_link"]),
    nidScanDelivery: nullConverter(json['nid_scan_delivery']),
    otpStatus: nullConverter(json["otp_status"]),
    createdBy: nullConverter(json["created_by"]),
    createdAt: nullConverter(json["created_at"]),
    updatedBy: nullConverter(json["updated_by"]),
    updatedAt: nullConverter(json["updated_at"]),
  );
}
