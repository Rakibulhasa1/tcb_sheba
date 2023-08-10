import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/AdminDashboard/Model/BeneficiaryAllInfoModel.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_paid_unpaid.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/show_toast.dart';

class UserDetailsViewByAdminWithNid extends StatefulWidget {
  final String nidData;
  const UserDetailsViewByAdminWithNid({Key? key,required this.nidData}) : super(key: key);

  @override
  _UserDetailsViewByAdminWithNidState createState() => _UserDetailsViewByAdminWithNidState();
}

class _UserDetailsViewByAdminWithNidState extends State<UserDetailsViewByAdminWithNid> {

  String sebarQuantity = '';
  File? profileImage;

  int qntIndex = 0;

  ApiResponse getUserDataResponse = ApiResponse(isWorking: true);

  BeneficiaryAllInfoModel? userDataResponse;
  BeneficiaryInfo? userData;
  List<ReceiverInfo> receiverInfo = [];
  List<PackageDetailsInfoArray> packageDetailsInfoArray = [];

  @override
  void initState() {
    String newNid = '';
    try{
      newNid = widget.nidData.substring( widget.nidData.indexOf("NW")+2, widget.nidData.indexOf("OL")-1);
      getData(newNid: newNid);
    }catch(e){

    }
    super.initState();
  }

  void getData({required String newNid}){
    var body = {
      'nid_number' : newNid,
    };

    print(body);
    ApiController().postRequest(endPoint: ApiEndPoints().beneficiaryAllInfo,body: body).then((value){
      if(value.responseCode==200){
        try{
          userDataResponse = beneficiaryAllInfoModelFromJson(value.response.toString());
          if(userDataResponse!.status!='Token is Expired'){

            setState(() {
              userData  = userDataResponse!.userData!.beneficiaryInfo;
              receiverInfo = userDataResponse!.userData!.receiverInfo!;
              packageDetailsInfoArray = userDataResponse!.userData!.packageDetailsInfoArray!;

              getUserDataResponse = ApiResponse(isWorking: false,responseError: false);
            });

          }else{
            setState(() {
              getUserDataResponse = ApiResponse(
                isWorking: false,
                responseError: true,
                errorMessage: 'Token is Expired',
              );
            });
          }
        }catch(e){
          setState(() {
            getUserDataResponse = ApiResponse(
              isWorking: false,
              responseError: true,
              errorMessage: 'error',
            );
          });
        }
      }else{
        setState(() {
          getUserDataResponse = ApiResponse(isWorking: false,responseError: true,errorMessage: 'error',);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('উপকারভোগীর তথ্য'),
        actions: [
          profileImage!=null?IconButton(
            onPressed: (){
              ApiController().updateUserProfile(imageFile: profileImage!,userId: widget.nidData, endPoint: ApiEndPoints().profileUpdate).then((value){
                if(value.responseCode==200){
                  ShowToast.myToast('Upload Successfully', Colors.black, 2);
                }else{
                  ShowToast.myToast('Something is wrong', Colors.black, 2);
                }
              });
            },
            icon: Icon(Icons.done),
          ):Container(),
        ],
      ),
      body: Builder(
          builder: (context) {

            if(getUserDataResponse.isWorking!){
              return const Center(child: CircularProgressIndicator());
            }

            if(getUserDataResponse.responseError!){
              return const Center(
                child: Text('কোন ডাটা খুঁজে পাওয়া যায়নি ।'),
              );
            }

            if(!getUserDataResponse.responseError!){

              for(int i = 0;i<receiverInfo.length;i++){
                receiverInfo[i].packageDetails = "";
                for(int j = 0;j<packageDetailsInfoArray.length;j++){
                  if(receiverInfo[i].packageId==packageDetailsInfoArray[j].packageId){
                    receiverInfo[i].packageDetails = receiverInfo[i].packageDetails + "${packageDetailsInfoArray[j].productName} ${packageDetailsInfoArray[j].productQty} ${packageDetailsInfoArray[j].productUnit}, ";
                  }
                }
              }
            }

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    color: Colors.green,
                    child: const Text('কার্ড বিতরণী স্ট্যাটাস',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
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
                            Text('উপকারভোগীর পণ্য প্রাপ্তির রিপোর্ট',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 16),),
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
                                      GestureDetector(
                                        onTap: (){
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.SCALE,
                                            dialogType: DialogType.INFO,
                                            body: Column(
                                              children: [
                                                MaterialButton(
                                                  onPressed: (){

                                                    Navigator.pop(context);
                                                    HelperClass().getImage(ImageSource.camera).then((value){
                                                      HelperClass().cropProfileImage(value,'Crop Image').then((value){
                                                        setState(() {
                                                          profileImage = value;
                                                        });
                                                      });
                                                    });
                                                  },
                                                  child: const Text('Camera'),
                                                ),
                                                MaterialButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    HelperClass().getImage(ImageSource.gallery).then((value){
                                                      HelperClass().cropProfileImage(value,'Crop Image').then((value){
                                                        setState(() {
                                                          profileImage = value;
                                                        });
                                                      });
                                                    });
                                                  },
                                                  child: const Text('Gallery'),
                                                ),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                              ],
                                            ),
                                            title: 'Choose option',
                                          ).show();
                                        },
                                        child: SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              FadeInImage(
                                                image: NetworkImage('${ApiEndPoints().imageBaseUrl}${userData!.beneficiaryImageFile}'),
                                                height: 70,
                                                width: 70,
                                                placeholder: const AssetImage("asstes/emptyProfile.jpg"),
                                                imageErrorBuilder: (context, error, stackTrace) {
                                                  return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                bottom: 0.0,
                                                left: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: Colors.black.withOpacity(0.5),
                                                  height: 20,
                                                  child: Text("Change",style: TextStyle(color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 28,),
                                      Container(
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: Builder(
                                            builder: (context) {
                                              switch(userData!.addressType){
                                                case 'U' :
                                                  return Text('${userData!.districtNameBangla},${userData!.upazilaNameBangla},${userData!.unionNameBangla},${userData!.wordNameBangla}',style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,);
                                                case 'C' :
                                                  return Text('${userData!.upazilaNameBangla},${userData!.unionNameBangla}',style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center);
                                                case 'P' :
                                                  return Text('${userData!.districtNameBangla},${userData!.upazilaNameBangla},${userData!.unionNameBangla},${userData!.wordNameBangla}',style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center);
                                              }
                                              return Text('',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center);
                                            }
                                        ),
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
                                        child: Text(userData!.beneficiaryNameBangla,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 10,),
                                      Text('পরিচয় পত্র নম্বর ',style: TextStyle(fontSize: 10,),),
                                      SizedBox(
                                        width: 120,
                                        child: Text(userData!.nidNumber,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(height: 10,),
                                      Text('পরিবার কার্ড ',style: TextStyle(fontSize: 10),),
                                      SizedBox(width: 120,child: Text(userData!.familyCardNumber,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
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
                                                Text(userData!.beneficiaryMobile,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 22),
                                              child: Column(
                                                children: [
                                                  Text("পেশা",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                                  Text(userData!.beneficiaryOccupationName,style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
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
                                      data: "Mobile : ${userData!.beneficiaryMobile},NID :-${userData!.nidNumber}",
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                receiverInfo.isEmpty?const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Center(child: Text('এই উপকারভোগী এখনও টিসিবি পণ্য গ্রহণ করেন নি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red))),
                ):const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('টিসিবি পণ্য গ্রহণের বিবরণ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                ),
                Builder(
                    builder: (context) {
                      if(receiverInfo.isEmpty){
                        return Container();
                      }
                      else{
                        return ListView.builder(
                          itemCount: receiverInfo.length,
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
                                          child: Text('সেবা/পণ্য প্রদানের তারিখ: ${HelperClass.convertAsMonthDayYear(receiverInfo[position].receivedDate.toString())}',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text("সেবার বিবরণ: ${receiverInfo[position].packageName!}",style: TextStyle(fontSize: 12,color: Colors.grey[700],fontWeight: FontWeight.bold),),
                                        Text("${receiverInfo[position].packageDetails}",style: TextStyle(fontSize: 12,color: Colors.grey[700],fontWeight: FontWeight.bold),),
                                        Divider(color: Colors.white,height: 10,thickness: 2),
                                        Text("ডিলারের নাম: ${receiverInfo[position].dealerName!}",style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                        Text("সেবা প্রাপ্তি স্থান: ${receiverInfo[position].distributionPlace!}",style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                        Text('ওটিপি কোড: ${receiverInfo[position].otpCode.toString()}',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                      ],
                                    ),
                                    SizedBox(height: 11,),
                                    Wrap(
                                      runSpacing: 12,
                                      spacing: 12,
                                      children: [
                                        CustomButtonWithPaidUnPaid(
                                          title: receiverInfo[position].stepName.toString(),
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
