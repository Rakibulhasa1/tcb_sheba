import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/BeneficeryDashboard/View/beneficery_side_navigation.dart';
import 'package:tcb/show_toast.dart';

class RegistrationOtp extends StatefulWidget {
  RegistrationBeneficeryModel data;
  String generateOtp;
  RegistrationOtp({Key? key,required this.data,required this.generateOtp}) : super(key: key);

  @override
  _RegistrationOtpState createState() => _RegistrationOtpState();
}

class _RegistrationOtpState extends State<RegistrationOtp> {
  String completePin = '';
  String status = "OTP Matching...";

  TextEditingController myController = TextEditingController();
  ApiResponse otpResponse = ApiResponse(isWorking: false);

  @override
  void initState() {
    myController.text = widget.generateOtp;
    completePin = widget.generateOtp;
    super.initState();
  }

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
          //Text(widget.password,style: TextStyle(fontSize: 14,color: Colors.black)),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Pinput(
              controller: myController,
              onCompleted: (pin){
                setState(() {
                  completePin = pin;
                });
              },

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
          Text('$status',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
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
                      "generated_code": completePin.toString(),
                      "mobile_number" : widget.data.phone.toString(),
                    };
                    ApiController().loginResponse(endPoint: ApiEndPoints().otpVerification,body: body).then((value){
                      print(GetStorage().read("regF"));
                      if(value.responseCode==200){
                        setState((){
                          status = "Data Sending...";
                        });

                        Map<String, String> body = {
                          "full_name" : widget.data.fulName,
                          "smart_card_no" : widget.data.smartCardNid,
                          "nid_number" : widget.data.oldNid,
                          "date_of_birth" : widget.data.dateOfBirth,
                          "full_data" : widget.data.fullData,
                          "br_no" : '123456',
                          "beneficiary_father_name": widget.data.fatherName,
                          "beneficiary_mother_name" : widget.data.motherName,
                          "beneficiary_gender" : widget.data.gender,
                          "beneficiary_maritial_status" : widget.data.marrigialStatus,
                          "beneficiary_spouse_name" : widget.data.spouseName,
                          "beneficiary_occupation_name" : widget.data.ocupation,
                          "beneficiary_mobile" : widget.data.phone,
                          "permanent_address_village" : widget.data.currentAddress,
                          "permanent_address_holding_no" : widget.data.houseHolding,
                          "spouse_nid" : widget.data.spouseNid,
                          "spouse_smart_card" : widget.data.smartCardNid,
                          "spouse_dob" : widget.data.spouseDob,
                          "family_member" : widget.data.familyNumber.toString(),
                          "word_id" : GetStorage().read("regF"),
                        };

                        print(GetStorage().read("regF"));

                        ApiController().userRegistration(endPoint: ApiEndPoints().beneficiaryRegistration,body: body, dataModel: widget.data).then((value) {
                          if(value.responseCode==200){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }else{
                            setState(() {
                              otpResponse = ApiResponse(
                                isWorking: false,
                                responseError: true,
                              );
                              status = "";
                            });
                          }
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
