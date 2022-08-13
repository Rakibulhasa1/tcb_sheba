import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Model/ListOfUser.dart';

class ViewReportData extends StatefulWidget {
  const ViewReportData({Key? key}) : super(key: key);

  @override
  _ViewReportDataState createState() => _ViewReportDataState();
}

class _ViewReportDataState extends State<ViewReportData> {

  ScrollController scrollController = ScrollController();
  ApiResponse notifyData = ApiResponse(isWorking: true);
  List<BeneficiaryData> dataList = [];
  int pageNo = 0;
  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report'),),
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
                  Consumer<DealerInfoController>(
                    builder: (context,data,child) {

                      if(data.apiResponse.isWorking!){
                        return Container();
                      }
                      if(data.apiResponse.responseError!){
                        return Container();
                      }

                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            Text('${data.dealerInfoModels!.dealerOrgName}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[700])),
                            Text('${data.dealerInfoModels!.dealerAddress}'),
                            Text('${data.dealerInfoModels!.dealerMobile}'),
                            Text('Licence : ${data.dealerInfoModels!.dealerLicenceNo}'),
                          ],
                        ),
                      );
                    }
                  ),
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
