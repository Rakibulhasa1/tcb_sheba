import 'package:flutter/cupertino.dart';
import 'package:tcb/AdminDashboard/Model/union_list_model.dart';
import 'package:tcb/AdminDashboard/Model/word_list_model.dart';

class DialogDataController extends ChangeNotifier{

  List<UnionModel> unionList = [];
  List<WordModel> wardList = [];


  void setUnionData(List<UnionModel> unionList){
    this.unionList = unionList;
    notifyListeners();
  }

  void setWardData(List<WordModel> wardList){
    this.wardList = wardList;
    notifyListeners();
  }

}