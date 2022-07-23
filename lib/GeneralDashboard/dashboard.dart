import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/GeneralDashboard/bar_code_scanner_widget.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/Model/DashboardModel.dart';
import 'package:tcb/AdminDashboard/beneficary_list_view.dart';
import 'package:tcb/show_toast.dart';
import 'package:tcb/GeneralDashboard/user_from.dart';

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
    DataResponse().getAdminData(context: context,prams: '?start=${DateTime(2022,03,01)}&end=${DateTime.now()}');
    super.initState();
  }



  void getDashboardValue(){
    ApiController().getResponse(token: GetStorage().read('token'), endPoint: ApiEndPoints().dashboard).then((value) {
      setState(() {
        if(value.responseCode==200){
          try{
            dashboardModel = dashboardModelFromJson(value.response.toString());
            data = dashboardModel!.data;
            notifyData = ApiResponse(
              isWorking: false,
              responseError: false,
            );
          }
          catch(e){
            notifyData = ApiResponse(
              isWorking: false,
              responseError: true,
            );
          }
        }else{
          notifyData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
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
              children: const [
                Text('স্বাগতম!',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                Text('হাতের মুঠোয় টিসিবি পণ্য ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap : (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>const BeneficaryListView(isBeneficiaryList: true,title: 'উপকারভোগীর সংখ্যা',)));
                },
                child: Container(
                  height: 100,
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
                          child : Text('উপকারভোগীর সংখ্যা',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                        Consumer<DashboardController>(
                            builder: (context,notifyData,child) {
                              if(notifyData.notifyDashboardData.isWorking!){
                                return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                              }
                              if(notifyData.notifyDashboardData.responseError!){
                                return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                              }
                              return Text(notifyData.data!.totalBeneficiary,style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              GestureDetector(
                onTap : (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>const BeneficaryListView(isBeneficiaryList: false,title: 'সুবিধাপ্রাপ্ত উপকারভোগী',)));
                },
                child: Container(
                  height: 100,
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
                          child: Text('সুবিধাপ্রাপ্ত উপকারভোগী',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
          child: InkWell(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScannerWidget()));
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
                          hintText: 'এস এম এস ওটিপি',
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
    );
  }
}
