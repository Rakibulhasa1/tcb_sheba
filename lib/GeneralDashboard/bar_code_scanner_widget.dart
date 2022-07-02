import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

class BarCodeScannerWidget extends StatefulWidget {
  BarCodeScannerWidget({Key? key}) : super(key: key);

  @override
  State<BarCodeScannerWidget> createState() => _BarCodeScannerWidgetState();
}

class _BarCodeScannerWidgetState extends State<BarCodeScannerWidget> {
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
        onError: (context, error) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        formats: const [BarcodeFormats.ALL_FORMATS],
        fit: BoxFit.cover,
      ),
    );
  }
}
