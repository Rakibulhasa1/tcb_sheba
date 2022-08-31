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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Image.file(widget.data.profileImage,height: 200,width: 150,alignment: Alignment.center,fit: BoxFit.cover,),
                SizedBox(width: 7,),
                Column(
                  children: [
                    Image.file(widget.data.nidImage,height: 100-5,width: MediaQuery.of(context).size.width/2-10,alignment: Alignment.center,fit: BoxFit.cover),
                    SizedBox(height: 7,),
                    Image.file(widget.data.nid2Image,height: 100-5,width :  MediaQuery.of(context).size.width/2-10,alignment: Alignment.center,fit: BoxFit.cover)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('এনআইডি', textAlign: TextAlign.start, style: TextStyle()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.oldNid}', textAlign: TextAlign.start, style: TextStyle()),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('স্মার্ট কার্ড', textAlign: TextAlign.start, style: TextStyle()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.smartCardNid}', textAlign: TextAlign.start, style: TextStyle()),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('পুরো নাম', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.fulName}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('জন্ম তারিখ', textAlign: TextAlign.start, style: TextStyle()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.dateOfBirth}', textAlign: TextAlign.start, style: TextStyle()),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('মোবাইলে নম্বর', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.phone}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('লিঙ্গ', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.gender}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('বৈবাহিক অবস্থা', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.marrigialStatus}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.data.genderType==2?'স্বামীর নাম':widget.data.genderType==1?'স্ত্রীর নাম':"",textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.spouseName}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.data.genderType==2?'স্বামীর nid নম্বর':widget.data.genderType==1?'স্ত্রীর nid নম্বর':'',textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.spouseNid}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.data.genderType==2?'স্বামীর স্মার্ট কার্ড নম্বর':widget.data.genderType==1?'স্ত্রীর স্মার্ট কার্ড নম্বর':'',textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.spouseSmartCard}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.data.genderType==2?'স্বামীর জন্ম তারিখ':widget.data.genderType==1?'স্ত্রীর জন্ম তারিখ':'',textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.spouseDob}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('পিতা/মাতা',textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.fatherName}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('পেশা', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.ocupation}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('বর্তমান ঠিকানা', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.currentAddress}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('রাস্তা/পাড়া/মহল্লা', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.roadNo}', textAlign: TextAlign.start),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('বাড়ি/হোল্ডিং', textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.data.houseHolding}', textAlign: TextAlign.start),
                  ),
                ]),
              ],
            ),
          ),
          Center(),
          SizedBox(height: 8),
          Center(),
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
