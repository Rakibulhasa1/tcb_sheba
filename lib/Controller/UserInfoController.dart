import 'package:flutter/cupertino.dart';
import 'package:tcb/Model/UserInfo.dart';

class UserInfoController extends ChangeNotifier{

  UserInfoModel? userInfoModel;

  void getUserInfoData(UserInfoModel userInfoModel){
    this.userInfoModel = userInfoModel;
    notifyListeners();
  }

}