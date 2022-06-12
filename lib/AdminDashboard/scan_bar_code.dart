import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:tcb/main.dart';

class ScanBarCode extends StatefulWidget {
  const ScanBarCode({Key? key}) : super(key: key);

  @override
  _ScanBarCodeState createState() => _ScanBarCodeState();
}

class _ScanBarCodeState extends State<ScanBarCode> {

  QRReaderController? controller;

  @override
  void initState() {
    super.initState();
    controller = QRReaderController(cameras![0], ResolutionPreset.medium, [CodeFormat.qr], (dynamic value){
      print(value); // the result!
      Future.delayed(const Duration(seconds: 3), controller!.startScanning);
    });
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller!.startScanning();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return QRReaderPreview(controller);
  }
}
