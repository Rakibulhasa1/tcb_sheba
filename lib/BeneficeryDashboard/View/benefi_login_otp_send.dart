import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/BeneficeryDashboard/View/beneficery_side_navigation.dart';
import 'package:tcb/select_profile_image.dart';
import 'package:tcb/show_toast.dart';

class BenefiLoginOtpSend extends StatefulWidget {
  final String userName;
  final String password;
  final String userId;
  const BenefiLoginOtpSend({Key? key,required this.userId,required this.userName, required this.password}) : super(key: key);

  @override
  _BenefiLoginOtpSendState createState() => _BenefiLoginOtpSendState();
}

class _BenefiLoginOtpSendState extends State<BenefiLoginOtpSend> {

  String completePin = '';

  ApiResponse otpResponse = ApiResponse(isWorking: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: Column(
        children: [
          SizedBox(height: 32),
          Text('Verification',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey[600])),
          SizedBox(height: 24),
          Text('Enter the code sent to the number',style: TextStyle(fontSize: 14,color: Colors.grey[800])),
          SizedBox(height: 24),
          Text(widget.password,style: TextStyle(fontSize: 14,color: Colors.black)),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Pinput(
              onCompleted: (pin){
                print(pin);
                setState(() {
                  completePin = pin;
                });
              },
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
              autofocus: true,
              length: 6,
              animationDuration: Duration(milliseconds: 500),
              closeKeyboardWhenCompleted: true,
            ),
          ),
          SizedBox(height: 32),
          const Text("Didn't receive code?",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
          const Text('Resend',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
            child: AnimatedCrossFade(
              firstChild: Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: (){
                    setState(() {
                      otpResponse = ApiResponse(
                        isWorking: true,
                      );
                    });
                    var body = {
                      "users_id" : widget.userId,
                      "generated_code": completePin,
                      "email" : widget.userName,
                      "password" : widget.password,
                    };
                    ApiController().loginResponse(endPoint: ApiEndPoints().otpVerification,body: body).then((value){
                      print(value.responseCode);

                      if(value.responseCode==200){
                        var myResponse = json.decode(value.response.toString());
                        setState(() {
                          otpResponse = ApiResponse(
                            isWorking: false,
                            responseError: false,
                          );
                          GetStorage().write('b_token', 'Bearer ${myResponse['token']}');
                          GetStorage().write('beneficiaryId', '${myResponse['message']['beneficiary_id']}');
                          GetStorage().write('user_nid', widget.userName);

                          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=>BeneficerySideNavigation()),((Route<dynamic> route) => false));

                          // if(myResponse['message']['user_image']!=null){
                          // }else{
                          //   Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectProfileImage()));
                          // }

                        });
                      }else{
                        setState(() {
                          otpResponse = ApiResponse(
                            isWorking: false,
                            responseError: false,
                          );
                        });
                        ShowToast.myToast('Something is wrong', Colors.black, 2);
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text('Submit',style: const TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              secondChild: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: CircularProgressIndicator(),
                ),
              ),
              crossFadeState: otpResponse.isWorking!?CrossFadeState.showSecond:CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }
}
