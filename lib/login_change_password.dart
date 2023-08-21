import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/show_toast.dart';

import 'ApiConfig/ApiController.dart';
import 'ApiConfig/ApiEndPoints.dart';
import 'HelperClass.dart';
import 'mobile_verify_screen.dart';
import 'otp_verification.dart';
import 'package:http/http.dart' as http;

import 'otp_verification_screen.dart';
class LoginChangePassword extends StatefulWidget {
  const LoginChangePassword({Key? key}) : super(key: key);

  @override
  State<LoginChangePassword> createState() => _LoginChangePasswordState();
}

class _LoginChangePasswordState extends State<LoginChangePassword> {
  int selectableUser = 0;
  bool isWorking = false;
  bool isBilling = false;

  bool isAccept = false;
  void billingButton(){
    setState(() {
      isBilling = true;
    });
    Future.delayed(Duration(seconds: 2)).then((value){
      setState(() {
        isBilling = false;
      });
    });

  }
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('পাসওয়ার্ড পরিবর্তন'),
      ),
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('asstes/mainLogo.png',height: 100,width: 100,),
            ),
            SizedBox(height: 40,),
            Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 3.0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 0),
                height: 43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.6),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: const Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(Icons.person,size: 20,color: Colors.grey[600],),
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                        decoration: InputDecoration(
                            hintStyle:const TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                            hintText: selectableUser==0?'User Name':'NID number',
                            border:const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding:const EdgeInsets.symmetric(horizontal: 12)
                        ),
                        controller: userNameController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Builder(builder: (context){
              if(isWorking){
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              } else if(isAccept=true){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: (){

                        setState(() {
                          isWorking = true;
                        });

                        var body = {
                          'email' : userNameController.text,

                        };

                        ApiController().loginResponse(endPoint: ApiEndPoints().passwordReset,body: body).then((value){
                          if(value.responseCode==200){

                            ShowToast.myToast('সঠিক ইউজার।', Colors.black, 2);
                            setState(() {
                              isWorking = false;
                            });

                          }
                          else if(value.responseCode==404){
                            ShowToast.myToast('দয়াকরে সঠিক ইউজার আইডি দিন।', Colors.black, 2);
                            setState(() {
                              isWorking = false;
                            });
                          }
                          else{
                            ShowToast.myToast(getUnknownError(value.responseCode!), Colors.black, 2);
                            setState(() {
                              isWorking = false;
                            });
                          }
                        });

                        // setState(() {
                        //   isWorking = true;
                        // });
                        //
                        // var body = {
                        //   'email' : userNameController.text,
                        //   // 'password' : passwordController.text,
                        // };
                        //
                        // ApiController().loginResponse(endPoint: ApiEndPoints().resetUserValidation,body: body).then((value){
                        //   if(value.responseCode==200){
                        //     ShowToast.myToast('সঠিক ইউজার আইডি পাওয়া গিয়েছে', Colors.black, 2);
                        //     try{
                        //       var response = json.decode(value.response.toString());
                        //       GetStorage().write("token","Bearer ${response['token']}").then((value){
                        //         // getUserInfo();
                        //       });
                        //
                        //       setState(() {
                        //         isWorking = false;
                        //       });
                        //     }
                        //     catch(e){
                        //       ShowToast.myToast(getUnknownError(value.responseCode!), Colors.black, 2);
                        //       setState(() {
                        //         isWorking = false;
                        //       });
                        //     }
                        //
                        //   }
                        //   else if(value.responseCode==401){
                        //     ShowToast.myToast('দয়াকরে সঠিক ইউজার আইডি দিন।', Colors.black, 2);
                        //     setState(() {
                        //       isWorking = false;
                        //     });
                        //   }
                        //   else{
                        //     ShowToast.myToast(getUnknownError(value.responseCode!), Colors.black, 2);
                        //     setState(() {
                        //       isWorking = false;
                        //     });
                        //   }
                        // });





                        // if(selectableUser==1){
                        //   ApiController().loginResponse(endPoint: ApiEndPoints().login,body: body).then((value){
                        //     print(value.responseCode);
                        //     if(value.responseCode==200){
                        //       try{
                        //         UserProfileModel userData = userProfileModelFromJson(value.response.toString());
                        //         Provider.of<LoginDataController>(context,listen: false).getUserData(userData);
                        //         GetStorage().write('email', userNameController.text.toString());
                        //         GetStorage().write('password', passwordController.text.toString());
                        //         GetStorage().write('userType', userData.data!.userAreaType.toString());
                        //         GetStorage().write('userId', userData.data!.usersId.toString());
                        //
                        //         print("Gender Status : ${userData.data!.councilorGenderStatus}");
                        //
                        //
                        //         if(userData.data!.userAreaType=='B'){
                        //           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BenefiLoginOtpSend(
                        //             userName: userNameController.text,
                        //             password: passwordController.text,
                        //             userId: userData.data!.usersId,
                        //           )), (Route<dynamic> route) => false);
                        //         }
                        //
                        //
                        //
                        //         setState(() {
                        //           isWorking = false;
                        //         });
                        //       }
                        //       catch(e){
                        //         ShowToast.myToast('Something is wrong', Colors.black, 2);
                        //         setState(() {
                        //           isWorking = false;
                        //         });
                        //       }
                        //
                        //     }else{
                        //       ShowToast.myToast('Something is wrong', Colors.black, 2);
                        //       setState(() {
                        //         isWorking = false;
                        //       });
                        //     }
                        //   });
                        //
                        // }else{
                        //
                        //
                        // }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                        width: MediaQuery.of(context).size.width,
                        child: const Text('Verify',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),
                );
              }else{
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
                  child: InkWell(
                    onTap: (){
                      billingButton();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                        width: MediaQuery.of(context).size.width,
                        child: const Text('লগইন',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ) ,


    );
  }



}
