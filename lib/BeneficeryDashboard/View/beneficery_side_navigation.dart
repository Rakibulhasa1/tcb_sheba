import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/AdminDashboard/side_navigation_bar.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/BeneficeryDashboard/View/beneficery_dashboard.dart';
import 'package:tcb/BeneficeryDashboard/View/user_inbox.dart';
import 'package:tcb/BeneficeryDashboard/View/view_qr_and_profile.dart';
import 'package:tcb/BeneficeryDashboard/Widget/see_qr_data.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/app_theme.dart';
import 'package:tcb/select_profile_image.dart';
import 'package:tcb/show_toast.dart';


import 'package:http/http.dart'as http;

class BeneficerySideNavigation extends StatefulWidget {
  const BeneficerySideNavigation({Key? key}) : super(key: key);

  @override
  _BeneficerySideNavigationState createState() =>
      _BeneficerySideNavigationState();
}

class _BeneficerySideNavigationState extends State<BeneficerySideNavigation> {

  int selectedId=0;
  int currentTab = 0;
  bool isHasImage = false;


  List<Widget> myBottomNavigation = [
    BeneficeryDashboard(),
    UserInbox(),
  ];

  @override
  void initState() {
    Provider.of<BeneficiaryInfoController>(context,listen: false).getData("${GetStorage().read('beneficiaryId')}",GetStorage().read('b_token'),false);
    HelperClass().checkVersion(context);
    super.initState();
  }

  Future qrScanner()async{
    var camaraPermission = await Permission.camera.status;
    if(camaraPermission.isGranted){
      String? qrCode = await scanner.scan();
      if(qrCode!=null){
        getQrScanData(qrCode);
      }else{
        ShowToast.myToast('QR Code has No data', Colors.black, 2);
      }
    }else{
      var isGrandt  = await Permission.camera.request();
      if(isGrandt.isGranted){
        String? qrCode = await scanner.scan();
        if(qrCode!=null){
          getQrScanData(qrCode);
        }else{
          ShowToast.myToast('QR Code has No data', Colors.black, 2);
        }
      }
    }
  }

  Future<int> validateImage(String imageUrl) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(ApiEndPoints().imageBaseUrl+imageUrl));
      print(res.statusCode);
    } catch (e) {
      print('500');
      return 500;
    }

    if(res.statusCode==200){
      return 200;
    }else{
      return res.statusCode;
    }
  }

  void getQrScanData(String qrCodeData){
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>SeeQrData(qrCode: qrCodeData)));
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BeneficiaryInfoController>(
      builder: (context,data,child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('স্বাগতম!',style: TextStyle(fontSize: 20)),
                Text('হাতের মুঠোয় টিসিবি সেবা',style: TextStyle(fontSize: 12)),
              ],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
              Builder(
                builder: (context) {
                  if(data.getUserDataResponse.isWorking!){
                    return Container();
                  }
                  if(data.getUserDataResponse.responseError!){
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewQRandProfile()));
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${ApiEndPoints().imageBaseUrl}${data.userData!.beneficiaryImageFile}'),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
          body:Consumer<BeneficiaryInfoController>(
            builder: (context,data,child) {
              if(data.getUserDataResponse.isWorking!){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(data.getUserDataResponse.responseError!){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 180),
                      Text('Something is wrong',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold)),
                      MaterialButton(
                        color: Colors.deepOrangeAccent,
                        onPressed: (){
                          GetStorage().remove('b_token');
                          GetStorage().remove('userType');
                          GetStorage().remove('user_id');
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                        },
                        child: Text('Go Back'),
                      ),
                    ],
                  ),
                );
              }
              // if(!data.getUserDataResponse.isWorking!&&!data.getUserDataResponse.responseError!){
              //   Future.delayed(Duration.zero).then((value){
              //     validateImage(data.userData!.beneficiaryImageFile).then((value){
              //       if(value==404){
              //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SelectProfileImage()), (Route<dynamic> route) => false);
              //       }
              //     });
              //   });
              // }
              return myBottomNavigation[currentTab];
            },
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: Builder(
                      builder: (context) {
                        if(data.getUserDataResponse.isWorking!){
                          return Container();
                        }
                        if(data.getUserDataResponse.responseError!){
                          return Container();
                        }
                        return Column(
                          children: [
                            SizedBox(height: 24,),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage('${ApiEndPoints().imageBaseUrl}${data.userData!.beneficiaryImageFile}'),
                            ),
                            SizedBox(height: 24,),
                            Text(data.userData!.beneficiaryNameBangla,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            Text('NID ${data.userData!.nidNumber}',style: TextStyle(fontSize: 10),),
                            Text('Family Card ${data.userData!.familyCardNumber}',style: TextStyle(fontSize: 10),),
                          ],
                        );
                      }
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: naviBarList.length,
                    itemBuilder: (context,position){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            selectedId = position;
                          });

                          switch(selectedId){
                            case 0 :
                              setState(() {
                                currentTab = 0;
                              });
                              Navigator.pop(context);
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
                  Spacer(),
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
                            GetStorage().remove('b_token');
                            GetStorage().remove('userType');
                            GetStorage().remove('user_id');

                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                          },
                          btnCancelOnPress: (){

                          }
                      ).show();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.power_settings_new,color: Colors.grey[600]),
                                  const SizedBox(width: 24,),
                                  Text('Logout',style: TextStyle(color : Colors.grey[600]),),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[700],height: 1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            isExtended: true,
            child: const Icon(Icons.qr_code,color: Color(0xffFF0101),),
            onPressed: () {
              qrScanner();
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
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
                          Icons.contacts,
                          color: currentTab == 0 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'কন্টাক্টস',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.forward_to_inbox,
                          color: currentTab == 1 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'ইনবক্স',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}


List<CustomNaviBarMenu> naviBarList = [

  CustomNaviBarMenu(title: 'হোম', id: 0, icon: Icons.home),
  CustomNaviBarMenu(title: 'প্রোফাইল', id: 1, icon: Icons.person),
  CustomNaviBarMenu(title: 'ক্যালেন্ডার', id: 2, icon: Icons.calendar_today),
  CustomNaviBarMenu(title: 'ট্রানজেকশন', id: 3, icon: Icons.compare_arrows),
  CustomNaviBarMenu(title: 'যোগাযোগ', id: 4, icon: Icons.trending_up),
  CustomNaviBarMenu(title: 'সেটিংস', id: 5, icon: Icons.settings),
  CustomNaviBarMenu(title: 'সাপোর্ট', id: 5, icon: Icons.lightbulb),
];