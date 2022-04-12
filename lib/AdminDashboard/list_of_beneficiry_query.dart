import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/Widget/beneficary_user_tile.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Model/ListOfUser.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';

class ListOfBeneficiryQuery extends StatefulWidget {
  final String wordId;
  final bool isCity;
  const ListOfBeneficiryQuery({Key? key,required this.wordId,required this.isCity}) : super(key: key);

  @override
  _ListOfBeneficiryQueryState createState() => _ListOfBeneficiryQueryState();
}

class _ListOfBeneficiryQueryState extends State<ListOfBeneficiryQuery> {

  List<BeneficiaryData> dataList = [];
  ApiResponse notifyData = ApiResponse(isWorking: true);
  bool isLoading = false;
  int pageNo = 0;
  ScrollController scrollController = ScrollController();
  
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
    var body = {
      if(!widget.isCity)
        'word_id' : widget.wordId,
      if(widget.isCity)
        'union_id' : widget.wordId,
    };
    ApiController().postRequest(endPoint: '${ApiEndPoints().beneficiaryList}?page=$pageNo',body: body,token: GetStorage().read('token')).then((value){

      setState(() {
        print(value.responseCode);
        if(value.responseCode==200){
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
          try{

          }
          catch(e){
            notifyData = ApiResponse(
              isWorking: false,
              responseError: true,
              responseCode: value.responseCode,
            );
            setState(() {
              isLoading = false;
            });
          }
        }else{
          notifyData = ApiResponse(
            isWorking: false,
            responseError: true,
            responseCode: value.responseCode,
          );
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {

          if(notifyData.isWorking!){
            return LoadingWidget();
          }
          if(notifyData.responseCode==404&&pageNo<1){
            return const ShowError(errorMessage: 'এই ওয়ার্ডে কোনো ডাটা খুঁজে পাওয়া যায়নি');
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                controller: scrollController,
                itemCount: dataList.length,
                itemBuilder: (context,position,){
                  return BeneficaryUserTile(beneficiaryData: dataList[position],isReceived: false,);
                },
              ),
              isLoading? Positioned(
                bottom: 10,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.grey[700],borderRadius: BorderRadius.circular(5)),
                    child: LoadingWidget(),
                  ),
                ),
              ):Positioned(
                bottom: 0.0,
                child: Container(),
              ),
            ],
          );
        }
    );
  }
}
