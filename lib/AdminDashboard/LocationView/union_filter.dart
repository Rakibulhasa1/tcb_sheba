import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/AdminDashboard/Model/area_data_query_model.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_selectable.dart';
import 'package:tcb/AdminDashboard/LocationView/word_filter.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';

class UnionFilter extends StatefulWidget {
  final String title;
  final String upazilaId;
  final String name;
  const UnionFilter({Key? key,required this.title,required this.upazilaId,required this.name}) : super(key: key);

  @override
  _UnionFilterState createState() => _UnionFilterState();
}

class _UnionFilterState extends State<UnionFilter> {


  List<AreaModel> unionList = [];
  List<AreaModel> powrosovaList = [];

  int  generateRandomNumber() {
    return Random().nextInt(7);
  }

  int areaNumber = 0;
  String keyAddress = 'ইউনিয়ন';

  String key = 'পৌরসভা';

  @override
  void initState() {
    DataResponse().getUnionArea(context: context,upazilaId: widget.upazilaId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Consumer<DashboardController>(
        builder: (context,notifyChartData,child) {
          if(notifyChartData.notifyAreaUnionData.isWorking!){
            return const LoadingWidget();
          }

          if(notifyChartData.notifyAreaUnionData.responseError!){
            return const ShowError(errorMessage: 'ডাটা খুঁজে পাওয়া যায়নি');
          }


          if(!notifyChartData.notifyAreaUnionData.responseError!&&!notifyChartData.notifyAreaUnionData.isWorking!){
            unionList.clear();
            powrosovaList.clear();
            for(int i=0;i<notifyChartData.unionAreaList.length;i++){
              if(notifyChartData.unionAreaList[i].areaName.contains(key)){
                powrosovaList.add(notifyChartData.unionAreaList[i]);
              }else{
                unionList.add(notifyChartData.unionAreaList[i]);
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
                      title: 'ইউনিয়ন',
                      isSelectable: areaNumber==0?true:false,
                      onTab: (){
                        setState(() {
                          areaNumber = 0;
                          keyAddress  = 'ইউনিয়ন';
                          unionList.clear();
                          powrosovaList.clear();
                          for(int i=0;i<notifyChartData.unionAreaList.length;i++){
                            if(notifyChartData.unionAreaList[i].areaName.contains(key)){
                              powrosovaList.add(notifyChartData.unionAreaList[i]);
                            }else{
                              unionList.add(notifyChartData.unionAreaList[i]);
                            }
                          }
                        });
                        DataResponse().getUnionArea(context: context,upazilaId: widget.upazilaId,addressType: 'U');
                        },
                    ),
                    CustomButtonWithSelectable(
                      title: 'পৌরসভা',
                      isSelectable: areaNumber==1?true:false,
                      onTab: (){

                        setState(() {
                          areaNumber = 1;
                          keyAddress  = 'পৌরসভা';

                          unionList.clear();
                          powrosovaList.clear();
                          for(int i=0;i<notifyChartData.unionAreaList.length;i++){
                            if(notifyChartData.unionAreaList[i].areaName.contains(key)){
                              powrosovaList.add(notifyChartData.unionAreaList[i]);
                            }else{
                              unionList.add(notifyChartData.unionAreaList[i]);
                            }
                          }
                        });
                        DataResponse().getUnionArea(context: context,upazilaId: widget.upazilaId,addressType: 'P');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Text("${keyAddress} সমূহ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
              ),
              areaNumber==0?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: unionList.length,
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
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>WordFilter(unionId : unionList[position].areaId, title: unionList[position].areaName,)));
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
                            Text(unionList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                            const SizedBox(height: 12,),
                            Text('${unionList[position].beneficiaryTotalQty}/${unionList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
              ):Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: powrosovaList.length,
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
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>WordFilter(unionId : powrosovaList[position].areaId, title: powrosovaList[position].areaName,)));
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
                            Text(powrosovaList[position].areaName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,),
                            const SizedBox(height: 12,),
                            Text('${powrosovaList[position].beneficiaryTotalQty}/${powrosovaList[position].receiverTotalQty}',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 14),),
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
              ),
            ],
          );
        }
      ),
    );
  }
}
