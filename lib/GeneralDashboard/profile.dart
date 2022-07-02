import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
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
    return Consumer<LoginDataController>(
      builder: (context,profileData,child) {
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
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(profileData.userProfileModel!.data!.userName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(profileData.userProfileModel!.data!.userMobile,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(ApiEndPoints().imageBaseUrl+profileData.userProfileModel!.data!.userImage,),
              ),
            ),

            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChangePassword()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red.withOpacity(0.5),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.key,color: Colors.white,),
                          SizedBox(width: 12,),
                          Text('Change password',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: (){
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.INFO,
                        body: const Center(child: Text(
                          'আপনি কি লগঅউট করতে চাচ্ছেন?',
                          style: TextStyle(fontSize: 12),
                        ),),
                        title: 'Logout',
                        btnOkOnPress: () {
                          GetStorage().remove('token');
                          GetStorage().remove('email');
                          GetStorage().remove('password');
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                        },
                        btnCancelOnPress: (){

                        }
                      ).show();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red.withOpacity(0.5),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.logout,color: Colors.white,),
                          SizedBox(width: 12,),
                          Text('Logout',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        );
      }
    );
  }
}
