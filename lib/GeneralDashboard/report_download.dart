import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Model/ListOfUser.dart';

class ReportDownload extends StatefulWidget {
  const ReportDownload({Key? key}) : super(key: key);

  @override
  _ReportDownloadState createState() => _ReportDownloadState();
}

class _ReportDownloadState extends State<ReportDownload> {

  ScrollController scrollController = ScrollController();
  ApiResponse notifyData = ApiResponse(isWorking: true);
  List<BeneficiaryData> dataList = [];
  int pageNo = 0;
  bool isLoading = false;

  Duration? executionTime;

  @override
  void initState() {
    scrollController.addListener(() {
      scrollListener();
    });
    getData();
    super.initState();
  }

  void scrollListener() {

    if (scrollController.position.maxScrollExtent == scrollController.position.extentBefore) {
      setState(() {
        pageNo=pageNo+1;
        isLoading = true;
      });
      getData();
    }
  }

  void getData(){
    ApiController().postRequest(endPoint: '${ApiEndPoints().beneficiaryReceiveList}?page=$pageNo',token: GetStorage().read('token')).then((value){

      setState(() {
        print(value.responseCode);
        if(value.responseCode==200){

          try{
            ListOfUser listOfUser = listOfUserFromJson(value.response.toString());
            dataList.addAll(listOfUser.data!.data!);
            notifyData = ApiResponse(
              isWorking: false,
              responseError: false,
              responseCode: value.responseCode,
            );
            setState(() {
              isLoading = false;
            });
          }
          catch(e){
            setState(() {
              isLoading = false;
            });
            notifyData = ApiResponse(
              isWorking: false,
              responseError: true,
              responseCode: value.responseCode,
            );

          }
        }else{
          setState(() {
            isLoading = false;
          });
          notifyData = ApiResponse(
            isWorking: false,
            responseError: true,
            responseCode: value.responseCode,
          );
        }
      });
    });
  }

  void downloadData()async {
    final stopwatch = Stopwatch()..start();

    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    for (var row = 0; row < dataList.length; row++) {

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)).value = '${dataList[row].beneficiaryNameBangla}';

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row)).value = '${dataList[row].nidNumber}';

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row)).value = "${dataList[row].familyCardNumber}";

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row)).value = "${dataList[row].packageName}";

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = "${dataList[row].stepName}";

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = "${dataList[row].receiveDate}";
    }

    var data = excel.encode();
    File(await getFilePath())..createSync(recursive: true)..writeAsBytes(data!);
    setState(() {
      executionTime = stopwatch.elapsed;
    });
  }

  void shareData()async {
    final stopwatch = Stopwatch()..start();

    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    for (var row = 0; row < dataList.length; row++) {

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)).value = '${dataList[row].beneficiaryNameBangla}';

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row)).value = '${dataList[row].nidNumber}';

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row)).value = "${dataList[row].familyCardNumber}";

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row)).value = "${dataList[row].packageName}";

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = "${dataList[row].stepName}";

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = "${dataList[row].receiveDate}";
    }

    var data = excel.encode();
    File(await getFilePath())..createSync(recursive: true)..writeAsBytes(data!).then((value){
      Share.shareFiles([value.absolute.path], text: 'Report');
    });

    setState(() {
      executionTime = stopwatch.elapsed;
    });
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/report.xlsx';
    return filePath;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Download'),
        actions: [
          IconButton(
            onPressed: (){
              downloadData();
            },
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: (){
              shareData();
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Builder(
          builder: (context) {

            if(notifyData.isWorking!){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(notifyData.responseError!){
              return Center(
                child: Text('No Data Found'),
              );
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                ListView(
                  controller: scrollController,
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
                                'Name',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'NID',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Family Card',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Package',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Step',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Date Time',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            for(int i=0;i<dataList.length;i++)
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('${i+1}')),
                                  DataCell(Text('${dataList[i].beneficiaryNameBangla}')),
                                  DataCell(Text('${dataList[i].nidNumber}')),
                                  DataCell(Text('${dataList[i].familyCardNumber}')),
                                  DataCell(Text('${dataList[i].packageName}')),
                                  DataCell(Text('${dataList[i].stepName}')),
                                  DataCell(Text('${dataList[i].receiveDate}')),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
                isLoading?Positioned(
                  bottom: 0.0,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ):Container(),
              ],
            );
          }
      ),
    );
  }
}
