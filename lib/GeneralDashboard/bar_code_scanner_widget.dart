import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'package:tcb/GeneralDashboard/user_from.dart';
import 'package:tcb/GeneralDashboard/user_from_v2.dart';

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
      body: Builder(
        builder: (context){
          if(value!=null){
            if(value!.length>80){
              if(value!.contains('<pin>')){
                String nid = '';
                try{
                  nid = value!.substring( value!.indexOf("<pin>")+5,value!.indexOf("</pin>"));
                }catch(e){

                }


                return UserFromV2(qrCode: nid, isQR: 3);
              }else{
                String newNid = '';

                try{
                  newNid = value!.substring( value!.indexOf("NW")+2, value!.indexOf("OL")-1);
                }catch(e){

                }

                return UserFromV2(qrCode: newNid, isQR: 3);
              }
            }else{
              return Center(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Something is wrong",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Text('Please Try Again',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }else{
            return QrCamera(
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
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Something is wrong",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Text('Please Try Again',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              formats: const [BarcodeFormats.ALL_FORMATS],
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );
  }
}
