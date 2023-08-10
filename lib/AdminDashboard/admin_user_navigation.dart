
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:tcb/AdminDashboard/Controller/DialogDataController.dart';
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';
import 'package:tcb/AdminDashboard/Model/union_list_model.dart';
import 'package:tcb/AdminDashboard/Model/word_list_model.dart';
import 'package:tcb/AdminDashboard/RegistrationForBenefRegister.dart';
import 'package:tcb/AdminDashboard/admin_dashboard.dart';
import 'package:tcb/AdminDashboard/admin_registration.dart';
import 'package:tcb/AdminDashboard/admin_scan_result_for_registration.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_for_beneficery_details.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_registration.dart';
import 'package:tcb/AdminDashboard/card_delivery_details.dart';
import 'package:tcb/AdminDashboard/side_navigation_bar.dart';
import 'package:tcb/AdminDashboard/submit_for_registration.dart';
import 'package:tcb/AdminDashboard/user_details_view_by_admin.dart';
import 'package:tcb/AdminDashboard/ward_list_widget.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/CustomDialogs.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/app_theme.dart';
import 'package:tcb/change_password.dart';
import 'package:tcb/show_toast.dart';
import 'package:tcb/support_team_message.dart';
import 'package:tcb/terms_and_condition.dart';

class AdminUserNavigation extends StatefulWidget {

  const AdminUserNavigation({Key? key}) : super(key: key);

  @override
  _AdminUserNavigationState createState() => _AdminUserNavigationState();
}

class _AdminUserNavigationState extends State<AdminUserNavigation> {

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  int currentTab = 0;
  int selectedId = 0;

  List<Widget> bottomNavWidget = [
    AdminDashboard(),
  ];


  Future qrScannerForUserDetails()async{
    var camaraPermission = await Permission.camera.status;
    if(camaraPermission.isGranted){
      String? qrCode = await scanner.scan();
      //String? qrCode = await qrScanner();
      if(qrCode!=null){
        getQrScanData(qrCode);
      }else{

      }
    }else{
      var isGrandt  = await Permission.camera.request();
      if(isGrandt.isGranted){
        String? qrCode = await scanner.scan();
        if(qrCode!=null){
          getQrScanData(qrCode);
        }else{

        }
      }
    }
  }
  Future qrScannerForCardDelivery()async{
    var camaraPermission = await Permission.camera.status;
    if(camaraPermission.isGranted){
      String? qrCode = await scanner.scan();
      if(qrCode!=null){
        getCardDeliveryData(qrCode);
      }else{

      }
    }else{
      var isGrandt  = await Permission.camera.request();
      if(isGrandt.isGranted){
        String? qrCode = await scanner.scan();
        if(qrCode!=null){
          getCardDeliveryData(qrCode);
        }else{

        }
      }
    }
  }

  void getQrScanData(String qrCodeData){
    print("QR Data : ${qrCodeData}");
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserDetailsViewByAdmin(userId: qrCodeData,isScan: true,)));
  }

  void getCardDeliveryData(String qrCodeData){
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>CardDeliveryDetails(userId: qrCodeData)));
  }



  @override
  void initState() {
    //HelperClass().checkVersion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        backgroundColor: primaryColorGreenLite,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset('asstes/mainLogo.png',height: 30,),
              SizedBox(width: 10,),
              Text('Upokari',style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),


      body: bottomNavWidget[currentTab],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        isExtended: true,
        child: const Icon(Icons.qr_code,color: Colors.white,),
        onPressed: () {
          showDialog(context: context, builder: (context){
            return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              insetPadding: const EdgeInsets.all(48),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                    SizedBox(height: 16),
                    Text('শুধু মাত্র উপকারভোগীর তথ্য দেখার জন্য স্ক্যান করুন ।',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.red),),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        qrScannerForUserDetails();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: const [
                            Icon(Icons.qr_code),
                            SizedBox(width: 10),
                            Text('Scan QR Code'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanWithBeneficeryDetails()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: const [
                            Icon(FontAwesomeIcons.barcode),
                            SizedBox(width: 10),
                            Text('NID Scan'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: primaryColorGreenLite,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: currentTab == 0 ? Colors.white : Colors.black,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: currentTab == 0 ? Colors.white : Colors.black,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40,),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  CustomDialogs().showRegDialog(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      color: currentTab == 1 ? Colors.white : Colors.black,
                    ),
                    Text(
                      'Registration',
                      style: TextStyle(
                        color: currentTab == 1 ? Colors.white : Colors.black,
                        fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 28),
                    alignment: Alignment.center,
                    color: primaryPerpleColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Admin',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        const Text('Upokari Menu',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/1.15,
                  child: ListView.builder(
                    itemCount: naviBarList.length,
                    itemBuilder: (context,position){
                      return InkWell(

                        onTap: (){
                          setState(() {
                            selectedId = position;
                          });

                          switch(naviBarList[position].id){
                            case 2 :
                              qrScannerForCardDelivery();
                              Navigator.pop(context);
                              break;

                            case 4 :
                              Navigator.pop(context);
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>RegistrationForBenefRegister()));

                              if(GetStorage().read("user_type")=="W"){
                              }
                              break;

                            case 6 :
                              Navigator.pop(context);
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChangePassword()));

                              break;

                            case 8 :
                              Navigator.pop(context);
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsAndCondition()));
                              break;


                            case 10 :
                              Navigator.pop(context);
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>SupportTeamMessage()));
                              break;


                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedId==position?primaryPerpleColor:Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(naviBarList[position].icon,color : selectedId==position?Colors.white:Colors.grey[600]),
                                      const SizedBox(width: 24,),
                                      Text(naviBarList[position].title,style: TextStyle(color : selectedId==position?Colors.white:Colors.grey[600]),),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey[700],height: 1,),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: InkWell(
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
                      btnOkText: "Yes",
                      btnCancelText: "No",
                      btnOkColor: Colors.green,
                      btnCancelColor: Colors.red,
                      btnOkOnPress: () {
                        GetStorage().erase();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                      },
                      btnCancelOnPress: (){
                        Navigator.pop(context);
                      }
                  ).show();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: Row(
                    children: const [
                      Text("লগআউট",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                      Spacer(),
                      Icon(Icons.logout,color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<CustomNaviBarMenu> naviBarList = [

  CustomNaviBarMenu(title: 'হোম', id: 0, icon: Icons.home),
  CustomNaviBarMenu(title: 'প্রোফাইল', id: 1, icon: Icons.person),
  CustomNaviBarMenu(title: 'কার্ড বিতরণী ব্যবস্থাপনা', id: 2, icon: Icons.credit_card),
  CustomNaviBarMenu(title: 'ডিলার ব্যবস্থাপনা', id: 3, icon: Icons.manage_accounts),
  CustomNaviBarMenu(title: 'রেজিস্ট্রেশন ব্যবস্থাপনা', id: 4, icon: Icons.assessment),
  CustomNaviBarMenu(title: 'মনিটরিং', id: 5, icon: Icons.video_camera_back_rounded),
  // CustomNaviBarMenu(title: 'পাসওয়ার্ড পৰিৱৰ্তন', id: 6, icon: Icons.key),
  CustomNaviBarMenu(title: 'সেটিংস', id: 7, icon: Icons.settings),
  CustomNaviBarMenu(title: 'ব্যবহারের শর্তাবলী', id: 8, icon: Icons.verified_user),
  CustomNaviBarMenu(title: 'সচারচর জিজ্ঞাসা', id: 9, icon: Icons.announcement),
  CustomNaviBarMenu(title: 'আমাকে বলুন', id: 10, icon: Icons.ad_units_rounded),
  CustomNaviBarMenu(title: 'উপকারী আ্যপ সম্পর্কে জানুন', id: 11, icon: Icons.article),

];


