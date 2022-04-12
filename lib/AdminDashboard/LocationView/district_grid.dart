import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_selectable.dart';
import 'package:tcb/AdminDashboard/LocationView/upazila_filter.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';

class DistrictGrid extends StatefulWidget {
  final String divisionId;
  final String title;
  const DistrictGrid({Key? key,required this.divisionId,required this.title}) : super(key: key);

  @override
  _DistrictGridState createState() => _DistrictGridState();
}

class _DistrictGridState extends State<DistrictGrid> {
  TextEditingController searchController = TextEditingController();
  int areaNumber = 0;
  String isReceived = '0';

  String areaChangeData='সকল';


  int  generateRandomNumber() {
    return Random().nextInt(7);
  }



    @override
  void initState() {
    DataResponse().getDistrictArea(context: context,divisionId: widget.divisionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title} বিভাগ'),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Text('জেলা সমূহ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
          ),
          Consumer<DashboardController>(
              builder: (context,notifyChartData,child) {

                if(notifyChartData.notifyAreaDistrictData.isWorking!){
                  return const LoadingWidget();
                }

                if(notifyChartData.notifyAreaDistrictData.responseError!){
                  return const ShowError(errorMessage: 'ডাটা খুঁজে পাওয়া যায়নি');
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notifyChartData.districtAreaList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2/2,
                    ),
                    itemBuilder: (context,position){

                      Color randomSelected = HelperClass().randomColor[generateRandomNumber()];

                      return Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 5.0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpazilaFilter(districtId: notifyChartData.districtAreaList[position].areaId, name: notifyChartData.districtAreaList[position].areaName)));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: randomSelected.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(notifyChartData.districtAreaList[position].areaName,style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                                const SizedBox(height: 12,),
                                Text('${notifyChartData.districtAreaList[position].beneficiaryTotalQty}/${notifyChartData.districtAreaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold,fontSize: 14),),
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
