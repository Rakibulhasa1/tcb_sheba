import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/show_toast.dart';

class ViewQRandProfile extends StatefulWidget {
  const ViewQRandProfile({Key? key}) : super(key: key);

  @override
  State<ViewQRandProfile> createState() => _ViewQRandProfileState();
}

class _ViewQRandProfileState extends State<ViewQRandProfile> {

  Uint8List? image;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Consumer<BeneficiaryInfoController>(
          builder: (context,data,child) {
            return ListView(
              children: [
                SizedBox(
                  height: 250,
                  child: Builder(
                      builder: (context) {
                        if(data.getUserDataResponse.isWorking!){
                          return Container();
                        }
                        if(data.getUserDataResponse.responseError!){
                          return Container();
                        }
                        return Column(
                          children: [
                            SizedBox(height: 24,),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage('${ApiEndPoints().imageBaseUrl}${data.userData!.beneficiaryImageFile}'),
                            ),
                            SizedBox(height: 24,),
                            Text(data.userData!.beneficiaryNameBangla,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            Text('NID ${data.userData!.nidNumber}',style: TextStyle(fontSize: 10),),
                            Text('Family Card ${data.userData!.familyCardNumber}',style: TextStyle(fontSize: 10),),
                          ],
                        );
                      }
                  ),
                ),
                Screenshot(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: QrImage(
                        data: "Mobile : ${data.userData!.beneficiaryMobile},NID :-${data.userData!.nidNumber}",
                        version: QrVersions.auto,
                        size: 250.0,
                      ),
                    ),
                  ),
                  controller: screenshotController,
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: (){
                          screenshotController.capture().then((Uint8List? image)async{
                            if (image != null) {
                              final directory = await getApplicationDocumentsDirectory();
                              final imagePath = await File('${directory.path}/beneficiaryQR.png').create();
                              await imagePath.writeAsBytes(image);
                              GallerySaver.saveImage(imagePath.path,albumName: 'downloads').then((value){
                                if(value!){
                                  ShowToast.myToast('Beneficiary QR save in download folder', Colors.black, 2);
                                }else{
                                  ShowToast.myToast("Something is wrong\nCan't download", Colors.black, 2);
                                }
                              });
                            }
                          });

                        },
                        child: Row(
                          children: [
                            Text('Download',style: TextStyle(color: Colors.white,fontSize: 12),),
                            SizedBox(width: 8,),
                            Icon(Icons.download_rounded,size: 20,color: Colors.white,),
                          ],
                        ),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: (){
                          screenshotController.capture().then((Uint8List? image)async{
                            if (image != null) {
                              final directory = await getApplicationDocumentsDirectory();
                              final imagePath = await File('${directory.path}/image.png').create();
                              await imagePath.writeAsBytes(image);

                              /// Share Plugin
                              await Share.shareFiles([imagePath.path]);
                            }
                            setState(() {
                              this.image =  image;
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Text('Share',style: TextStyle(color: Colors.white,fontSize: 12),),
                            SizedBox(width: 8,),
                            Icon(Icons.share,size: 20,color: Colors.white,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
