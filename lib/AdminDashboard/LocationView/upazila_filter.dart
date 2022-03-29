import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
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

  List<UpazilaModel> myUpazila = [];
  int areaNumber = 0;
  int  generateRandomNumber() {
    return Random().nextInt(7);
  }

  String keyAddress = 'উপজেলা';

  @override
  void initState() {
    DataResponse().getUpazila(context : context,districtId: widget.districtId,addressType: 'U');
    DataResponse().getUpazilaArea(context: context,districtId: widget.districtId,addressType: 'U');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} জেলা'),
      ),
      body: ListView(
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
                    });
                    DataResponse().getUpazila(context : context,districtId: widget.districtId,addressType: 'U');
                    DataResponse().getUpazilaArea(context: context,districtId: widget.districtId,addressType: 'U');
                  },
                ),
                CustomButtonWithSelectable(
                  title: 'সিটি কর্পোরেশন',
                  isSelectable: areaNumber==1?true:false,
                  onTab: (){

                    setState(() {
                      areaNumber = 1;
                      keyAddress  = 'সিটি কর্পোরেশন';
                    });
                    DataResponse().getUpazila(context : context,districtId: widget.districtId,addressType: 'C');
                    DataResponse().getCityCorpArea(context: context,districtId: widget.districtId,addressType: 'C');
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Text('${widget.name } ${keyAddress}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
          ),
          areaNumber==0?Consumer<DashboardController>(
            builder: (context,notifyChartData,child) {
              if(notifyChartData.notifyAreaUpazilaData.isWorking!||notifyChartData.notifyUpazilaData.isWorking!){
                return const LoadingWidget();
              }

              if(notifyChartData.notifyAreaUpazilaData.responseError!||notifyChartData.notifyUpazilaData.responseError!){
                return const ShowError(errorMessage: 'ডাটা খুঁজে পাওয়া যায়নি');
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifyChartData.upazilaAreaList.length,
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
                          if(notifyChartData.upazilaAreaList[position].areaName==notifyChartData.upaName[position].upazilaNameBangla){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>UnionFilter(
                              upazilaId : notifyChartData.upaName[position].upazilaId,
                              title: notifyChartData.upaName[position].upazilaNameBangla,
                              name: 'ইউনিয়ন',
                            )));
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
                              Text(notifyChartData.upazilaAreaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                              const SizedBox(height: 12,),
                              Text('${notifyChartData.upazilaAreaList[position].beneficiaryTotalQty}/${notifyChartData.upazilaAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
          ):Consumer<DashboardController>(
              builder: (context,notifyChartData,child) {
                if(notifyChartData.notifyAreaCityCorp.isWorking!||notifyChartData.notifyUpazilaData.isWorking!){
                  return const LoadingWidget();
                }

                if(notifyChartData.notifyAreaCityCorp.responseError!||notifyChartData.notifyUpazilaData.responseError!){
                  return const ShowError(errorMessage: 'দুঃখিত এই জেলায় কোন \nসিটি কর্পোরেশন খুঁজে পাওয়া যায়নি');
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notifyChartData.cityCorpAreaList.length,
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
                            notifyChartData.notifyAreaUpazilaData.isWorking = true;
                            notifyChartData.notifyUnionData.isWorking = true;
                            if(notifyChartData.cityCorpAreaList[position].areaName==notifyChartData.upaName[position].upazilaNameBangla){
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>CityCorporationWord(
                                upazilaId : notifyChartData.upaName[position].upazilaId,
                                title: notifyChartData.upaName[position].upazilaNameBangla,
                                name: 'ওয়ার্ড',
                              )));
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
                                Text(notifyChartData.cityCorpAreaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                                const SizedBox(height: 12,),
                                Text('${notifyChartData.cityCorpAreaList[position].beneficiaryTotalQty}/${notifyChartData.cityCorpAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
