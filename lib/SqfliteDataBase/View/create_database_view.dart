import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/AdminDashboard/Model/DealerReportModel.dart';
import 'package:tcb/AdminDashboard/view_report_data.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/ApiConfig/data_response_rovider.dart';
import 'package:tcb/GeneralDashboard/report_download.dart';
import 'package:tcb/HelperClass.dart';

import '../../AdminDashboard/Model/step_list_model.dart';


class CreateReport extends StatefulWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {

  List<DealerReportList>? dealerReportList;

  StepModel? selectStep = StepModel(stepName: 'ধাপ সিলেক্ট করুন',stepId: '',createdBy: '',deliveryEndDateTime: '',deliveryStartDateTime: '');

  ApiResponse apiResponse = ApiResponse(isWorking: true);

  @override
  void initState() {
    getReport(pram: "");
    super.initState();
  }

  void getReport({String? pram}){
    ApiController().postRequest(endPoint: "${ApiEndPoints().dealerReport}$pram").then((value){

      if(value.responseCode==200){
        try{
          setState(() {
            DealerReportModel dealerReportModel = dealerReportModelFromJson(value.response.toString());
            dealerReportList = dealerReportModel.dealerReportList!;
            apiResponse = ApiResponse(
              isWorking: false,
              responseError: false,
            );
          });
        }catch(e){
          setState(() {
            apiResponse = ApiResponse(
              isWorking: false,
              responseError: true,
            );
          });
        }
      }else{
        setState(() {
          apiResponse = ApiResponse(
            isWorking: false,
            responseError: true,
          );
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Consumer<DashboardController>(builder: (context,data,child){
            if(data.notifyDropDown.isWorking!){
              return Padding(
                padding: const EdgeInsets.only(top: 12,left: 24,right: 24),
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                ),
              );
            }
            if(data.notifyDropDown.responseError!){
              return Padding(
                padding: const EdgeInsets.only(top: 12,left: 24,right: 24),
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 12,left: 24,right: 24),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text('${selectStep!.stepName}'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    items: data.stepModel.map((StepModel items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.stepName),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectStep = newValue! as StepModel?;
                      });
                      getReport(pram: '?start=${DateTime(2021,03,01)}&end=${DateTime.now()}&step_id=${selectStep!.stepId}');
                    },
                  ),
                ),
              ),
            );
          }),
          Builder(
              builder: (context) {
                if(apiResponse.isWorking!){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if(apiResponse.responseError!){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Text('No Data Found'),
                    ),
                  );
                }
                return Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'SL',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Action',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'প্যাকেজ',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ধাপ',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Start Date',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'End Date',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'মোট বরাদ্দ',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'মোট বিতরণ',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],
                      rows: <DataRow>[
                        for(int i=0;i<dealerReportList!.length;i++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('${i+1}')),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ReportDownload(stepId: dealerReportList![i].stepId,)));
                                      },
                                      icon: Icon(Icons.remove_red_eye),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(Text('${dealerReportList![i].packageName}')),
                              DataCell(Text('${dealerReportList![i].stepName}')),
                              DataCell(Text('${HelperClass.convertAsMonthDayYear(dealerReportList![i].deliveryStartDateTime)}')),
                              DataCell(Text('${HelperClass.convertAsMonthDayYear(dealerReportList![i].deliveryEndDateTime)}')),
                              DataCell(Text('${dealerReportList![i].totalBeneficiary}')),
                              DataCell(Text('${dealerReportList![i].receiverTotalQty}')),

                            ],
                          ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ],
      ),
      
    );
  }
}
