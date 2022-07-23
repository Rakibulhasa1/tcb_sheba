import 'package:flutter/material.dart';
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';

class SubmitForRegistration extends StatefulWidget {

  RegistrationBeneficeryModel data;

  SubmitForRegistration({Key? key,required this.data}) : super(key: key);

  @override
  _SubmitForRegistrationState createState() => _SubmitForRegistrationState();
}

class _SubmitForRegistrationState extends State<SubmitForRegistration> {
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
                  Text('${widget.data.nid}', textAlign: TextAlign.center, style: TextStyle()),
                ]),
                TableRow(children: [
                  Text('পুরো নাম', textAlign: TextAlign.center),
                  Text('${widget.data.name}', textAlign: TextAlign.center),
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
                  Text(widget.data.grnderReq==3?'-':'${widget.data.marrigialStatus}', textAlign: TextAlign.center),
                ]),
                TableRow(children: [
                  Text(widget.data.marrigeReq!=5?'  ${widget.data.grnderReq==1?'স্ত্রী':widget.data.grnderReq==2?'স্বামী':'পিতা/মাতা'}':'পিতা/মাতা',textAlign: TextAlign.center),
                  Text('${widget.data.gardianName}', textAlign: TextAlign.center),
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
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green,
                    ),
                    child: Text('সাবমিট করুন',style: TextStyle(color: Colors.white)),
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
