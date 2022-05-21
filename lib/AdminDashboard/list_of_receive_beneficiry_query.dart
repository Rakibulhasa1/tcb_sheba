import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/Widget/beneficary_user_tile.dart';
import 'package:tcb/AdminDashboard/user_details_view_by_admin.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Model/ListOfUser.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/show_error.dart';

class ListOfReceiveBeneficiryQuery extends StatefulWidget {
  final String wordId;
  final bool isCity;
  const ListOfReceiveBeneficiryQuery({Key? key,required this.wordId,required this.isCity}) : super(key: key);

  @override
  _ListOfReceiveBeneficiryQueryState createState() => _ListOfReceiveBeneficiryQueryState();
}

class _ListOfReceiveBeneficiryQueryState extends State<ListOfReceiveBeneficiryQuery> {

  List<BeneficiaryData> dataList = [];
  List<BeneficiaryData> filterDataList = [];
  ApiResponse notifyData = ApiResponse(isWorking: true);
  bool isLoading = false;
  int pageNo = 0;
  ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();


  bool isSearchStart = false;

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
    ApiController().postRequest(endPoint: '${ApiEndPoints().beneficiaryReceiveList}?page=$pageNo',body: body,token: GetStorage().read('token')).then((value){

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

          return ListView(
            controller: scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    textAlign: TextAlign.start,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                        height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: (){
                            // setState(() {
                            //   Navigator.push(context, CupertinoPageRoute(builder: (context)=>SearchBeneficiary(nid: '-${searchController.text.toString()}',)));
                            // });
                            if(isSearchStart){
                              setState(() {
                                dataList = filterDataList;
                                isSearchStart = false;
                                searchController.clear();
                              });
                            }
                          },
                          icon: isSearchStart?const Icon(Icons.close,color: Colors.grey,):const Icon(Icons.search,color: Colors.grey,),
                        ),
                        hintStyle: const TextStyle(height: 0.8,fontSize: 13,fontWeight: FontWeight.w300),
                        hintText: 'Search with mobile number or nid',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12)
                    ),
                    controller: searchController,
                    onChanged: (value){
                      setState(() {
                        isSearchStart = true;
                        dataList = dataList.where((element) => element.beneficiaryMobile.contains(value.toString())||
                            element.nidNumber.contains(value.toString())||
                            element.beneficiaryNameBangla.contains(value.toString())||
                            element.beneficiaryNameEnglish.contains(value.toString())
                        ).toList();
                      });
                      print(dataList.length);
                    },
                    onTap: (){
                      setState(() {
                        filterDataList = dataList;
                      });
                    },
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataList.length,
                    itemBuilder: (context,position,){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserDetailsViewByAdmin(userNid: dataList[position].nidNumber,)));
                        },
                        child: BeneficaryUserTile(beneficiaryData: dataList[position],isReceived: true,),
                      );
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
              ),
            ],
          );
        }
    );
  }
}
