import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Authrization/Controller/LoginDataController.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/change_password.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  void initState() {
    var body = {
      'email' : GetStorage().read('email'),
      'password' : GetStorage().read('password'),
    };
    Future.delayed(Duration.zero).then((value){
      Provider.of<LoginDataController>(context,listen: false).getResponse(body);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginDataController,DealerInfoController>(
      builder: (context,profileData,dealerData,child) {
        if(profileData.apiResponse.isWorking!){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(profileData.apiResponse.responseError!){
          return Container();
        }

        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [

            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.bottomCenter,
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(profileData.userProfileModel!.data!.userFullName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(profileData.userProfileModel!.data!.userMobile,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(ApiEndPoints().imageBaseUrl+profileData.userProfileModel!.data!.userImage,),
              ),
            ),
            Positioned(
              top: 300,
              child: Builder(
                builder: (context) {
                  if(dealerData.apiResponse.isWorking!){
                    return Container();
                  }
                  if(dealerData.apiResponse.responseError!){
                    return Container();
                  }
                  return Text('${dealerData.dealerInfoModels!.dealerAddress}');
                }
              ),
            ),
          ],
        );
      }
    );
  }
}
