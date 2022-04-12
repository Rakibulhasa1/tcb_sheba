import 'package:flutter/material.dart';

class SeeQrData extends StatelessWidget {
  final String qrCode;
  const SeeQrData({Key? key,required this.qrCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scan Result')),
      body: Center(
        child: Text(qrCode.toString(),style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold)),
      ),
    );
  }
}
