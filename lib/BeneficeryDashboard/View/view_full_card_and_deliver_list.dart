import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/select_profile_image.dart';
import 'package:tcb/show_toast.dart';
import 'package:http/http.dart'as http;

import '../../AdminDashboard/Widget/custom_button_with_paid_unpaid.dart';

class ViewFullCardAndDeliverList extends StatefulWidget {
  const ViewFullCardAndDeliverList({Key? key}) : super(key: key);

  @override
  _ViewFullCardAndDeliverListState createState() =>
      _ViewFullCardAndDeliverListState();
}

class _ViewFullCardAndDeliverListState extends State<ViewFullCardAndDeliverList> {

  Uint8List? image;
  ScreenshotController screenshotController = ScreenshotController();

  String sebarQuantity = '';

  int qntIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectProfileImage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('আপনার ছবি পরিবর্তন করুন'),
                  SizedBox(width: 12),
                  Icon(Icons.camera_alt,size: 16),
                ],
              ),
            ),
          )
        ],
      ),
      body: Consumer<BeneficiaryInfoController>(
        builder: (context,data,child) {

          if(!data.getUserDataResponse.responseError!){

            for(int i = 0;i<data.receiverInfo.length;i++){
              data.receiverInfo[i].packageDetails = "";
              for(int j = 0;j<data.packageDetailsInfoArray.length;j++){
                if(data.receiverInfo[i].packageId==data.packageDetailsInfoArray[j].packageId){
                  data.receiverInfo[i].packageDetails = data.receiverInfo[i].packageDetails + "${data.packageDetailsInfoArray[j].productName} ${data.packageDetailsInfoArray[j].productQty} ${data.packageDetailsInfoArray[j].productUnit}, ";
                }
              }
            }
          }

          return ListView(
            children: [

              Screenshot(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,)
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Image.asset('asstes/freedom50.png',height: 23,),
                              ),
                              Column(
                                children: [
                                  Image.asset('asstes/govLogo.png',height: 14,),
                                  Text('পরিবার পরিচিতি কার্ড',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Image.asset('asstes/mujib100.png',height: 23,),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: FadeInImage(
                                            image: NetworkImage('${ApiEndPoints().imageBaseUrl}${data.userData!.beneficiaryImageFile}'),
                                            height: 70,
                                            width: 70,
                                            placeholder: const AssetImage("asstes/emptyProfile.jpg"),
                                            imageErrorBuilder: (context, error, stackTrace) {
                                              return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 28,),
                                        SizedBox(
                                          width: 100,
                                          child: Text(data.userData!.upazilaNameBangla,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center),
                                        ),
                                        SizedBox(
                                          width: 100,child: Text(data.userData!.unionNameBangla,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('নাম',style: TextStyle(fontSize: 10),),
                                        SizedBox(
                                          width: 120,
                                          child: Text(data.userData!.beneficiaryNameBangla,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: 10,),
                                        Text('পরিচয় পত্র নম্বর ',style: TextStyle(fontSize: 10,),),
                                        SizedBox(
                                          width: 120,
                                          child: Text(data.userData!.nidNumber,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                        ),
                                        SizedBox(height: 10,),
                                        Text('পরিবার কার্ড ',style: TextStyle(fontSize: 10),),
                                        SizedBox(width: 120,child: Text(data.userData!.familyCardNumber,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width-150,
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('মোবাইল',style: TextStyle(fontSize: 10),),
                                                  Text(data.userData!.beneficiaryMobile,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 22),
                                                child: Column(
                                                  children: [
                                                    Text("পেশা",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                                    Text(data.userData!.beneficiaryOccupationName,style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 10,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      QrImage(
                                        data: "Mobile : ${data.userData!.beneficiaryMobile},NID :-${data.userData!.nidNumber}",
                                        version: QrVersions.auto,
                                        size: 90.0,
                                      ),
                                      SizedBox(height: 8,),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          Builder(
                              builder: (context) {
                                switch(data.userData!.addressType){
                                  case 'U' :
                                    return Text('জেলা প্রশাসন, ${data.userData!.districtNameBangla}',style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),);
                                  case 'C' :
                                    return Text('${data.userData!.upazilaNameBangla}',style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),);
                                  case 'P' :
                                    return Text('${data.userData!.unionNameBangla}',style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),);
                                }
                                return Text('',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.green),);
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                controller: screenshotController,
              ),



              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: (){
                        screenshotController.capture().then((Uint8List? image)async{
                          if (image != null) {
                            final directory = await getApplicationDocumentsDirectory();
                            final imagePath = await File('${directory.path}/beneficiaryCard.png').create();
                            await imagePath.writeAsBytes(image);
                            GallerySaver.saveImage(imagePath.path,albumName: 'downloads').then((value){
                              if(value!){
                                ShowToast.myToast('Beneficiary Card save in download folder', Colors.black, 2);
                              }else{
                                ShowToast.myToast("Something is wrong\nCan't download", Colors.black, 2);
                              }
                            });
                          }
                        });
                      },
                      child: Row(
                        children: const [
                          Text('Download Card',style: TextStyle(color: Colors.white,fontSize: 12),),
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
                        children: const [
                          Text('Share Card',style: TextStyle(color: Colors.white,fontSize: 12),),
                          SizedBox(width: 8,),
                          Icon(Icons.share,size: 20,color: Colors.white,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              data.receiverInfo.isEmpty?const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Center(child: Text('এখনো কোন টিসিবি পণ্য গ্রহণ করা হয়নি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              ):const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('টিসিবি পণ্য গ্রহণের বিবরণ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              ),
              Builder(
                  builder: (context) {
                    if(data.receiverInfo.isEmpty){
                      return Container();
                    }
                    else{
                      return ListView.builder(
                        itemCount: data.receiverInfo.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,position){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.withOpacity(0.2)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text('সেবা/পণ্য প্রদানের তারিখ: ${HelperClass.convertAsMonthDayYear(data.receiverInfo[position].receivedDate.toString())}',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text("সেবার বিবরণ: ${data.receiverInfo[position].packageName!}",style: TextStyle(fontSize: 12,color: Colors.grey[700],fontWeight: FontWeight.bold),),
                                      Text("${data.receiverInfo[position].packageDetails}",style: TextStyle(fontSize: 12,color: Colors.grey[700],fontWeight: FontWeight.bold),),
                                      Divider(color: Colors.white,height: 10,thickness: 2),
                                      Text("ডিলারের নাম: ${data.receiverInfo[position].dealerName!}",style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                      Text("সেবা প্রাপ্তি স্থান: ${data.receiverInfo[position].distributionPlace!}",style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                      Text('ওটিপি কোড: ${data.receiverInfo[position].otpCode.toString()}',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                    ],
                                  ),
                                  SizedBox(height: 11,),
                                  Wrap(
                                    runSpacing: 12,
                                    spacing: 12,
                                    children: [
                                      CustomButtonWithPaidUnPaid(
                                        title: data.receiverInfo[position].stepName.toString(),
                                        isSelectable: true,
                                        onTab: (){

                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
              ),
            ],
          );
        }
      ),
    );
  }
}
