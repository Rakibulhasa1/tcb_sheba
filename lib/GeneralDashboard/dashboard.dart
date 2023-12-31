import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:tcb/AdminDashboard/Model/step_list_model.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/GeneralDashboard/bar_code_scan_user_update.dart';
import 'package:tcb/GeneralDashboard/bar_code_scanner_widget.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/MasterApiController.dart';
import 'package:tcb/Model/DashboardModel.dart';
import 'package:tcb/AdminDashboard/beneficary_list_view.dart';
import 'package:tcb/show_toast.dart';
import 'package:tcb/GeneralDashboard/user_from.dart';

import '../AdminDashboard/Controller/PramsController.dart';
import '../AdminDashboard/admin_dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  TextEditingController nidController = TextEditingController();
  TextEditingController smsController = TextEditingController();

  DashboardModel? dashboardModel;
  DashboardData? data;

  ApiResponse notifyData = ApiResponse(
    isWorking: true,
  );

  String? nidText;
  String? smsText;

  Future barCodeScan()async{

  }


  Future qrScanner()async{
    var camaraPermission = await Permission.camera.status;
    if(camaraPermission.isGranted){
      String? qrCode = await scanner.scan();
      if(qrCode!=null){
        getQrScanData(qrCode,1);
      }else{
        ShowToast.myToast('QR Code has No data', Colors.black, 2);
      }
    }else{
      var isGrandt  = await Permission.camera.request();
      if(isGrandt.isGranted){
        String? qrCode = await scanner.scan();
        if(qrCode!=null){
          getQrScanData(qrCode,1);
        }else{
          ShowToast.myToast('QR Code has No data', Colors.black, 2);
        }
      }
    }
  }




  void getQrScanData(String qrCodeData,int isQR){
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserFrom(qrCode: qrCodeData,isQR : isQR)));
  }

  @override
  void initState() {
    Provider.of<DashboardController>(context,listen: false).getStepData();
    DataResponse().getAdminData(context: context,prams: '?start=${DateTime(2021,03,01)}&end=${DateTime.now()}');
    super.initState();
  }

  List<AreaWiseData> testDivisionData = [
    AreaWiseData(areaName: '-', beneficiaryTotalQty: 0,receiverTotalQty: 0),
    AreaWiseData(areaName: '-', beneficiaryTotalQty: 0,receiverTotalQty: 0),
    AreaWiseData(areaName: '-', beneficiaryTotalQty: 0,receiverTotalQty: 0),
  ];


  List<TimerList> dateTimeSetList = [
    TimerList(title: 'Till Today', startData: DateTime(2022,03,01),endData: DateTime.now()),
    TimerList(title: 'Today', startData: DateTime.now(),endData: DateTime.now()),
    TimerList(title: 'Yesterday', startData: DateTime.now().subtract(const Duration(days: 1)),endData: DateTime.now()),
    TimerList(title: HelperClass.convertAsMonthYear(DateTime(DateTime.now().year, DateTime.now().month-1, 1).toString()), startData: DateTime(DateTime.now().year, DateTime.now().month-1, 1),endData: DateTime(DateTime.now().year, DateTime.now().month, 0)),
    TimerList(title: HelperClass.convertAsMonthYear(DateTime.now().toString()), startData: DateTime(DateTime.now().year, DateTime.now().month, 1),endData: DateTime(DateTime.now().year, DateTime.now().month+1, 0)),
    TimerList(title: HelperClass.convertAsMonthYear(DateTime(DateTime.now().year, DateTime.now().month+1, 1).toString()), startData: DateTime(DateTime.now().year, DateTime.now().month+1, 1),endData: DateTime(DateTime.now().year, DateTime.now().month+2, 0)),
    TimerList(title: HelperClass.convertAsMonthYear(DateTime(DateTime.now().year, DateTime.now().month+2, 1).toString()), startData: DateTime(DateTime.now().year, DateTime.now().month+2, 1),endData: DateTime(DateTime.now().year, DateTime.now().month+3, 0)),
  ];


  TimerList? dateTimeSatData;

  TimerList? defaultDate = TimerList(title: 'Till Today', startData: DateTime(2022,03,01),endData: DateTime.now());


  List<StepModel> stepList = [];
  int status = 1;


  StepModel? selectStep = StepModel(stepName: 'ধাপ নির্বাচন করুন',stepId: null,createdBy: '',deliveryEndDateTime: '',deliveryStartDateTime: '');


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        DataResponse().getAdminData(context: context,prams: '?start=${DateTime(2021,03,01)}&end=${DateTime.now()}');
        await Future.delayed(Duration(seconds: 2));
      },
      child: ListView(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 24,left: 18,bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('স্বাগতম!',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  Consumer<UserInfoController>(
                    builder: (context,data,child) {
                      return Text(data.userInfoModel!.data!.userInfo!.userFullName,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),);
                    }
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text('Till Today',style: TextStyle(fontSize: 12)),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: dateTimeSatData,
                        items: dateTimeSetList.map((TimerList items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items.title,style: TextStyle(fontSize: 12)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            dateTimeSatData = newValue! as TimerList?;
                            if(selectStep!.stepId!=null){
                              String prams = '?start=${dateTimeSatData!.startData}&end=${dateTimeSatData!.endData}&step_id=${selectStep!.stepId}';
                              DataResponse().getAdminData(context: context,prams: prams);
                              Provider.of<PramsController>(context,listen: false).setGlobalPrams('?start=${dateTimeSatData!.startData}&end=${dateTimeSatData!.endData}&step_id=${selectStep!.stepId}');

                            }else{
                              String prams = '?start=${dateTimeSatData!.startData}&end=${dateTimeSatData!.endData}';
                              DataResponse().getAdminData(context: context,prams: prams);
                              Provider.of<PramsController>(context,listen: false).setGlobalPrams('?start=${dateTimeSatData!.startData}&end=${dateTimeSatData!.endData}');

                            }
                          });

                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Consumer<DashboardController>(
                      builder: (context,notifyData,child) {
                        if(notifyData.notifyDropDown.isWorking!){
                          notifyData.stepModel.clear();
                          return Container();
                        }
                        if(notifyData.notifyDropDown.responseError!){
                          return Container();
                        }
                        if(!notifyData.notifyDropDown.responseError!&&!notifyData.notifyDropDown.isWorking!){
                          stepList = notifyData.stepModel;
                          if(stepList.isNotEmpty&&status==1){
                            DataResponse().getAdminData(context: context,prams: '?start=${DateTime(2022,03,01)}&end=${DateTime.now()}');
                            Provider.of<PramsController>(context,listen: false).setGlobalPrams('?start=${DateTime(2022,03,01)}&end=${DateTime.now()}');
                          }
                          status=2;
                        }
                        return Container(
                          height: 38,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text('${selectStep!.stepName}',style: TextStyle(fontSize: 12)),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: stepList.map((StepModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.stepName,style: TextStyle(fontSize: 12)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectStep = newValue! as StepModel?;
                                });

                                setState(() {
                                  if(dateTimeSatData!=null){
                                    String prams = '?start=${dateTimeSatData!.startData}&end=${dateTimeSatData!.endData}&step_id=${selectStep!.stepId}';
                                    DataResponse().getAdminData(context: context,prams: prams);
                                    Provider.of<PramsController>(context,listen: false).setGlobalPrams('?start=${dateTimeSatData!.startData}&end=${dateTimeSatData!.endData}&step_id=${selectStep!.stepId}');

                                  }else{
                                    String prams = '?start=${defaultDate!.startData}&end=${defaultDate!.endData}&step_id=${selectStep!.stepId}';
                                    DataResponse().getAdminData(context: context,prams: prams);
                                    Provider.of<PramsController>(context,listen: false).setGlobalPrams('?start=${defaultDate!.startData}&end=${defaultDate!.endData}&step_id=${selectStep!.stepId}');

                                  }
                                });
                              },
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap : (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>BeneficaryListView(isBeneficiaryList: true,title: 'উপকারভোগীর সংখ্যা',)));
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child : Text('উপকারভোগী সংখ্যা/\nবরাদ্ধ সংখ্যা',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Consumer<DashboardController>(
                                builder: (context,notifyData,child) {
                                  if(notifyData.notifyDashboardData.isWorking!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  if(notifyData.notifyDashboardData.responseError!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  return Text("${notifyData.data!.totalBeneficiary}",style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap : (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=> BeneficaryListView(isBeneficiaryList: false,title: 'সুবিধাপ্রাপ্ত উপকারভোগী')));
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child: Text('সুবিধাপ্রাপ্ত উপকারভোগী\nসংখ্যা',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Consumer<DashboardController>(
                                builder: (context,notifyData,child) {
                                  if(notifyData.notifyDashboardData.isWorking!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  if(notifyData.notifyDashboardData.responseError!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  return Text(notifyData.data!.totalReceiver,style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),);
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            child: InkWell(
              onTap: (){
                qrScanner();
              },
              child: Container(
                alignment: Alignment.center,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.qr_code,color: Colors.white,size: 48,),
                    SizedBox(width: 24,),
                    Text('QR Code স্ক্যান করুন',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
          // Consumer<MasterApiController>(
          //   builder: (context,data,child) {
          //     if(data.masterData!.nidScanDelivery=="1"){
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
          //         child: InkWell(
          //           onTap: (){
          //             Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScannerWidget()));
          //           },
          //           child: Container(
          //             alignment: Alignment.center,
          //             height: 90,
          //             decoration: BoxDecoration(
          //               color: Colors.purple.withOpacity(0.6),
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: const [
          //                 Icon(FontAwesomeIcons.barcode,color: Colors.white,size: 38,),
          //                 SizedBox(width: 24,),
          //                 Text('NID Barcode স্ক্যান করুন',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     }else{
          //       return Container();
          //     }
          //
          //   }
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            child: InkWell(
              onTap: (){
                //Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScannerWidget()));
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanUserUpdate()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.barcode,color: Colors.white,size: 38,),
                    SizedBox(width: 24,),
                    Text('NID Barcode স্ক্যান করুন',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
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
                    Flexible(

                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                            hintText: 'পরিচয়পত্র খুজুন',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12)
                        ),
                        controller: nidController,
                        onChanged: (value){
                          setState(() {
                            nidText = value;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserFrom(qrCode: "${nidText!}",isQR: 3,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Icon(nidText==''?Icons.search:Icons.send,size: 20,color: Colors.grey[600],),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
            child: Material(
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
                    Flexible(
                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                            hintText: 'ওটিপি ভেরিফিকেশন',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12)
                        ),
                        controller: smsController,
                        onChanged: (value){
                          setState(() {
                            smsText = value;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserFrom(qrCode: smsController.text,isQR: 4,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Icon(smsText==''?Icons.search:Icons.send,size: 20,color: Colors.grey[600],),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
