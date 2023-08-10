import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/QrScan/InformationForChanceReceive.dart';
import 'package:tcb/QrScan/InformationForReceiveProduct.dart';
import 'package:tcb/QrScan/OtpDataModel.dart';
import 'package:tcb/QrScan/UserInformationModel.dart';
import 'package:tcb/custom_loader.dart';
import 'package:tcb/show_error_message.dart';
import 'package:tcb/show_toast.dart';
import 'package:tcb/GeneralDashboard/view_registration_code.dart';
import 'package:intl/intl.dart';

class UserFromV2 extends StatefulWidget {

  final String? qrCode;
  final int isQR;
  final bool? comeFromNidScan;

  const UserFromV2({Key? key,required this.qrCode,required this.isQR,this.comeFromNidScan}) : super(key: key);

  @override
  _UserFromV2State createState() => _UserFromV2State();
}

class _UserFromV2State extends State<UserFromV2> {

  ApiResponse myApiResponse = ApiResponse(isWorking: false);

  ApiResponse getDataResponse = ApiResponse(isWorking: true);
  UserInformationModel? userInformationModel;
  InformationForReceiveProduct? informationForReceiver;
  InformationForChanceReceive? informationForChanceReceive;


  OtpDataModel? otpDataModel;


  String totalCurrentAddress = '';

  String sebarQuantity = '';

  int qntIndex = 0;

  @override
  void initState() {
    Map<String, dynamic> body={'nid_number' : widget.qrCode};

    print(body);
    ApiController().postRequest(endPoint: 'qr-code-search_v2',body: body).then((value){
      print(value.response);
      if(value.responseCode==200){
        setState(() {
          getDataResponse = ApiResponse(
            isWorking: false,
            responseCode: value.responseCode,
            responseError: false,
          );
          userInformationModel = userInformationModelFromJson(value.response.toString());
          if(userInformationModel!.member!.receivingStatus=='Yes'){
            informationForReceiver = informationForReceiveProductFromJson(value.response.toString());
          }
          if(userInformationModel!.member!.receivingStatus=='Chance'){
            informationForChanceReceive = informationForChanceReceiveFromJson(value.response.toString());
          }
        });
      }else{
       setState(() {
         getDataResponse = ApiResponse(
           isWorking: false,
           responseCode: value.responseCode,
           responseError: true,
         );
       });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: widget.comeFromNidScan!=null?null:AppBar(
        title: const Text('User Information'),
      ),
      body: Builder(
        builder: (context) {
          if(getDataResponse.isWorking!){
            return const CustomLoader();
          }
          if(getDataResponse.responseError!){
            return const ErrorMessage();
          }
          if(!getDataResponse.responseError!){
            if(userInformationModel!.member!.benificiaryInfo!.addressType=='U'){
              totalCurrentAddress = userInformationModel!.member!.benificiaryInfo!.upazilaNameBangla! + ',  ' + userInformationModel!.member!.benificiaryInfo!.unionNameBangla! + ', ' + userInformationModel!.member!.benificiaryInfo!.wordNameBangla! ;
            }

            if(userInformationModel!.member!.benificiaryInfo!.addressType=='P'){
              totalCurrentAddress = userInformationModel!.member!.benificiaryInfo!.upazilaNameBangla! + ',  ' + userInformationModel!.member!.benificiaryInfo!.unionNameBangla! + ', ' + userInformationModel!.member!.benificiaryInfo!.wordNameBangla! ;
            }

            if(userInformationModel!.member!.benificiaryInfo!.addressType=='C'){
              totalCurrentAddress = userInformationModel!.member!.benificiaryInfo!.upazilaNameBangla! + ',  ' + userInformationModel!.member!.benificiaryInfo!.unionNameBangla! + ', ' + userInformationModel!.member!.benificiaryInfo!.wordNameBangla! ;
            }

           if(userInformationModel!.member!.receivingStatus=='Chance'){
             for(qntIndex;qntIndex < informationForChanceReceive!.member!.packageDetailsInfo!.length;qntIndex++){
               sebarQuantity = sebarQuantity + informationForChanceReceive!.member!.packageDetailsInfo![qntIndex].productName! +" "+ informationForChanceReceive!.member!.packageDetailsInfo![qntIndex].productQry!.toString() +" "+ informationForChanceReceive!.member!.packageDetailsInfo![qntIndex].productUnit!+ ', ';
             }
           }
           if(userInformationModel!.member!.receivingStatus=='Yes'){
             for(qntIndex;qntIndex < informationForReceiver!.member!.packageDetailsInfo!.length;qntIndex++){
               sebarQuantity = sebarQuantity + informationForReceiver!.member!.packageDetailsInfo![qntIndex].productName! +" "+ informationForReceiver!.member!.packageDetailsInfo![qntIndex].productQty!.toString() +" "+ informationForReceiver!.member!.packageDetailsInfo![qntIndex].productUnit!+ ', ';
             }
           }
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.4),
                        ),
                        child: const Text('উপকারভোগীর তথ্য',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 30,
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: FadeInImage(
                                      image: NetworkImage(ApiEndPoints().imageBaseUrl+userInformationModel!.member!.benificiaryInfo!.beneficiaryImageFile!,),
                                      height: 100,
                                      width: 100,
                                      placeholder: const AssetImage("asstes/emptyProfile.jpg"),
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                                        },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Expanded(
                                  flex: 70,
                                  child: Table(
                                    columnWidths: const {
                                      0: FractionColumnWidth(.30),
                                      1: FractionColumnWidth(.1),
                                      2: FractionColumnWidth(.69)
                                    },
                                    children: [
                                      TableRow(
                                          children: [
                                            const Text('নাম',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                            const Text(':',style: TextStyle(fontSize: 14),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.beneficiaryNameBangla!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                          ]
                                      ),
                                      TableRow(
                                          children: [
                                            const Text('মোবাইল',style: TextStyle(fontSize: 14),),
                                            const Text(':',style: TextStyle(fontSize: 14),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.beneficiaryMobile!,style: const TextStyle(fontSize: 14),),
                                          ]
                                      ),
                                      TableRow(
                                          children: [
                                            const Text('পরিচয়পত্র',style: TextStyle(fontSize: 14),),
                                            const Text(':',style: TextStyle(fontSize: 14),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.nidNumber!,style: const TextStyle(fontSize: 14),),
                                          ]
                                      ),
                                      TableRow(
                                          children: [
                                            const Text('কার্ড নম্বর',style: TextStyle(fontSize: 14),),
                                            const Text(':',style: TextStyle(fontSize: 14),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.familyCardNumber!,style: const TextStyle(fontSize: 14),),
                                          ]
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Text(totalCurrentAddress,style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,bottom: 10),
                child: Card(
                  elevation: 2.0,
                  child: Builder(
                    builder: (context) {

                      switch (userInformationModel!.member!.receivingStatus){
                        case 'Yes' :
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.4),
                                ),
                                child: const Text('সেবা প্রাপ্তির তথ্য',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                              Align(
                                child : Text(HelperClass.convertAsMonthDayYear(informationForReceiver!.member!.beneficiaryReceiveInfo!.receivedDate.toString()),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Table(

                                  columnWidths: const {
                                    0: FractionColumnWidth(.40),
                                    1: FractionColumnWidth(.1),
                                    2: FractionColumnWidth(.59)
                                  },
                                  children: [
                                    TableRow(
                                        children: [
                                          const Text('সেবার ধাপ',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(informationForReceiver!.member!.assignInfo!.stepName.toString(),style: const TextStyle(fontSize: 16),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          const Text('প্যাকেজ/সেবা',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(informationForReceiver!.member!.assignInfo!.packageName!,style:const TextStyle(fontSize: 16),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          const Text('পণ্যের বিবরণ',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(sebarQuantity,style: const TextStyle(fontSize: 16),),

                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          const Text('সেবা প্রদানকারী ডিলারের নাম',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(informationForReceiver!.member!.assignInfo!.dealerName!,style: const TextStyle(fontSize: 16),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          const Text('বিক্রয়কারীর নাম',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(informationForReceiver!.member!.dealerDetailsInfo![0].destributorName!,style: const TextStyle(fontSize: 16),),
                                        ]
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24,),
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                padding : EdgeInsets.symmetric(horizontal: 24),
                                child: Text('এই উপকারভোগী ${HelperClass.convertAsMonthDayYear(informationForReceiver!.member!.beneficiaryReceiveInfo!.receivedDate.toString())} পণ্য (${informationForReceiver!.member!.assignInfo!.packageName!}) গ্রহণ করেছেন।',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          );

                        case 'No' :
                          return Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                            child: const Text('দুঃখিত! আজকে এই উপকারভোগীর প্রাপ্যতা নেই।',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          );

                        case 'Chance' :
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.4),
                                ),
                                child: const Text('সেবা প্রদানের তথ্য',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 10),
                              Align(
                                child : Text(HelperClass.convertAsMonthDayYear(informationForChanceReceive!.member!.assignInfo!.assignDate.toString()),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Table(

                                  columnWidths: const {
                                    0: FractionColumnWidth(.40),
                                    1: FractionColumnWidth(.1),
                                    2: FractionColumnWidth(.59)
                                  },
                                  children: [
                                    TableRow(
                                        children: [
                                          const Text('সেবা প্রদানের ধাপ',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(informationForChanceReceive!.member!.assignInfo!.stepName.toString(),style: const TextStyle(fontSize: 16),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          const Text('প্যাকেজ/সেবা',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(informationForChanceReceive!.member!.assignInfo!.packageName!,style:const TextStyle(fontSize: 16),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          const Text('পণ্যের বিবরণ',style: TextStyle(fontSize: 16),),
                                          const Text(':',style: TextStyle(fontSize: 16),),
                                          Text(sebarQuantity,style: const TextStyle(fontSize: 16),),

                                        ]
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                              Container(
                                alignment: Alignment.center,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                                child: const Text('উল্লেখিত উপকারভোগীকে পণ্য প্রদান করা যাবে',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
                                padding: EdgeInsets.all(8),
                              ),
                            ],
                          );

                        default :
                          return Container();
                      }
                    }
                  ),
                ),
              ),


              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 120,
                  child: Builder(
                      builder: (context) {
                        switch(userInformationModel!.member!.receivingStatus){
                          case 'Yes' :
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('প্রাপ্যতাঃ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                SizedBox(width: 12,),
                                Icon(Icons.close,color: Colors.redAccent,size: 32,),
                              ],
                            );
                          case 'No' :
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('প্রাপ্যতাঃ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                SizedBox(width: 12,),
                                Icon(Icons.close,color: Colors.redAccent,size: 32,),
                              ],
                            );

                          case 'Chance' :
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('প্রাপ্যতাঃ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                SizedBox(width: 12,),
                                Icon(Icons.check_circle,color: Colors.green,size: 32,),
                              ],
                            );
                          default :
                            return Container();
                        }

                      }
                  ),
                ),
              ),
              const SizedBox(height: 10,),


              Builder(
                builder: (context) {

                  switch(userInformationModel!.member!.receivingStatus){
                    case 'Yes' :
                      return  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          elevation : 5.0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 10),
                              child: Text('বাতিল করুন',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                            ),
                          ),

                        ),
                      );
                    case 'No' :
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          elevation: 5.0,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                                child: Text(
                                  'বাতিল করুন',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),textAlign: TextAlign.center,
                                ),
                              ),
                    ),
                  ),
                      );
                    case 'Chance' :
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                              elevation : 5.0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 10),
                                  child: Text('বাতিল করুন',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),
                              ),

                            ),
                            const Spacer(),
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green,
                              elevation : 5.0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: (){
                                  setState(() {
                                    myApiResponse = ApiResponse(
                                      isWorking: true,
                                    );
                                  });


                                  var myBody = {
                                    'beneficiary_id': userInformationModel!.member!.benificiaryInfo!.beneficiaryId!.toString(),
                                    'step_id': informationForChanceReceive!.member!.assignInfo!.stepId.toString(),
                                    'assign_id': informationForChanceReceive!.member!.assignInfo!.assignId.toString(),
                                    'package_id' : informationForChanceReceive!.member!.assignInfo!.packageId.toString(),
                                  };

                                  print(myBody);
                                  ApiController().postRequest(endPoint: ApiEndPoints().getOTP,body: myBody).then((value){
                                    print('${value.responseCode} ${value.errorMessage}');
                                    if(value.responseCode==200){
                                      setState(() {
                                       try{
                                         otpDataModel = otpDataModelFromJson(value.response.toString());
                                         myApiResponse = ApiResponse(
                                           isWorking: false,
                                           responseError: false,
                                         );
                                         Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewRegistrationCode(otp: otpDataModel!.data!)));
                                       }
                                       catch(e){
                                         myApiResponse = ApiResponse(
                                           isWorking: false,
                                           responseError: true,
                                         );
                                       }
                                      });
                                    }else{
                                      setState(() {
                                        myApiResponse = ApiResponse(
                                          isWorking: false,
                                          responseError: true,
                                        );
                                      });
                                      ShowToast.myToast('Something is wrong\nTry Again', Colors.black, 2);
                                    }
                                  });
                                },
                                child: myApiResponse.isWorking!? const SizedBox(width: 30,height: 30,child: CircularProgressIndicator()): const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 10),
                                  child: Text('প্রদান করুন',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),
                              ),

                            ),
                          ],
                        ),
                      );
                    default :
                      return Container();
                  }
                }
              ),
              const SizedBox(height: 20,),
            ],
          );
        }
      ),
    );
  }
}
