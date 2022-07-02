import 'package:flutter/material.dart';

class ScanBarCode extends StatefulWidget {
  String result;
  ScanBarCode({Key? key,required this.result}) : super(key: key);

  @override
  _ScanBarCodeState createState() => _ScanBarCodeState();
}

class _ScanBarCodeState extends State<ScanBarCode> {


  String oldNid = '';
  String newNid = '';
  String dateOfBirth = '';
  String fullName = '';

  @override
  void initState() {
    try{
      newNid = widget.result.substring( widget.result.indexOf("NW")+2, widget.result.indexOf("OL")-1);
      oldNid = widget.result.substring( widget.result.indexOf("OL")+2,widget.result.indexOf("BR")-1);
      dateOfBirth = widget.result.substring( widget.result.indexOf("BR")+2,widget.result.indexOf("PE")-1);
      fullName = widget.result.substring( widget.result.indexOf("NM")+2,widget.result.indexOf("NW")-1);
    }catch(e){

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
              child: Text('New ID Number : ${newNid}\nOld ID Number : ${oldNid}\nDate Of Birth : ${dateOfBirth}\nName : ${fullName}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
              child: Text('All Result ${widget.result}'),
            ),
          ],
        ),
      ),
    );
  }

}
