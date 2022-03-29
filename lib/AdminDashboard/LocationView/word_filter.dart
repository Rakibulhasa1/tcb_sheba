import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/AdminDashboard/list_of_beneficiry_query.dart';
import 'package:tcb/AdminDashboard/LocationView/union_filter.dart';
import 'package:tcb/AdminDashboard/view_beneficary_list_tab.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';

class WordFilter extends StatefulWidget {
  final String title;
  final String unionId;
  const WordFilter({Key? key,required this.title,required this.unionId}) : super(key: key);

  @override
  _WordFilterState createState() => _WordFilterState();
}

class _WordFilterState extends State<WordFilter> {

  int  generateRandomNumber() {
    return Random().nextInt(7);
  }

  int areaNumber = 0;
@override
  void initState() {
  DataResponse().getWord(context : context,unionId:  widget.unionId,addressType: 'U');
  DataResponse().getWordArea(context: context,unionId: widget.unionId,addressType: 'U');
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
            child: Text("ওয়ার্ড সমূহ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
          ),
          Consumer<DashboardController>(
              builder: (context,notifyChartData,child) {

                if(notifyChartData.notifyAreaWordData.isWorking!||notifyChartData.notifyWordData.isWorking!){
                  return const LoadingWidget();
                }

                if(notifyChartData.notifyAreaWordData.responseError!||notifyChartData.notifyWordData.responseError!){
                  return const ShowError(errorMessage: 'ডাটা খুঁজে পাওয়া যায়নি');
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notifyChartData.wordAreaList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2/2,
                    ),
                    itemBuilder: (context,position){
                      Color randomSelected = HelperClass().randomColor[generateRandomNumber()];

                      return InkWell(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewBeneficaryListTab(wordId: notifyChartData.wordName[position].wordId,)));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: randomSelected.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(notifyChartData.wordAreaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                              const SizedBox(height: 12,),
                              Text('${notifyChartData.wordAreaList[position].beneficiaryTotalQty}/${notifyChartData.wordAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
