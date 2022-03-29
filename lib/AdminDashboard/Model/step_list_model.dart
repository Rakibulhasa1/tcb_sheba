// To parse this JSON data, do
//
//     final stepListModel = stepListModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

StepListModel stepListModelFromJson(String str) => StepListModel.fromJson(json.decode(str));

class StepListModel {
  StepListModel({
    this.status,
    this.data,
  });

  var status;
  List<StepModel>? data;

  factory StepListModel.fromJson(Map<String, dynamic> json) => StepListModel(
    status: nullConverter(json["status"]),
    data: List<StepModel>.from(json["data"].map((x) => StepModel.fromJson(x))),
  );
}

class StepModel {
  StepModel({
    this.stepId,
    this.stepName,
    this.deliveryStartDateTime,
    this.deliveryEndDateTime,
    this.createdBy,
  });

  var stepId;
  var stepName;
  var deliveryStartDateTime;
  var deliveryEndDateTime;
  var createdBy;

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
    stepId: nullConverter(json["step_id"]),
    stepName: nullConverter(json["step_name"]),
    deliveryStartDateTime: nullConverter(json["delivery_start_date_time"]),
    deliveryEndDateTime: nullConverter(json["delivery_end_date_time"]),
    createdBy: nullConverter(json["created_by"]),
  );
}
