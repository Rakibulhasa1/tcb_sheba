// To parse this JSON data, do
//
//     final wordListModel = wordListModelFromJson(jsonString);

import 'dart:convert';

import 'package:tcb/ApiConfig/ApiEndPoints.dart';

WordListModel wordListModelFromJson(String str) => WordListModel.fromJson(json.decode(str));

class WordListModel {
  WordListModel({
    this.status,
    this.data,
  });

  var status;
  List<WordModel>? data;

  factory WordListModel.fromJson(Map<String, dynamic> json) => WordListModel(
    status: json["status"],
    data: List<WordModel>.from(json["data"].map((x) => WordModel.fromJson(x))),
  );
}

class WordModel {
  WordModel({
    this.wordId,
    this.unionId,
    this.wordCode,
    this.wordNameBangla,
    this.wordNameEnglish,
    this.isRoad,
  });

  var wordId;
  var unionId;
  var wordCode;
  var wordNameBangla;
  var wordNameEnglish;
  var isRoad;

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
    wordId: nullConverter(json["word_id"]),
    unionId: nullConverter(json["union_id"]),
    wordCode: nullConverter(json["word_code"]),
    wordNameBangla: nullConverter(json["word_name_bangla"]),
    wordNameEnglish: nullConverter(json["word_name_english"]),
    isRoad: nullConverter(json["is_road"]),
  );
}
