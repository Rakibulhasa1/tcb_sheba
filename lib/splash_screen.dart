import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/BeneficeryDashboard/View/beneficery_side_navigation.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/GeneralDashboard/general_user_navigation.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/MasterApiController.dart';
import 'package:tcb/Model/UserInfo.dart';
import 'package:tcb/QrScan/UserInformationModel.dart';
import 'package:tcb/RegisteredUserDashboard/registration_user_navigation.dart';
import 'package:tcb/WordCouncilorDashboard/word_cawnsilor_user_navigation.dart';
import 'package:tcb/show_toast.dart';

import 'AdminDashboard/admin_user_navigation.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;



  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getConnectivity();
    Provider.of<MasterApiController>(context,listen: false).getMasterData();
      // if(GetStorage().read('token')==null||GetStorage().read('token')==''){
      //   Future.delayed(const Duration(seconds: 2)).then((value){
      //     if(GetStorage().read('b_token')!=null){
      //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BeneficerySideNavigation()), (Route<dynamic> route) => false);
      //     }else{
      //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
      //     }
      //   });
      // }else{
      //
      // }

    Future.delayed(const Duration(seconds: 2)).then((value){
      ApiController().postRequest(endPoint: "user-info").then((value){
        try{
          UserInfoModel userInfoModel = userInfoModelFromJson(value.response.toString());
          Provider.of<UserInfoController>(context,listen: false).getUserInfoData(userInfoModel);
          if(userInfoModel.status=='success'){
            if(userInfoModel.data!.userInfo!.userAreaType!=null){
              GetStorage().write("user_type", userInfoModel.data!.userInfo!.userAreaType);
              if(userInfoModel.data!.userInfo!.userAreaType=='DD'||userInfoModel.data!.userInfo!.userAreaType=='TR'){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const GeneralUserNavigation()), (Route<dynamic> route) => false);

              }else if(userInfoModel.data!.userInfo!.userAreaType=='R'){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RegistrationUserNavigation()), (Route<dynamic> route) => false);

              }else if(userInfoModel.data!.userInfo!.userAreaType=='DI'||userInfoModel.data!.userInfo!.userAreaType=='D'||userInfoModel.data!.userInfo!.userAreaType=='U'||userInfoModel.data!.userInfo!.userAreaType=='UI'||userInfoModel.data!.userInfo!.userAreaType=='W'||userInfoModel.data!.userInfo!.userAreaType=='A'){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AdminUserNavigation()), (Route<dynamic> route) => false);

              }else if(userInfoModel.data!.userInfo!.userAreaType=='B'){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BeneficerySideNavigation()), (Route<dynamic> route) => false);

              }else{
                ShowToast.myToast('দয়াকরে ওয়েবসাইট থেকে লগইন করুন', Colors.black, 2);
              }
            }else{
              GetStorage().remove('token');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
            }
          }
          else if(userInfoModel.status=='Token is Expired'){
            GetStorage().remove('token');
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
          }
          else{
            GetStorage().remove('token');
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
          }
        }catch(e){
          GetStorage().remove('token');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);

        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset('asstes/mainLogo.png',height: 140,width: 140,),
          ),
          Positioned(
            bottom: 10.0,
            child: Text('কারিগরি সহায়তাঃ স্পেকট্রাম আইটি সলিউশনস লিঃ',style: TextStyle(fontSize: 12,color: Colors.grey[700]),textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
