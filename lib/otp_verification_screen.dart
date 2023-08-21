// ignore_for_file: avoid_unnecessary_containers, unused_local_variable, prefer_const_constructors

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tcb/password_reset.dart';

class ForgetOtpVerificationScreen extends StatefulWidget {
  final String? mobileNumber;
  final String? countryCode;

  ForgetOtpVerificationScreen({
    this.mobileNumber,
    this.countryCode,
  });

  @override
  _ForgetOtpVerificationScreenState createState() =>
      _ForgetOtpVerificationScreenState();
}

class _ForgetOtpVerificationScreenState
    extends State<ForgetOtpVerificationScreen> with CodeAutoFill {
  final formKey = GlobalKey<FormState>();
  String _code = "";
  String codeValue = "";
  String otp = '';
  String signature = "{{ app signature }}";
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  var mySelectedLang = '';

  final List<String> locationInfo = [];
  String? currentLocation;
  int? currentStateId;
  int? currentCityID;
  String? getOTPValue;

  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'हिन्दी', 'locale': Locale('hi', 'IN')},
    {'name': 'ਪੰਜਾਬੀ', 'locale': Locale('pa', 'IN')},
  ];
  String getOrderDateCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);
    var formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(dateParse);
    return formattedDate.toString();
  }

  List<String>? Lan = ['English', 'हिन्दी', 'ਪੰਜਾਬੀ'];

  bool hasError = false;
  String currentText = "";

  String errorMsg = '';

  late bool _loading;
  late ProgressDialog prg;

  var getMobile = "";
  _getOTPToSharedPref() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var saveOTP = prefs.getString('OTP');

    getOTPValue = saveOTP;
    print(getOTPValue);
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _getOTPToSharedPref();
    autosmsget();
    // print(widget.languageList);
    getMobile = widget.mobileNumber.toString();
    listenOtp();
    setState(() {
      startTimer();
    });

    //getdata();
    super.initState();
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  Future<void> autosmsget() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    super.dispose();
    SmsAutoFill().unregisterListener();
    errorController!.close();
    _timer.cancel();
  }

  late Timer _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    // ignore: unnecessary_new
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  Future<void> resendM() async {
    _start = 15; //_start - 1;
    setState(() {
      startTimer();
    });
    textWidget();
    listenOtp();
    prg.show();
    var signatureID = await SmsAutoFill().getAppSignature;
    print(signatureID);

    // await ApiClient.oTPApi(
    //   widget.mobileNumber.toString(),
    // ).then((myOTP) async {
    //   if (myOTP.status == 'fail') {
    //     prg.hide();
    //     Fluttertoast.showToast(
    //         msg: myOTP.message.toString(),
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.red,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   } else {
    //     prg.hide();
    //     Fluttertoast.showToast(
    //         msg: myOTP.message.toString(),
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.green,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   }
    // });
  }

  buildLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }

  Widget textWidget() {
    if (_start > 0) {
      print(_start);
      return AutoSizeText(
        "Wait $_start",
        style: GoogleFonts.montserrat(
          fontSize: 12,
          // color: WidgetColors.TextColor,
        ),
      );
    } else {
      return InkWell(
        child: AutoSizeText(
          "Resend Code", //
          style: GoogleFonts.montserrat(
            fontSize: 12,
            // color: WidgetColors.MainTitleColor,
          ),
        ),
        onTap: () {
          startTimer();
          resendM();
        },
      );
    }
  }

  @override
  void codeUpdated() {
    print("Update code $_code");
    setState(() {
      print("codeUpdated");
    });
  }

  final bool _btnEnabled = false;

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget oTPService() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8),
      child: Center(
          child: Text.rich(TextSpan(
              text: "We,ve sent a 6 digit confirmation code to ",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: widget.countryCode.toString() +
                        ' ' +
                        widget.mobileNumber.toString(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Colors.green,
                      // decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // code to open / launch terms of service link here
                      }),
                TextSpan(
                    text: '.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.black,),
                    children: <TextSpan>[
                      TextSpan(
                          text: '\nMake sure you enter correct code.',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            //decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // code to open / launch privacy policy link here
                            })
                    ])
              ]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    prg = ProgressDialog(context, type: ProgressDialogType.normal);
    prg.style(
      message: 'Please wait.......',
      borderRadius: 4.0,
      backgroundColor: Colors.grey,
      progressWidget: CircularProgressIndicator(),
      maxProgress: 1.0,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text('Check your Mobile'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(children: <Widget>[
              // TopContainerOTP(),
              Padding(
                padding:
                const EdgeInsets.only(top: 1.0, left: 15.0, right: 15.0),
              ),
              const SizedBox(height: 50),
              Center(
                child: Image.asset('asstes/mainLogo.png',height: 100,width: 100,),
              ),

              oTPService(),

              const SizedBox(
                height: 5,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
                  child:
                  // OtpTextField(
                  //
                  //   numberOfFields: 6,
                  //   borderColor: Color(0xFF512DA8),
                  //   autoFocus: true,
                  //   showFieldAsBox: true,
                  //   onCodeChanged: (String code) {
                  //
                  //   },
                  //   onSubmit: (String verificationCode){
                  //     setState(() {
                  //       otp = verificationCode;
                  //     });
                  //   }, // end onSubmit
                  // ),

                  PinFieldAutoFill(
                    currentCode: codeValue,
                    controller: textEditingController,
                    codeLength: 6,
                    onCodeChanged: (code) {
                      print("onCodeChanged $code");

                      setState(() {
                        codeValue = code.toString();
                      });
                    },
                    onCodeSubmitted: (val) {
                      print("onCodeSubmitted $val");
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),


              Padding(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  //   height: 100,

                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            //height: 100,
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  side: BorderSide(
                                      color: Colors.green, width: 5),
                                ),
                                onPressed: () async {
                                  var now = DateTime.now();
                                  var formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
                                  String formattedDate = formatter.format(now);
                                  print(formattedDate);

                                  var deviceDateTimeInfo = formattedDate;
                                  //  prg.show();
                                  if (formKey.currentState!.validate()) {
                                    if (getOTPValue == codeValue) {
                                      //prg.hide();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SecuResetPassword(
                                                  phoneNumber:
                                                  widget.mobileNumber.toString(),
                                                  countryCode:
                                                  widget.countryCode.toString())),
                                          ModalRoute.withName("/SecuResetPassword"));
                                    } else {
                                      //prg.hide();
                                      Fluttertoast.showToast(
                                          msg: 'Invalid OTP',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: Text("Verify"),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ),
                      TextButton(
                          onPressed: () => snackBar("OTP resend!!"),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: textWidget(),
                          ))
                    ],
                  ),
                ),
              ),
              Spacer(),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
      ),

    );
  }
}
