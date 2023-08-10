import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'package:tcb/AdminDashboard/admin_registration.dart';

class AdminScanResultForRegistration extends StatefulWidget {
  const AdminScanResultForRegistration({Key? key}) : super(key: key);

  @override
  _AdminScanResultForRegistrationState createState() => _AdminScanResultForRegistrationState();
}

class _AdminScanResultForRegistrationState extends State<AdminScanResultForRegistration> {

  int status = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registation")),
      body: QrCamera(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
              child: Text("জাতীয় পরিচয়পত্রের পিছনের পৃষ্ঠার বারকোড স্ক্যান করুন",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height/2,
                width: 1,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        qrCodeCallback: (value){
          setState(() {
            if(value!.isNotEmpty&&status==0){
              setState((){
                status = 1;
              });
            }
            if(status==1){
              setState((){
                status = 2;
              });
              Navigator.pop(context);
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>AdminRegistration(beneficeryValue: value)));
            }
          });
        },
        onError: (context, error){
          return Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Something is wrong\nTry Again",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            ),
          );
        },
        formats: const [BarcodeFormats.PDF417],
        fit: BoxFit.cover,
      ),
    );
  }
}
