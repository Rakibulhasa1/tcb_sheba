import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:intl/intl.dart';
import 'package:tcb/show_toast.dart';
import 'package:tcb/success_screen.dart';

import 'ApiConfig/ApiController.dart';
import 'ApiConfig/ApiEndPoints.dart';

class SecuResetPassword extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;

  const SecuResetPassword({Key? key, this.phoneNumber, this.countryCode})
      : super(key: key);

  @override
  State<SecuResetPassword> createState() => _SecuResetPasswordState();
}

class _SecuResetPasswordState extends State<SecuResetPassword> {
  final newPasswordController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isWorking = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isShowPass = true;
  bool isShowConfirmPass = true;
  bool onError = false;
  late ProgressDialog prg;
  final formKey = GlobalKey<FormState>();
  String password = '';
  String confirmPassword = '';
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
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/images/regBg.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title:
            Text('Change Password', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),

          ),
          //backgroundColor: Colors.transparent,
          body: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ResetPasswordImage(),

                      // Container(
                      //   height: 2,
                      //   width: double.infinity,
                      //   color: Colors.amber,
                      // ),
                      SizedBox(
                        height: 150,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Text(
                            'New Password',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 30, right: 35, top: 10),
                          child: TextFormField(
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14),
                              controller: newPasswordController,
                              obscureText: isShowPass,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Your Password",
                                alignLabelWithHint: true,
                                prefixIcon: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        height: 20,
                                        child: Icon(Icons.lock)
                                      ),
                                    ),
                                    onTap: () {}),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.fromLTRB(8, 5, 10, 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isShowPass = !isShowPass;
                                      });
                                    },
                                    child: Icon(
                                      isShowPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 16,
                                    )),
                              ),
                              // inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                              onChanged: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Password is required please enter';
                                }
                                // you can check password length and specifications

                                return null;
                              })),
                      onError
                          ? Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            Text('', style: TextStyle(color: Colors.red)),
                          ))
                          : Container(),
                      SizedBox(
                        height: 5,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 1, right: 230),
                      //   child: Text("@ Confirm Password"),
                      //   //"Don't worry! it happens.Please enter the \n address associated with your account."),
                      // ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Text(
                            'Conform Password',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 30, right: 35, top: 10),
                          child: TextFormField(
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14),
                              controller: confirmPassController,
                              obscureText: isShowConfirmPass,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Your Password",
                                alignLabelWithHint: true,
                                prefixIcon: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        height: 20,
                                        child: Icon(Icons.lock_open)
                                      ),
                                    ),
                                    onTap: () {}),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.fromLTRB(8, 5, 10, 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isShowConfirmPass = !isShowConfirmPass;
                                      });
                                    },
                                    child: Icon(
                                      isShowConfirmPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 16,
                                    )),
                              ),
                              // inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                              onChanged: (value) {
                                confirmPassword = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Conform password is required please enter';
                                }
                                if (value != password) {
                                  return 'Confirm password not matching';
                                }
                                return null;
                              })),
                      onError
                          ? Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            Text('', style: TextStyle(color: Colors.red)),
                          ))
                          : Container(),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
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
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green

                                        // textStyle: CustomTextStyle.textFormFieldMedium
                                        //     .copyWith(fontSize: 15, fontWeight: FontWeight.normal)
                                      ),
                                      onPressed: () async {


                                        var body = {
                                          'new_password' : passwordController.text,
                                          'verify_password' : confirmPasswordController.text,
                                        };

                                        if(confirmPasswordController.text==passwordController.text){
                                          setState(() {
                                            isWorking = true;
                                          });

                                          ApiController().postRequest(endPoint: ApiEndPoints().forgotPassword,body: body).then((value){

                                            if(value.responseCode==199){
                                              setState(() {
                                                isWorking = false;
                                              });
                                              ShowToast.myToast("Password Changes", Colors.black, 1);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      // ignore: prefer_const_constructors
                                                      SuccessScreen()),
                                                  ModalRoute.withName(
                                                      "/successScreen"));
                                            }
                                            else{
                                              setState(() {
                                                isWorking = false;
                                              });
                                              ShowToast.myToast("Something is wrong", Colors.black, 1);

                                            }
                                          });

                                        }else{
                                          setState(() {
                                            isWorking = false;
                                          });
                                          ShowToast.myToast("Password don't match", Colors.black, 1);
                                        }




                                        if (formKey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          var now = DateTime.now();
                                          var formatter =
                                          DateFormat('yyyy-MM-dd hh:mm:ss');
                                          String formattedDate = formatter.format(now);
                                          print(formattedDate);
                                          var deviceDateTimeInfo = formattedDate;
                                          print(confirmPassController.text);
                                          print(widget.phoneNumber.toString());
                                          prg.show();
                                          await ApiClient.resetPasswordAPI(
                                              widget.phoneNumber.toString(),
                                              confirmPassController.text,
                                              '1.2',
                                              deviceDateTimeInfo)
                                              .then((forgetpass) async {
                                            if (forgetpass.status == 'fail') {
                                              prg.hide();

                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Something went wrong please try again",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              prg.hide();

                                              Fluttertoast.showToast(
                                                  msg: forgetpass.message.toString(),
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);

                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      // ignore: prefer_const_constructors
                                                      SuccessScreen()),
                                                  ModalRoute.withName(
                                                      "/successScreen"));
                                            }
                                          });
                                        }
                                      },
                                      child: Text("Submitting"),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ))),
    );
  }
}

class ApiClient {
  static resetPasswordAPI(String resetPasswordAPI, String text, String s, String deviceDateTimeInfo ) {
    const forgotPasswordUrl = 'http://www.tcbsheba.com/api/change-password-update';
  }

  static oTPApi(String oTPApi) {
    const oTPApi = 'http://www.tcbsheba.com/api/receive-info-save';
  }
}
