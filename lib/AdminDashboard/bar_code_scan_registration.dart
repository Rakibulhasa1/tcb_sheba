import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

class BarCodeScanWithRegister extends StatefulWidget {
  BarCodeScanWithRegister({Key? key}) : super(key: key);

  @override
  State<BarCodeScanWithRegister> createState() => _BarCodeScanWithRegisterState();
}

class _BarCodeScanWithRegisterState extends State<BarCodeScanWithRegister> {
  String? value;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scan'),
      ),
      body: value!=null?Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            Text('$value'),
          ],
        ),
      ):QrCamera(
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2,top: MediaQuery.of(context).size.height/8),
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height/1.5,
            width: 1,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
        ),
        qrCodeCallback: (value){
          print(value);
          setState(() {
            this.value = value;
          });
        },
        onError: (context, error){
          return Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        formats: const [BarcodeFormats.ALL_FORMATS],
        fit: BoxFit.cover,
      ),
    );
  }
}
