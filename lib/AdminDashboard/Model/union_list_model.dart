// To parse this JSON data, do
//
//     final unionListModel = unionListModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

UnionListModel unionListModelFromJson(String str) => UnionListModel.fromJson(json.decode(str));

class UnionListModel {
  UnionListModel({
    this.status,
    this.union,
  });

  var status;
  List<UnionModel>? union;

  factory UnionListModel.fromJson(Map<String, dynamic> json) => UnionListModel(
    status: nullConverter(json["status"]),
    union: List<UnionModel>.from(json["data"].map((x) => UnionModel.fromJson(x))),
  );
}

class UnionModel {
  UnionModel({
    this.unionId,
    this.upazilaId,
    this.unionCode,
    this.unionNameBangla,
    this.unionNameEnglish,
  });

  var unionId;
  var upazilaId;
  var unionCode;
  var unionNameBangla;
  var unionNameEnglish;

  factory UnionModel.fromJson(Map<String, dynamic> json) => UnionModel(
    unionId: nullConverter(json["union_id"]),
    upazilaId: nullConverter(json["upazila_id"]),
    unionCode: nullConverter(json["union_code"]),
    unionNameBangla: nullConverter(json["union_name_bangla"]),
    unionNameEnglish: nullConverter(json["union_name_english"]),
  );

}
