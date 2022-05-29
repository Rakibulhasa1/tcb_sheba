import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/LocationView/city_corprotion_word.dart';
import 'package:tcb/AdminDashboard/LocationView/union_filter.dart';
import 'package:tcb/AdminDashboard/LocationView/upazila_filter.dart';
import 'package:tcb/AdminDashboard/LocationView/word_filter.dart';
import 'package:tcb/AdminDashboard/Model/step_list_model.dart';
import 'package:tcb/AdminDashboard/beneficary_list_view.dart';
import 'package:tcb/AdminDashboard/LocationView/district_grid.dart';
import 'package:tcb/AdminDashboard/view_beneficary_list_tab.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tcb/Model/DashboardModel.dart';
import 'package:tcb/app_theme.dart';


class AdminDashboard extends StatefulWidget {

  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  TextEditingController searchController = TextEditingController();
  bool isReceivePieChart = true;

  List<AreaWiseData> testDivisionData = [

    AreaWiseData(areaName: '-', beneficiaryTotalQty: 0,receiverTotalQty: 0),
    AreaWiseData(areaName: '-', beneficiaryTotalQty: 0,receiverTotalQty: 0),
    AreaWiseData(areaName: '-', beneficiaryTotalQty: 0,receiverTotalQty: 0),
  ];


  List<TimerList> dropdownList = [
    TimerList(title: 'Till Today', startData: DateTime(2022,03,01),endData: DateTime.now()),
    TimerList(title: 'Today', startData: DateTime.now(),endData: DateTime.now()),
    TimerList(title: 'Yesterday', startData: DateTime.now().subtract(const Duration(days: 1)),endData: DateTime.now()),
    TimerList(title: 'Last 7 Days', startData: DateTime.now().subtract(const Duration(days: 7)),endData: DateTime.now()),
    TimerList(title: 'Last 30 Days', startData: DateTime.now().subtract(const Duration(days: 30)),endData: DateTime.now()),
    // TimerList(title: 'This Month', startData: DateTime.now(),endData: DateTime.now()),
    // TimerList(title: 'Last Month', startData: DateTime.now(),endData: DateTime.now()),
  ];


  TimerList? dropSelectedText;

  TimerList? defaultDate = TimerList(title: 'Till Today', startData: DateTime(2022,03,01),endData: DateTime.now());


  List<StepModel> stepList = [];


  StepModel? selectStep = StepModel(stepName: 'ধাপ-১',stepId: '1',createdBy: '',deliveryEndDateTime: '',deliveryStartDateTime: '');

  @override
  void initState() {
    DataResponse().getAdminData(context: context,prams: '?start=${DateTime(2022,03,01)}&end=${DateTime.now()}&step_id=${selectStep!.stepId}');
    DataResponse().getStepData(context: context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        const SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 154,
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text('Till Today'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    value: dropSelectedText,
                    items: dropdownList.map((TimerList items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.title),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropSelectedText = newValue! as TimerList?;
                        String prams = '?start=${dropSelectedText!.startData}&end=${dropSelectedText!.endData}&step_id=${selectStep!.stepId}';
                        DataResponse().getAdminData(context: context,prams: prams);
                      });
                    },
                  ),
                ),
              ),
              Consumer<DashboardController>(
                builder: (context,notifyData,child) {
                  if(notifyData.notifyDropDown.isWorking!){
                    notifyData.stepModel.clear();
                    return Container();
                  }
                  if(notifyData.notifyDropDown.responseError!){
                    return Container();
                  }
                  if(!notifyData.notifyDropDown.responseError!&&!notifyData.notifyDropDown.isWorking!){
                    stepList = notifyData.stepModel;
                  }
                  return Container(
                    height: 38,
                    width: 154,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('${selectStep!.stepName}'),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        items: stepList.map((StepModel items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items.stepName),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectStep = newValue! as StepModel?;
                          });

                          setState(() {
                            if(dropSelectedText!=null){
                              String prams = '?start=${dropSelectedText!.startData}&end=${dropSelectedText!.endData}&step_id=${selectStep!.stepId}';
                              DataResponse().getAdminData(context: context,prams: prams);
                            }else{
                              String prams = '?start=${defaultDate!.startData}&end=${defaultDate!.endData}&step_id=${selectStep!.stepId}';
                              DataResponse().getAdminData(context: context,prams: prams);
                            }
                          });
                        },
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
        Consumer<DashboardController>(
          builder: (context,notifyData,child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap : (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>const BeneficaryListView(isBeneficiaryList: true,title: 'নিবন্ধিত উপকারভোগী',)));
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryPerpleColor.withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 130,
                              child : Text('নিবন্ধিত\nউপকারভোগী',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Builder(
                              builder: (context) {
                                if(notifyData.notifyDashboardData.isWorking!){
                                  return const Text("-",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                }
                                if(notifyData.notifyDashboardData.responseError!){
                                  return const Text("Something is wrong\nTry Again",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                }
                                return Text(notifyData.data!.totalBeneficiary,style: const TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap : (){
                      //Navigator.push(context, CupertinoPageRoute(builder: (context)=>DivisionGrid(receiverData: '1',)));
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>const BeneficaryListView(isBeneficiaryList: false,title: 'সুবিধাপ্রাপ্ত উপকারভোগী',)));
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColorGreenLite.withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 130,
                              child: Text('সুবিধাপ্রাপ্ত উপকারভোগী',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Builder(
                                builder: (context) {
                                  if(notifyData.notifyDashboardData.isWorking!){
                                    return const Text("-",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                  }
                                  if(notifyData.notifyDashboardData.responseError!){
                                    return const Text("Something is wrong\nTry Again",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                  }
                                  return Text(notifyData.data!.totalReceiver,style: const TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                SizedBox(
                  height : 200,
                  child: Consumer<DashboardController>(
                    builder: (context,notifyPieChart,child) {

                      Map<String, double> totalBeneficery = {};
                      Map<String, double> totalReceiveBeneficery = {};

                      double total = 0;
                      if(notifyPieChart.pieChartDataList.isNotEmpty){
                        if(notifyPieChart.pieChartDataList.length>6){
                          for(int i=0;i<6;i++){
                            totalBeneficery['${notifyPieChart.pieChartDataList[i].beneficiaryOccupationName}'] = notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble();
                            totalReceiveBeneficery['${notifyPieChart.pieChartDataList[i].beneficiaryOccupationName}'] = notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble();
                          }
                          for(int i=6;i<notifyPieChart.pieChartDataList.length;i++){
                            total = total + notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble();
                          }

                          totalBeneficery['অন্যান্য'] = total;
                          totalReceiveBeneficery['অন্যান্য'] = total;
                        }else{
                          for(int i=0;i<notifyPieChart.pieChartDataList.length;i++){
                            totalBeneficery['${notifyPieChart.pieChartDataList[i].beneficiaryOccupationName}'] = notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble();
                            totalReceiveBeneficery['${notifyPieChart.pieChartDataList[i].beneficiaryOccupationName}'] = notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble();

                            log("${notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble()}");
                            log("${notifyPieChart.pieChartDataList[i].receiverTotalQty!.toDouble()}");
                          }
                        }

                      }else{
                        totalBeneficery[' এই তারিখের\n কোন ডাটা নেই'] = 0.99;
                        totalReceiveBeneficery[' এই তারিখের\n কোন ডাটা নেই'] = 0.99;
                      }

                      return Builder(
                        builder: (context) {
                          if(notifyPieChart.notifyDashboardData.isWorking!){
                            return Container();
                          }
                          if(notifyPieChart.notifyDashboardData.responseError!){
                            return Container();
                          }
                          return PieChart(
                            dataMap: isReceivePieChart?totalReceiveBeneficery:totalBeneficery,
                            animationDuration: const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 1.5,
                            colorList: [
                              Colors.red.withOpacity(0.5),
                              Colors.green.withOpacity(0.5),
                              Colors.blue.withOpacity(0.5),
                              Colors.yellow.withOpacity(0.5),
                              Colors.deepPurple.withOpacity(0.5),
                              Colors.black.withOpacity(0.5),
                              Colors.blueGrey.withOpacity(0.5),
                            ],
                            initialAngleInDegree: 0,

                            ringStrokeWidth: 48,

                            legendOptions: const LegendOptions(

                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 0,
                            ),
                          );
                        }
                      );
                    }
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap :(){
                      //     setState(() {
                      //       isReceivePieChart = false;
                      //     });
                      //   },
                      //   child: Container(
                      //     height: 30,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       color: !isReceivePieChart?Colors.green.withOpacity(0.5):Colors.white,
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      //       child: Text('সর্বমোট উপকারভোগী',style: TextStyle(color: !isReceivePieChart?Colors.black:Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold),),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 12,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isReceivePieChart = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isReceivePieChart?Colors.green.withOpacity(0.5):Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            child: Text('সুবিধাপ্রাপ্ত উপকারভোগী',style: TextStyle(color: isReceivePieChart?Colors.black:Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
              ],
            ),
          ),
        ),


        const SizedBox(height: 24,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            child: Consumer<DashboardController>(
              builder: (context,notifyData,child) {

                List<charts.Series<AreaWiseData, String>> seriesData = [];

                seriesData.add(
                  charts.Series(
                    labelAccessorFn: (AreaWiseData pollution, _) => pollution.beneficiaryTotalQty.toString(),
                    domainFn: (AreaWiseData pollution, _) => pollution.areaName,
                    measureFn: (AreaWiseData pollution, _) => pollution.beneficiaryTotalQty,
                    id: 'beneficiaryList',
                    data: testDivisionData,
                    fillPatternFn: (_, __) => charts.FillPatternType.solid,
                    fillColorFn: (AreaWiseData pollution, _) =>
                        charts.ColorUtil.fromDartColor(primaryPerpleColor),
                  ),
                );

                seriesData.add(
                  charts.Series(
                    labelAccessorFn: (AreaWiseData pollution, _) => pollution.beneficiaryTotalQty.toString(),
                    domainFn: (AreaWiseData pollution, _) => pollution.areaName,
                    measureFn: (AreaWiseData pollution, _) => pollution.beneficiaryTotalQty,
                    id: 'beneficiaryReceiveList',
                    data: testDivisionData,
                    fillPatternFn: (_, __) => charts.FillPatternType.solid,
                    fillColorFn: (AreaWiseData pollution, _) =>
                        charts.ColorUtil.fromDartColor(primaryColorGreenLite),
                  ),
                );




                if(!notifyData.notifyDashboardData.isWorking!&&!notifyData.notifyDashboardData.responseError!){
                  seriesData.clear();

                  var beneficiaryList = notifyData.divisionListAndQty;
                  var beneficiaryReceiveList = notifyData.divisionListAndQty;

                  seriesData.add(
                    charts.Series(
                      labelAccessorFn: (AreaWiseData pollution, _) => pollution.beneficiaryTotalQty.toString(),
                      domainFn: (AreaWiseData pollution, _) => pollution.areaName,
                      measureFn: (AreaWiseData pollution, _) => pollution.beneficiaryTotalQty,
                      id: 'beneficiaryList',
                      data: beneficiaryList!,
                      fillPatternFn: (_, __) => charts.FillPatternType.solid,
                      fillColorFn: (AreaWiseData pollution, _) => charts.ColorUtil.fromDartColor(primaryPerpleColor),
                    ),
                  );

                  seriesData.add(
                    charts.Series(
                      labelAccessorFn: (AreaWiseData pollution, _) => pollution.receiverTotalQty.toString(),
                      domainFn: (AreaWiseData pollution, _) => pollution.areaName,
                      measureFn: (AreaWiseData pollution, _) => pollution.receiverTotalQty,
                      id: 'beneficiaryReceiveList',
                      data: beneficiaryReceiveList!,
                      fillPatternFn: (_, __) => charts.FillPatternType.solid,
                      fillColorFn: (AreaWiseData pollution, _) =>
                          charts.ColorUtil.fromDartColor(primaryColorGreenLite),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: SizedBox(
                          height: 260,
                          width: notifyData.divisionListAndQty!.isNotEmpty?notifyData.divisionListAndQty!.length*110:600,
                          child: charts.BarChart(
                            seriesData,
                            animate: true,
                            barRendererDecorator: charts.BarLabelDecorator<String>(
                              insideLabelStyleSpec: charts.TextStyleSpec(
                                fontWeight: "bold",
                                fontSize: 8,
                                color: charts.ColorUtil.fromDartColor(Colors.white),
                              ),
                              outsideLabelStyleSpec: charts.TextStyleSpec(
                                fontSize: 8,
                                color: charts.ColorUtil.fromDartColor(Colors.black),
                              ),
                            ),
                            barGroupingType: charts.BarGroupingType.grouped,
                            animationDuration: const Duration(microseconds: 1000),
                                selectionModels: [
                                  charts.SelectionModelConfig(
                                    type: charts.SelectionModelType.info,
                                    changedListener: (charts.SelectionModel model){
                                      switch(model.selectedDatum[0].datum.areaType){
                                        case 'D':
                                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>DistrictGrid(title: model.selectedDatum[0].datum.areaName, divisionId: model.selectedDatum[0].datum.areaId)));
                                          break;
                                        case 'DI':
                                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpazilaFilter(name: model.selectedDatum[0].datum.areaName, districtId: model.selectedDatum[0].datum.areaId)));
                                          break;
                                        case 'U':
                                          String cityCorp = '${model.selectedDatum[0].datum.areaName}';
                                          String machCityData = 'সিটি কর্পোরেশন';
                                          if(cityCorp.contains(machCityData)){
                                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>CityCorporationWord(name: 'ওয়ার্ড', upazilaId: model.selectedDatum[0].datum.areaId, title: model.selectedDatum[0].datum.areaName,)));
                                          }else{
                                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>UnionFilter(title: model.selectedDatum[0].datum.areaName, upazilaId: model.selectedDatum[0].datum.areaId,name: model.selectedDatum[0].datum.areaName,)));
                                          }
                                          break;
                                        case 'UI':
                                          String cityCorp = '${model.selectedDatum[0].datum.areaName}';
                                          String machWordData = 'ওয়ার্ড';
                                          if(cityCorp.contains(machWordData)){
                                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewBeneficaryListTab(wordId: model.selectedDatum[0].datum.areaId,isCity: true,)));
                                          }else{
                                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>WordFilter(unionId: model.selectedDatum[0].datum.areaId,title: model.selectedDatum[0].datum.areaName,)));
                                          }
                                          break;
                                        case 'W':
                                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewBeneficaryListTab(wordId: model.selectedDatum[0].datum.areaId,isCity: false,)));
                                          break;
                                      }
                                    },
                                  ),
                                ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
        const SizedBox(height: 48,),
      ],
    );
  }
}

class TimerList{
  final String title;
  final DateTime startData;
  final DateTime endData;

  TimerList({required this.title,required this.startData,required this.endData});
}
