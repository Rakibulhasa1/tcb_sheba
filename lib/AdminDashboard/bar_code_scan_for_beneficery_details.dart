import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'package:tcb/AdminDashboard/user_details_view_by_admin.dart';

class BarCodeScanWithBeneficeryDetails extends StatefulWidget {
  BarCodeScanWithBeneficeryDetails({Key? key}) : super(key: key);

  @override
  State<BarCodeScanWithBeneficeryDetails> createState() => _BarCodeScanWithBeneficeryDetailsState();
}

class _BarCodeScanWithBeneficeryDetailsState extends State<BarCodeScanWithBeneficeryDetails> {
  String? value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Builder(
        builder: (context){
          if(value!=null){
            if(value!.contains('<pin>')){
              print(value);
              String nid = '';

              try{
                nid = value!.substring( value!.indexOf("<pin>")+5,value!.indexOf("</pin>"));
              }catch(e){

              }


              return UserDetailsViewByAdmin(userId: nid, isScan: true);
            }else{
              String newNid = '';

              try{
                newNid = value!.substring( value!.indexOf("NW")+2, value!.indexOf("OL")-1);
              }catch(e){

              }
              return UserDetailsViewByAdmin(userId: newNid, isScan: true);
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
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Something is wrong\nTry Again",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
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


class CustomButton extends StatelessWidget {

  final String title;
  bool isSelected;


  CustomButton({Key? key,required this.title, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: isSelected? Colors.green : Colors.grey[200],
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Text(title,style: TextStyle(color: isSelected?Colors.white:Colors.grey[700]),),
      ),
    );
  }
}


