import 'package:flutter/cupertino.dart';

class PramsController extends ChangeNotifier{

  String globalPrams = "";

  void setGlobalPrams(globalPrams){
    this.globalPrams = globalPrams;
    notifyListeners();
  }
}