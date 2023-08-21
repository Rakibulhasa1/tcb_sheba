import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/GeneralDashboard/general_user_navigation.dart';
import 'package:tcb/show_toast.dart';

import 'AdminDashboard/admin_user_navigation.dart';
import 'change_password2.dart';

class OtpVerification extends StatefulWidget {

  final String userAreaType;

  const OtpVerification({Key? key,required this.userAreaType}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  bool isWorking = false;
  String otp = '';




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Text('Verification',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey[600])),
            SizedBox(height: 24),
            Text('Enter the code sent to the number',style: TextStyle(fontSize: 14,color: Colors.grey[800])),
            SizedBox(height: 24),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              autoFocus: true,
              showFieldAsBox: true,
              onCodeChanged: (String code) {

              },
              onSubmit: (String verificationCode){
                setState(() {
                  otp = verificationCode;
                });
              }, // end onSubmit
            ),

            SizedBox(height: 32),
            const Text("Didn't receive code?",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
            const Text('Resend',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24,bottom: 24,right: 12,left: 24),
                    child: Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text('Cancel',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24,bottom: 24,left: 12,right: 24),
                    child: AnimatedCrossFade(
                      firstChild: Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: (){
                            // setState(() {
                            //   isWorking = true;
                            // });
                            //
                            // var body = {
                            //   "application_id" : '1',
                            //   "generated_code" : otp
                            // };
                            //
                            // print(body);
                            // if(widget.userAreaType=='DD'||widget.userAreaType=='DE'){
                            //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GeneralUserNavigation()), (Route<dynamic> route) => false);
                            // }
                            // else{
                            //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AdminUserNavigation()), (Route<dynamic> route) => false);
                            // }
                            //
                            // Future.delayed(Duration(seconds: 2)).then((value){
                            //   setState(() {
                            //     isWorking = false;
                            //   });
                            //   ApiController().postRequest(endPoint: ApiEndPoints().otpVerification,body: body).then((value) {
                            //     if(value.responseCode==200){
                            //
                            //     }else{
                            //       ShowToast.myToast("Otp code doesn't match", Colors.black, 2);
                            //     }
                            //   });
                            // }
                            // );
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword2()));
                              },
                                child: Text('Verify',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600 ),)),
                          ),
                        ),
                      ),
                      secondChild: const Center(
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      crossFadeState:isWorking?CrossFadeState.showSecond:CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 400),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
