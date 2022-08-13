
import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

DealerReportModel dealerReportModelFromJson(String str) => DealerReportModel.fromJson(json.decode(str));

class DealerReportModel {
  DealerReportModel({
    this.status,
    this.dealerReportList,
  });

  String? status;
  List<DealerReportList>? dealerReportList;

  factory DealerReportModel.fromJson(Map<String, dynamic> json) => DealerReportModel(
    status: json["status"],
    dealerReportList: List<DealerReportList>.from(json["data"].map((x) => DealerReportList.fromJson(x))),
  );
}

class DealerReportList {
  DealerReportList({
    this.stepName,
    this.packageName,
    this.deliveryStartDateTime,
    this.deliveryEndDateTime,
    this.receiverTotalQty,
    this.totalBeneficiary,
    this.dealerId,
  });

  var stepName;
  var packageName;
  var deliveryStartDateTime;
  var deliveryEndDateTime;
  var receiverTotalQty;
  var totalBeneficiary;
  var dealerId;

  factory DealerReportList.fromJson(Map<String, dynamic> json) => DealerReportList(
    stepName: nullConverter(json["step_name"]),
    packageName: nullConverter(json["package_name"]),
    deliveryStartDateTime: nullConverter(json["delivery_start_date_time"]),
    deliveryEndDateTime: nullConverter(json["delivery_end_date_time"]),
    receiverTotalQty: nullConverter(json["receiver_total_qty"]),
    totalBeneficiary: nullConverter(json["total_beneficiary"]),
    dealerId: nullConverter(json["dealer_id"]),
  );
}
