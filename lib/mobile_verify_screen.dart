// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';







import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tcb/otp_verification.dart';
import 'package:tcb/password_reset.dart';

import 'otp_verification_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final phoneController = TextEditingController();

  bool isShowPass = false;
  bool onError = false;
  String? codeMobile;
  final formKey = GlobalKey<FormState>();
  late ProgressDialog prg;
  @override
  Widget build(BuildContext context) {
    prg = ProgressDialog(context, type: ProgressDialogType.normal);
    prg.style(
      message: 'Please wait.......',
      borderRadius: 4.0,
      backgroundColor: Colors.grey,
      progressWidget: CircularProgressIndicator(),
      maxProgress: 1.0,
    );
    return Container(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title:
            Text('Forget Password', style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),

          ),
          //backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.white,

              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Center(
                          child: Image.asset('asstes/mainLogo.png',height: 100,width: 100,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 13),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 10),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            padding:
                            EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: Column(children: <Widget>[
                              Container(
                                  child: IntlPhoneField(
                                    controller: phoneController,
                                    // textAlign: TextAlign.right,
                                    // dropdownIconPosition: IconPosition.trailing,
                                    // dropdownTextStyle: ,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),

                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      contentPadding:
                                      EdgeInsets.fromLTRB(8, 5, 10, 5),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),


                                    initialCountryCode:
                                    'BD', //default contry code, NP for Nepal
                                    onChanged: (phone) {
                                      setState(() {
                                        codeMobile = phone.countryCode;
                                      });
                                      //when phone number country code is changed
                                      print(
                                          phone.completeNumber); //get complete number
                                      print(
                                          phone.countryCode); // get country code only
                                      print(phone.number); // only phone number
                                    },
                                  )),
                            ])),
                        onError
                            ? Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text('',
                                  style: TextStyle(color: Colors.red)),
                            ))
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            //   height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  // ignore: avoid_unnecessary_containers
                                    child: Container(
                                      //height: 100,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:Colors.green,
                                            onPrimary: Colors.white,
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 5,
                                            ),
                                          ),
                                          onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              // OtpVerification(userAreaType: 'userAreaType')
                                                              ForgetOtpVerificationScreen(
                                                                mobileNumber:
                                                                phoneController
                                                                    .text,
                                                                countryCode: codeMobile,
                                                              )
                                                      
                                                      ));

                                            // if (formKey.currentState!.validate()) {
                                            //   FocusScope.of(context).unfocus();
                                            //
                                            //   prg.show();
                                            //   await ApiClient.oTPApi(
                                            //     phoneController.text,
                                            //   ).then((myOTP) async {
                                            //     if (myOTP.status == 'fail') {
                                            //       prg.hide();
                                            //       Fluttertoast.showToast(
                                            //           msg: myOTP.message.toString(),
                                            //           toastLength: Toast.LENGTH_SHORT,
                                            //           gravity: ToastGravity.BOTTOM,
                                            //           timeInSecForIosWeb: 1,
                                            //           backgroundColor: Colors.red,
                                            //           textColor: Colors.white,
                                            //           fontSize: 16.0);
                                            //     } else {
                                            //       prg.hide();
                                            //       Fluttertoast.showToast(
                                            //           msg: myOTP.message.toString(),
                                            //           toastLength: Toast.LENGTH_SHORT,
                                            //           gravity: ToastGravity.BOTTOM,
                                            //           timeInSecForIosWeb: 1,
                                            //           backgroundColor: Colors.green,
                                            //           textColor: Colors.white,
                                            //           fontSize: 16.0);
                                            //       Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //               builder: (context) =>
                                            //                   ForgetOtpVerificationScreen(
                                            //                     mobileNumber:
                                            //                     phoneController
                                            //                         .text,
                                            //                     countryCode: codeMobile,
                                            //                   )));
                                            //     }
                                            //   });
                                            // }
                                          },
                                          child: Text("Next"),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

          )),
    );
  }
}
