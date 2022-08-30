import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/show_toast.dart';

class SubmitForRegistration extends StatefulWidget {

  RegistrationBeneficeryModel data;

  SubmitForRegistration({Key? key,required this.data}) : super(key: key);

  @override
  _SubmitForRegistrationState createState() => _SubmitForRegistrationState();
}

class _SubmitForRegistrationState extends State<SubmitForRegistration> {

  bool isWorking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 24),
          Center(child: Image.file(widget.data.profileImage,height: 200,width: 200,alignment: Alignment.center)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
            child: Table(
              
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Text('এনআইডি', textAlign: TextAlign.center, style: TextStyle()),
                  Text('${widget.data.oldNid}', textAlign: TextAlign.center, style: TextStyle()),
                ]),
                TableRow(children: [
                  Text('স্মার্ট কার্ড', textAlign: TextAlign.center, style: TextStyle()),
                  Text('${widget.data.smartCardNid}', textAlign: TextAlign.center, style: TextStyle()),
                ]),
                TableRow(children: [
                  Text('পুরো নাম', textAlign: TextAlign.center),
                  Text('${widget.data.fulName}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('জন্ম তারিখ', textAlign: TextAlign.center, style: TextStyle()),
                  Text('${widget.data.dateOfBirth}', textAlign: TextAlign.center, style: TextStyle()),
                ]),
                TableRow(children: [
                  Text('মোবাইলে নম্বর', textAlign: TextAlign.center),
                  Text('${widget.data.phone}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('লিঙ্গ', textAlign: TextAlign.center),
                  Text('${widget.data.gender}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('বৈবাহিক অবস্থা', textAlign: TextAlign.center),
                  Text('${widget.data.marrigialStatus}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('স্ত্রী/স্বামী',textAlign: TextAlign.center),
                  Text('${widget.data.spouseName}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('পিতা/মাতা',textAlign: TextAlign.center),
                  Text('${widget.data.fatherName}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('পেশা', textAlign: TextAlign.center),
                  Text('${widget.data.ocupation}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('বর্তমান ঠিকানা', textAlign: TextAlign.center),
                  Text('${widget.data.currentAddress}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('রাস্তা/পাড়া/মহল্লা', textAlign: TextAlign.center),
                  Text('${widget.data.roadNo}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text('বাড়ি/হোল্ডিং', textAlign: TextAlign.center),
                  Text('${widget.data.houseHolding}', textAlign: TextAlign.center),
                ]),
              ],
            ),
          ),
          Center(child: Image.file(widget.data.nidImage,height: 200,width: MediaQuery.of(context).size.width,alignment: Alignment.center)),
          SizedBox(height: 8),
          Center(child: Image.file(widget.data.nid2Image,height: 200,width: MediaQuery.of(context).size.width,alignment: Alignment.center)),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: Text('এডিট করুন',style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: AnimatedCrossFade(
                    firstChild: InkWell(
                      onTap: (){

                        setState((){
                          isWorking = true;
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
                        };

                        ApiController().userRegistration(endPoint: ApiEndPoints().beneficiaryRegistration,body: body, dataModel: widget.data).then((value) {

                          if(value.responseCode==200){
                            setState((){
                              isWorking = false;
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }else{
                            setState((){
                              isWorking = false;
                            });
                          }
                        });

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                        ),
                        child: const Text('সাবমিট করুন',style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    secondChild: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    crossFadeState: isWorking?CrossFadeState.showSecond:CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 500),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
