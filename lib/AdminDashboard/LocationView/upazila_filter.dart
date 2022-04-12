import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Model/area_data_query_model.dart';
import 'package:tcb/AdminDashboard/Model/district_list_model.dart';
import 'package:tcb/AdminDashboard/Model/union_list_model.dart';
import 'package:tcb/AdminDashboard/Model/upazila_list_model.dart';
import 'package:tcb/AdminDashboard/Model/word_list_model.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_selectable.dart';
import 'package:tcb/AdminDashboard/LocationView/city_corprotion_word.dart';
import 'package:tcb/AdminDashboard/LocationView/union_filter.dart';
import 'package:tcb/AdminDashboard/LocationView/word_filter.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tcb/HelperClass.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';


class UpazilaFilter extends StatefulWidget {

  final String districtId;
  final String name;


  const UpazilaFilter({Key? key,required this.districtId,required this.name}) : super(key: key);

  @override
  _UpazilaFilterState createState() => _UpazilaFilterState();
}

class _UpazilaFilterState extends State<UpazilaFilter> {

  List<AreaModel> upazilaAreaList = [];
  List<AreaModel> cityAreaList = [];
  int areaNumber = 0;
  int  generateRandomNumber() {
    return Random().nextInt(7);
  }

  String keyAddress = 'উপজেলা';

  String key = 'সিটি কর্পোরেশন';

  @override
  void initState() {
    DataResponse().getUpazilaArea(context: context,districtId: widget.districtId);
    upazilaAreaList.clear();
    cityAreaList.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} জেলা'),
      ),
      body: Consumer<DashboardController>(
        builder: (context,notifyChartData,child) {
          if(notifyChartData.notifyAreaUpazilaData.isWorking!){
            return const LoadingWidget();
          }

          if(notifyChartData.notifyAreaUpazilaData.responseError!){
            return const ShowError(errorMessage: 'ডাটা খুঁজে পাওয়া যায়নি');
          }

          if(!notifyChartData.notifyAreaUpazilaData.responseError!&&!notifyChartData.notifyAreaUpazilaData.isWorking!){
            upazilaAreaList.clear();
            cityAreaList.clear();
            for(int i=0;i<notifyChartData.upazilaAreaList.length;i++){
              if(notifyChartData.upazilaAreaList[i].areaName.contains(key)){
                cityAreaList.add(notifyChartData.upazilaAreaList[i]);
              }else{
                upazilaAreaList.add(notifyChartData.upazilaAreaList[i]);
              }
            }
          }

          return ListView(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    CustomButtonWithSelectable(
                      title: 'উপজেলা',
                      isSelectable: areaNumber==0?true:false,
                      onTab: (){
                        setState(() {
                          areaNumber = 0;
                          keyAddress  = 'উপজেলা';
                          upazilaAreaList.clear();
                          cityAreaList.clear();
                          for(int i=0;i<notifyChartData.upazilaAreaList.length;i++){
                            if(notifyChartData.upazilaAreaList[i].areaName.contains(key)){
                              cityAreaList.add(notifyChartData.upazilaAreaList[i]);
                            }else{
                              upazilaAreaList.add(notifyChartData.upazilaAreaList[i]);
                            }
                          }
                        });
                      },
                    ),
                    CustomButtonWithSelectable(
                      title: 'সিটি কর্পোরেশন',
                      isSelectable: areaNumber==1?true:false,
                      onTab: (){
                        setState(() {
                          areaNumber = 1;
                          keyAddress  = 'সিটি কর্পোরেশন';
                          upazilaAreaList.clear();
                          cityAreaList.clear();
                          for(int i=0;i<notifyChartData.upazilaAreaList.length;i++){
                            if(notifyChartData.upazilaAreaList[i].areaName.contains(key)){
                              cityAreaList.add(notifyChartData.upazilaAreaList[i]);
                            }else{
                              upazilaAreaList.add(notifyChartData.upazilaAreaList[i]);
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Text('${widget.name } ${keyAddress}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
              ),
              areaNumber==0?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: upazilaAreaList.length,
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>UnionFilter(
                            upazilaId : upazilaAreaList[position].areaId,
                            title: upazilaAreaList[position].areaName,
                            name: 'ইউনিয়ন',
                          )));
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
                              Text(upazilaAreaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                              const SizedBox(height: 12,),
                              Text('${upazilaAreaList[position].beneficiaryTotalQty}/${upazilaAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
              ):Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cityAreaList.length,
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
                          String cityCorp = '${cityAreaList[position].areaName}';
                          String machCityData = 'কর্পোরেশন';
                          print('${cityCorp.contains(machCityData)} ${cityCorp}');
                          if(cityCorp.contains(machCityData)){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>CityCorporationWord(name: 'ওয়ার্ড', upazilaId: cityAreaList[position].areaId, title: cityAreaList[position].areaName,)));
                          }else{
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>UnionFilter(title: cityAreaList[position].areaName, upazilaId: cityAreaList[position].areaId,name: 'উপজেলা',)));
                          }
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
                              Text(cityAreaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                              const SizedBox(height: 12,),
                              Text('${cityAreaList[position].beneficiaryTotalQty}/${cityAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
              ),
            ],
          );
        }
      ),
    );
  }
}
