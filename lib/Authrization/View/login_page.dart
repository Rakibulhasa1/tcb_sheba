import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DialogDataController.dart';
import 'package:tcb/AdminDashboard/admin_scan_result_for_registration.dart';
import 'package:tcb/AdminDashboard/admin_user_navigation.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_registration.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/BeneficeryDashboard/View/beneficery_side_navigation.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/GeneralDashboard/general_user_navigation.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/MasterApiController.dart';
import 'package:tcb/Model/UserInfo.dart';
import 'package:tcb/RegisteredUserDashboard/registration_user_navigation.dart';
import 'package:tcb/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AdminDashboard/RegistrationForBenefRegister.dart';
import '../../AdminDashboard/send_otp_by_register.dart';
import '../../GeneralDashboard/profile.dart';
import '../../change_password.dart';
import '../../change_password2.dart';
import '../../forget_password.dart';
import '../../login_change_password.dart';
import '../../otp_verification.dart';
import '../../select_profile_image.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool seePassword = false;
  bool isWorking = false;
  int selectableUser = 0;

  bool isAccept = false;
  bool isBilling = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text('Login',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const SizedBox(height: 10,),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  //   child: Row(
                  //     children: [
                  //       CustomButtonWithSelectable(
                  //         title: "এডমিন",
                  //         isSelectable: selectableUser==0?true:false,
                  //         onTab: (){
                  //           setState(() {
                  //             selectableUser = 0;
                  //           });
                  //         },
                  //       ),
                  //       SizedBox(width: 12,),
                  //       CustomButtonWithSelectable(
                  //         title: "উপকারভোগী",
                  //         isSelectable: selectableUser==1?true:false,
                  //         onTab: (){
                  //           setState(() {
                  //             selectableUser = 1;
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  child: Icon(Icons.lock,size: 20,color: Colors.grey[600],),
                                ),
                                Expanded(
                                  child: TextField(
                                    obscureText: (seePassword)?false:true,
                                    textAlign: TextAlign.start,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    autocorrect: false,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(
                                        height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                                    decoration: InputDecoration(
                                        suffixIcon: (seePassword)?IconButton(
                                          onPressed: (){
                                            setState(() {
                                              seePassword = false;
                                            });
                                          },
                                          icon: const Icon(Icons.remove_red_eye),
                                        ):IconButton(
                                          onPressed: (){
                                            setState(() {
                                              seePassword = true;
                                            });
                                          },
                                          icon: const Icon(Icons.visibility_off_sharp),
                                        ),
                                        hintStyle: const TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                                        hintText: selectableUser==1?'Mobile number':'Password',
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12)
                                    ),
                                    controller: passwordController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:32.0),
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginChangePassword()));

                            },
                            child: Text('পাসওয়ার্ড পরিবর্তন',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,decoration: TextDecoration.underline))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Container(

                      color: isBilling?Colors.red:Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            CheckboxTheme(
                              child: Checkbox(
                                value: isAccept,
                                onChanged: (value){
                                  setState((){
                                    isAccept = !isAccept;
                                  });
                                },
                              ),
                              data: CheckboxThemeData(
                                splashRadius: 20,
                              ),
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text('I accept the upokari.com '),
                                InkWell(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                        return Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          insetPadding: const EdgeInsets.all(16),
                                          child: Consumer<MasterApiController>(
                                            builder: (context,data,child) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Terms & Condition',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                        Spacer(),
                                                        IconButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          icon: Icon(Icons.remove_circle_outline_rounded),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 24),
                                                    Container(
                                                      height: 300,
                                                      child: SingleChildScrollView(child: Text(data.masterData!.temsCondition.length<50?HelperClass().terms:'${data.masterData!.temsCondition}',textAlign: TextAlign.justify,)),
                                                    ),
                                                    SizedBox(height: 24),
                                                    Row(
                                                      children: [
                                                        Spacer(),

                                                        InkWell(
                                                          borderRadius: BorderRadius.circular(25),
                                                          child: Container(
                                                            child: Text('Denied'),
                                                            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
                                                          ),
                                                          onTap: (){
                                                            setState((){
                                                              isAccept = false;
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                        ),

                                                        InkWell(
                                                          borderRadius: BorderRadius.circular(25),
                                                          child: Container(
                                                            child: Text('Accept',style: TextStyle(color: Colors.white)),
                                                            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(25),
                                                                color: Colors.blue
                                                            ),
                                                          ),
                                                          onTap: (){
                                                            setState((){
                                                              isAccept = true;
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                  ],
                                                ),
                                              );
                                            }
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Terms & Conditions',style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),

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
                    } else if(isAccept){
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
                                'password' : passwordController.text,
                              };

                              ApiController().loginResponse(endPoint: ApiEndPoints().login,body: body).then((value){
                                if(value.responseCode==200){
                                  try{
                                    var response = json.decode(value.response.toString());
                                    GetStorage().write("token","Bearer ${response['token']}").then((value){
                                      getUserInfo();
                                    });

                                    setState(() {
                                      isWorking = false;
                                    });
                                  }
                                  catch(e){
                                    ShowToast.myToast(getUnknownError(value.responseCode!), Colors.black, 2);
                                    setState(() {
                                      isWorking = false;
                                    });
                                  }

                                }
                                else if(value.responseCode==401){
                                  ShowToast.myToast('দয়াকরে সঠিক ইউজার আইডি অথবা পাসওয়ার্ড দিন।', Colors.black, 2);
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
                              child: const Text('লগইন',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(width: 10,),
                         Text("Emergency Contact : 01763444222\nEmail : smartfamilycard@gmail.com ",style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10,),
                        Expanded(child: Divider()),
                    ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32),
                  //   child: InkWell(
                  //     onTap: (){
                  //       showDialog(context: context, builder: (context){
                  //
                  //         return Dialog(
                  //           shape: const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.all(Radius.circular(20.0))
                  //           ),
                  //           insetPadding: const EdgeInsets.all(48),
                  //           child: StatefulBuilder(
                  //               builder: (context,setState) {
                  //
                  //                 return Container(
                  //                   padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(20),
                  //                   ),
                  //
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text('রেজিস্ট্রেশন করুন',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                  //                       SizedBox(height: 24),
                  //                       Material(
                  //                         borderRadius: BorderRadius.circular(5),
                  //                         color: Colors.purple,
                  //                         child: InkWell(
                  //                           onTap: (){
                  //                             Navigator.pop(context);
                  //                             Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanWithRegister()));
                  //                           },
                  //                           child: Padding(
                  //                             padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                  //                             child: Container(
                  //                               alignment : Alignment.center,
                  //                               child: Text('সাধারণ নাগরিক',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 24),
                  //                       Material(
                  //                         borderRadius: BorderRadius.circular(5),
                  //                         color: Colors.green,
                  //                         child: InkWell(
                  //                           onTap: (){
                  //                             Navigator.pop(context);
                  //                             Navigator.push(context, CupertinoPageRoute(builder: (context)=>AdminScanResultForRegistration()));
                  //                           },
                  //                           child: Padding(
                  //                             padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                  //                             child: Container(
                  //                               alignment : Alignment.center,
                  //                               child: Text('এডমিন *',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 12),
                  //                       Text("*জনপ্রতিনিধি, প্রশাসনিক কর্মকর্তা, ইউপি সচিব, ওয়ার্ড সচিব, ইউডিসি এবং ডিলারগণ এডমিন হিসেবে রেজিস্ট্রেশন করতে পারবেন।",style: TextStyle(color: Colors.grey[800],fontSize: 12)),
                  //                     ],
                  //                   ),
                  //                 );
                  //               }
                  //           ),
                  //         );
                  //       });
                  //     },
                  //     child: Container(
                  //       height: 45,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5),
                  //         color: Colors.green.withOpacity(0.5),
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text("রেজিস্ট্রেশন করুন",style: TextStyle(color: Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold)),
                  //           SizedBox(width: 12,),
                  //           Icon(Icons.arrow_circle_right,color: Colors.green),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 50.0,
            left: 0.0,
            right: 0.0,
            child: Image.asset('asstes/mainLogo.png',height: 90,width: 90,),

          ),
          Positioned(
            bottom: 12.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: ()async{
                    const url = "http://tcb.gov.bd/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not launch $url";
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 10),
                        children: <TextSpan>[
                          TextSpan(text: "Copyright © 2022 ",style: TextStyle(color: Colors.grey[600])),
                          const TextSpan(text: "Trading Corporation of Bangladesh (TCB)",style: TextStyle(color: Colors.black)),
                        ]

                      ),
                    ),
                  ),
                ),
                Text("All rights reserved.",style: TextStyle(fontSize: 10,color: Colors.grey[600]),),
                GestureDetector(
                  onTap: ()async{
                    const url = "http://spectrum.com.bd/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not launch $url";
                    }
                  },
                  child: Text('Powered by: Spectrum IT Solutions LTD.',style: TextStyle(fontSize: 10,color: Colors.grey[600]),textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getUserInfo(){
    Provider.of<MasterApiController>(context,listen: false).getMasterData();
    ApiController().postRequest(endPoint: 'user-info',).then((value){
      if(value.responseCode==200){
        try{
          UserInfoModel userInfoModel = userInfoModelFromJson(value.response.toString());
          Provider.of<UserInfoController>(context,listen: false).getUserInfoData(userInfoModel);

          UserInfo userData = userInfoModel.data!.userInfo!;
          GetStorage().write("user_type", userData.userAreaType);

          print(userData.userAreaType);

          if(userData.userAreaType=='DD'||userData.userAreaType=='TR'){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const GeneralUserNavigation()), (Route<dynamic> route) => false);

          }else if(userData.userAreaType=='R'){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RegistrationUserNavigation()), (Route<dynamic> route) => false);

          }else if(userData.userAreaType=='DI'||userData.userAreaType=='D'||userData.userAreaType=='U'||userData.userAreaType=='UI'||userData.userAreaType=='W'||userData.userAreaType=='A'){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AdminUserNavigation()), (Route<dynamic> route) => false);

          }else if(userData.userAreaType=='B'){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BeneficerySideNavigation()), (Route<dynamic> route) => false);

          }else{
            ShowToast.myToast('দয়াকরে ওয়েবসাইট থেকে লগইন করুন', Colors.black, 2);
          }
        }catch(e){
          ShowToast.myToast(getUnknownError(value.responseCode!), Colors.black, 2);
        }
      }
    });
  }
}
