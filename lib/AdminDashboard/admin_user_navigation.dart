
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:tcb/AdminDashboard/admin_dashboard.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_for_beneficery_details.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_registration.dart';
import 'package:tcb/AdminDashboard/card_delivery_details.dart';
import 'package:tcb/AdminDashboard/side_navigation_bar.dart';
import 'package:tcb/AdminDashboard/user_details_view_by_admin.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/app_theme.dart';
import 'package:tcb/change_password.dart';

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
    HelperClass().checkVersion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Material(
          color: primaryColorGreenLite,
          elevation: 3.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            alignment: Alignment.bottomCenter,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('asstes/freedom50.png',height: 30,),
                    Image.asset('asstes/mainLogo.png',height: 30,),
                    Image.asset('asstes/mujib100.png',height: 30,),
                  ],
                ),
                Spacer(),
                const SizedBox(height: 12,),
                Text('হাতের মুঠোয় টিসিবি পণ্য',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.grey[100]),),
              ],
            ),
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
                child: const Text('TCB Menu',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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

                        case 15 :
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChangePassword()));
                          break;

                        case 16 :
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
                                  const Spacer(),
                                  Builder(
                                    builder: (context) {
                                      switch (naviBarList[position].id){
                                        case 2 :
                                          return Icon(Icons.arrow_forward_outlined,color : selectedId==position?Colors.white:Colors.grey[600]);
                                        case 3 :
                                          return Icon(Icons.arrow_forward_outlined,color : selectedId==position?Colors.white:Colors.grey[600]);
                                        case 4 :
                                          return Icon(Icons.arrow_forward_outlined,color : selectedId==position?Colors.white:Colors.grey[600]);
                                        case 6 :
                                          return Icon(Icons.arrow_forward_outlined,color : selectedId==position?Colors.white:Colors.grey[600]);
                                        case 7 :
                                          return Icon(Icons.arrow_forward_outlined,color : selectedId==position?Colors.white:Colors.grey[600]);
                                        case 8 :
                                          return Icon(Icons.arrow_forward_outlined,color : selectedId==position?Colors.white:Colors.grey[600]);
                                      }
                                      return Container();
                                    }
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context){
                                switch (naviBarList[position].id){
                                  case 2 :
                                    return selectedId==position?ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: naviSubMenuForBeneficery.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: InkWell(
                                            onTap: (){
                                              switch(naviSubMenuForProductMenupolation[position].id){
                                                case 0 :
                                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanWithRegister()));
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(naviSubMenuForBeneficery[position].title,style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },):Container();
                                  case 3 :
                                    return selectedId==position?ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: naviSubMenuForProductMenupolation.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: InkWell(
                                            onTap: (){

                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(naviSubMenuForProductMenupolation[position].title,style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },):Container();
                                  case 4 :
                                    return selectedId==position?ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: naviSubMenuForSellMenupolation.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: InkWell(
                                            onTap: (){},
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(naviSubMenuForSellMenupolation[position].title,style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },):Container();
                                  case 6 :
                                    return selectedId==position?ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: naviSubMenuForInventory.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: InkWell(
                                            onTap: (){},
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(naviSubMenuForInventory[position].title,style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },):Container();
                                  case 7 :
                                    return selectedId==position?ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: naviSubMenuForDelarMenupulation.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: InkWell(
                                            onTap: (){},
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(naviSubMenuForDelarMenupulation[position].title,style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },):Container();
                                  case 8 :
                                    return selectedId==position?ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: naviSubMenuForMonitoring.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: InkWell(
                                            onTap: (){},
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(naviSubMenuForMonitoring[position].title,style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },):Container();
                                }
                                return Container();
                              },
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
  CustomNaviBarMenu(title: 'উপকারভোগী', id: 2, icon: Icons.person),
  CustomNaviBarMenu(title: 'ফ্যামিলি কার্ড', id: 3, icon: Icons.payment),
  CustomNaviBarMenu(title: 'পণ্য ব্যবস্থাপনা', id: 4, icon: Icons.view_in_ar),
  CustomNaviBarMenu(title: 'বিক্রয় ব্যবস্থপনা', id: 5, icon: Icons.trending_up),
  CustomNaviBarMenu(title: 'চাহিদাপত্র', id: 6, icon: Icons.task),
  CustomNaviBarMenu(title: 'ইনভেন্টরী', id: 7, icon: Icons.inventory),
  CustomNaviBarMenu(title: 'ডিলার ব্যবস্থাপনা', id: 8, icon: Icons.manage_accounts),
  CustomNaviBarMenu(title: 'মনিটরিং', id: 9, icon: Icons.legend_toggle),
  CustomNaviBarMenu(title: 'ব্যবহারকারী ব্যবস্থাপনা', id: 10, icon: Icons.manage_accounts),
  CustomNaviBarMenu(title: 'অভিযোগ ও প্রতিকার', id: 11, icon: Icons.announcement),
  CustomNaviBarMenu(title: 'যোগাযোগ', id: 12, icon: Icons.compare_arrows),
  CustomNaviBarMenu(title: 'সেটিংস', id: 13, icon: Icons.settings),
  CustomNaviBarMenu(title: 'সাপোর্ট', id: 14, icon: Icons.contact_support),
  CustomNaviBarMenu(title: 'চেঞ্জ পাসওয়ার্ড', id: 15, icon: Icons.key),
  CustomNaviBarMenu(title: 'লগআউট', id: 16, icon: Icons.power_settings_new),

];

List<NaviBarSubMenu> naviSubMenuForBeneficery = [
  NaviBarSubMenu(title: 'নতুন আবেদন', rootId: 2, id: 0),
  NaviBarSubMenu(title: 'সকল', rootId: 2, id: 1),
  NaviBarSubMenu(title: 'এডিটেড', rootId: 2, id: 2),
];


List<NaviBarSubMenu> naviSubMenuForProductMenupolation = [
  NaviBarSubMenu(title: 'ধাপ নির্ধারণ', rootId: 3, id: 0),
  NaviBarSubMenu(title: 'পণ্যের পরিনাণ', rootId: 3, id: 1),
];

List<NaviBarSubMenu> naviSubMenuForSellMenupolation = [
  NaviBarSubMenu(title: 'ক্যালেন্ডার', rootId: 4, id: 0),
  NaviBarSubMenu(title: 'ডিলার ও ট্রাকসেল', rootId: 4, id: 1),
  NaviBarSubMenu(title: 'ট্যাগটীম', rootId: 4, id: 2),
];

List<NaviBarSubMenu> naviSubMenuForInventory = [
  NaviBarSubMenu(title: 'মজুদ', rootId: 6, id: 0),
  NaviBarSubMenu(title: 'গুদাম', rootId: 6, id: 1),
  NaviBarSubMenu(title: 'আনসোল্ড', rootId: 6, id: 2),
];

List<NaviBarSubMenu> naviSubMenuForDelarMenupulation = [
  NaviBarSubMenu(title: 'নতুন আবেদন', rootId: 7, id: 0),
  NaviBarSubMenu(title: 'সকল', rootId: 7, id: 1),
  NaviBarSubMenu(title: 'অনুমোদিত', rootId: 7, id: 2),
];

List<NaviBarSubMenu> naviSubMenuForMonitoring = [
  NaviBarSubMenu(title: 'কমিটি', rootId: 8, id: 0),
  NaviBarSubMenu(title: 'অথরাইজড অফিসার', rootId: 8, id: 1),
  NaviBarSubMenu(title: 'ট্যাগটীম', rootId: 8, id: 2),
];

