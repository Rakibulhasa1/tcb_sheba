import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/HelperClass.dart';

class CardDeliveryDetails extends StatefulWidget {
  final String userId;
  const CardDeliveryDetails({Key? key,required this.userId}) : super(key: key);

  @override
  _CardDeliveryDetailsState createState() => _CardDeliveryDetailsState();
}

class _CardDeliveryDetailsState extends State<CardDeliveryDetails> {


  ApiResponse apiResponse = ApiResponse(isWorking: true);

  String status = "";
  String date = "";

  @override
  void initState() {
    var body = {"nid_number":"${widget.userId}"};
    ApiController().postRequest(endPoint: "card-delivery-status",body: body).then((value) {

      if(value.responseCode==200){
        setState((){
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: false,
            responseCode: 200,
          );
        });
      }else if(value.responseCode==405){
        setState((){
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: false,
            responseCode: 405,
          );
          CardDeliveryedModel model = cardDeliveryedModelFromJson(value.response.toString());
          status = model.data!.cardDeliveryBy!;
          date = model.data!.cardDeliveryTime!;
        });

      }else{
        setState((){
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        });
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Delivery Status'),),
      body: Builder(
        builder: (context) {

          if(apiResponse.isWorking!){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(apiResponse.responseError!){
            return Center(
              child: Text("Something is wrong"),
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                alignment: Alignment.center,
                height: 200,
                decoration: BoxDecoration(
                  color: apiResponse.responseCode==405?Colors.green.withOpacity(0.5):Colors.green.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: apiResponse.responseCode==405?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("এই উপকারভোগী ইতিমধ্যে টিসিবি কার্ড গ্রহণ করেছেন।",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                    ),
                    SizedBox(height: 24),
                    Text("Delivery By : ${status}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                    Text("Date : ${HelperClass.convertAsMonthDayYearAndTime(date)}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                  ],
                ):apiResponse.responseCode==200?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle,color: Colors.green,size: 42),
                    Text('কার্ড ডেলিভারি করা সফল হয়েছে',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                  ],
                ):Container(),
              ),
            ),
          );
        }
      ),
    );
  }
}


CardDeliveryedModel cardDeliveryedModelFromJson(String str) => CardDeliveryedModel.fromJson(json.decode(str));

class CardDeliveryedModel {
  CardDeliveryedModel({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  factory CardDeliveryedModel.fromJson(Map<String, dynamic> json) => CardDeliveryedModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.cardDeliveryTime,
    this.cardDeliveryBy,
  });

  String? cardDeliveryTime;
  String? cardDeliveryBy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cardDeliveryTime: nullConverter(json["card_delivery_time"]),
    cardDeliveryBy: nullConverter(json["card_delivery_by"]),
  );
}
