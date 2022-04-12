import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/AdminDashboard/view_beneficary_list_tab.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';

class CityCorporationWord extends StatefulWidget {
  final String title;
  final String upazilaId;
  final String name;
  const CityCorporationWord({Key? key,required this.title,required this.upazilaId,required this.name}) : super(key: key);

  @override
  _CityCorporationWordState createState() => _CityCorporationWordState();
}

class _CityCorporationWordState extends State<CityCorporationWord> {

  int  generateRandomNumber() {
    return Random().nextInt(7);
  }

  int areaNumber = 0;

  @override
  void initState() {
    DataResponse().getUnionArea(context: context,upazilaId: widget.upazilaId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Text("${widget.name} সমূহ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
          ),
          Consumer<DashboardController>(
            builder: (context,notifyChartData,child) {

              if(notifyChartData.notifyAreaUnionData.isWorking!){
                return const LoadingWidget();
              }

              if(notifyChartData.notifyAreaUnionData.responseError!){
                return const ShowError(errorMessage: 'ডাটা খুঁজে পাওয়া যায়নি');
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifyChartData.unionAreaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2/2,
                  ),
                  itemBuilder: (context,position){
                    Color randomSelected = HelperClass().randomColor[generateRandomNumber()];

                    return Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewBeneficaryListTab(
                            wordId: notifyChartData.unionAreaList[position].areaId,
                            isCity: true,
                          )));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: randomSelected.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(notifyChartData.unionAreaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                              const SizedBox(height: 12,),
                              Text('${notifyChartData.unionAreaList[position].beneficiaryTotalQty}/${notifyChartData.unionAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
                              const SizedBox(height: 12,),
                              Container(
                                height: 5,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: randomSelected,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
