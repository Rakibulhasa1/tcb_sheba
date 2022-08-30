
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';
import 'package:tcb/AdminDashboard/admin_dashboard.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_for_beneficery_details.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_registration.dart';
import 'package:tcb/AdminDashboard/card_delivery_details.dart';
import 'package:tcb/AdminDashboard/side_navigation_bar.dart';
import 'package:tcb/AdminDashboard/submit_for_registration.dart';
import 'package:tcb/AdminDashboard/user_details_view_by_admin.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/app_theme.dart';
import 'package:tcb/change_password.dart';
import 'package:tcb/support_team_message.dart';
import 'package:tcb/terms_and_condition.dart';

class WardCounsilorUserNavigation extends StatefulWidget {

  const WardCounsilorUserNavigation({Key? key}) : super(key: key);

  @override
  _WardCounsilorUserNavigationState createState() => _WardCounsilorUserNavigationState();
}

class _WardCounsilorUserNavigationState extends State<WardCounsilorUserNavigation> {

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
    HelperClass().checkVersion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
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
        backgroundColor: primaryPerpleColor,
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
                    SizedBox(height: 24),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        qrScannerForUserDetails();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Icon(Icons.qr_code),
                            SizedBox(width: 10),
                            Text('Scan QR Code'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanWithBeneficeryDetails()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
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
                  scaffolKey.currentState!.openDrawer();
                  setState(() {
                    //currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.menu,
                      color: currentTab == 1 ? Colors.white : Colors.black,
                    ),
                    Text(
                      'Menu',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 28),
                alignment: Alignment.center,
                color: primaryPerpleColor,
                child: const Text('Upokari Menu',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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

                      switch(selectedId){
                        case 1 :
                          qrScannerForCardDelivery();
                          Navigator.pop(context);
                          break;

                        case 2 :
                          Navigator.pop(context);
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanWithRegister()));
                          break;

                        case 5 :
                          Navigator.pop(context);
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsAndCondition()));
                          break;

                        case 7 :
                          Navigator.pop(context);
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>SupportTeamMessage()));
                          break;

                        case 8 :
                          Navigator.pop(context);
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChangePassword()));
                          break;

                        case 9 :
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
                                GetStorage().remove('userType');
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                              },
                              btnCancelOnPress: (){
                                Navigator.pop(context);
                              }
                          ).show();
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
      ),
    );
  }
}

List<CustomNaviBarMenu> naviBarList = [

  CustomNaviBarMenu(title: 'হোম', id: 0, icon: Icons.home),
  CustomNaviBarMenu(title: 'কার্ড বিতরণী ব্যবস্থাপনা', id: 1, icon: Icons.credit_card),
  CustomNaviBarMenu(title: 'উপকারভোগী রেজিস্ট্রশন', id: 2, icon: Icons.person),
  CustomNaviBarMenu(title: 'মনিটরিং', id: 3, icon: Icons.legend_toggle),
  CustomNaviBarMenu(title: 'ডিলার রিপোর্ট', id: 4, icon: Icons.manage_accounts),
  CustomNaviBarMenu(title: 'Terms And Condition', id: 5, icon: Icons.verified_user),
  CustomNaviBarMenu(title: 'সাপোর্ট', id: 6, icon: Icons.contact_support),
  CustomNaviBarMenu(title: 'আমাকে বলুন', id: 7, icon: Icons.announcement),
  CustomNaviBarMenu(title: 'চেঞ্জ পাসওয়ার্ড', id: 8, icon: Icons.key),
  CustomNaviBarMenu(title: 'লগআউট', id: 9, icon: Icons.power_settings_new),

];
