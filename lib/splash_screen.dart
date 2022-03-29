import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/admin_dashboard.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/GeneralDashboard/general_user_navigation.dart';
import 'package:tcb/show_toast.dart';

import 'AdminDashboard/admin_user_navigation.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) {
      if(GetStorage().read('token')==null||GetStorage().read('token')==''){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
      }else{
        ApiController().postRequest(token: GetStorage().read('token'), endPoint: ApiEndPoints().dashboard).then((value){
          if(value.responseCode==200){
            var myData = json.decode(value.response.toString());
            if(myData['status']=='success'){
              if(GetStorage().read('userType')!=null){
                if(GetStorage().read('userType')=='DD'||GetStorage().read('userType')=='DE'){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GeneralUserNavigation()), (Route<dynamic> route) => false);
                }else{
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AdminUserNavigation()), (Route<dynamic> route) => false);
                }
              }else{
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
              }
            }else if(myData['status']=='Token is Expired'){
              GetStorage().remove('token');
              GetStorage().remove('userType');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
            }
          }else{
            GetStorage().remove('token');
            GetStorage().remove('userType');
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
            ShowToast.myToast('Something is wrong', Colors.black, 2);
          }
        });
      }
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
            child: Image.asset('asstes/logo.png'),
          ),
          Positioned(
            bottom: 10.0,
            child: Text('কারিগরি সহায়তাঃ স্পেকট্রাম আইটি সলিউশনস লিঃ',style: TextStyle(fontSize: 12,color: Colors.grey[700]),textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}