import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/Model/DealerReportModel.dart';
import 'package:tcb/AdminDashboard/view_report_data.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/GeneralDashboard/report_download.dart';
import 'package:tcb/HelperClass.dart';


class CreateReport extends StatefulWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {

  List<DealerReportList>? dealerReportList;
  ApiResponse apiResponse = ApiResponse(isWorking: true);

  @override
  void initState() {
    getReport();
    super.initState();
  }

  void getReport(){
    ApiController().postRequest(endPoint: ApiEndPoints().dealerReport,token: GetStorage().read('token')).then((value){

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
      body: Builder(
        builder: (context) {
          if(apiResponse.isWorking!){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(apiResponse.responseError!){
            return Center(
              child: Text('No Data Found'),
            );
          }
          return ListView(
            children: [
              Scrollbar(
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
                      DataColumn(
                        label: Text(
                          'Action',
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      for(int i=0;i<dealerReportList!.length;i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('${i+1}')),
                            DataCell(Text('${dealerReportList![i].packageName}')),
                            DataCell(Text('${dealerReportList![i].stepName}')),
                            DataCell(Text('${HelperClass.convertAsMonthDayYear(dealerReportList![i].deliveryStartDateTime)}')),
                            DataCell(Text('${HelperClass.convertAsMonthDayYear(dealerReportList![i].deliveryEndDateTime)}')),
                            DataCell(Text('${dealerReportList![i].totalBeneficiary}')),
                            DataCell(Text('${dealerReportList![i].receiverTotalQty}')),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ReportDownload()));
                                    },
                                    icon: Icon(Icons.remove_red_eye),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
      
    );
  }
}
