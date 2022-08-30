import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/user_details_view_by_admin.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/Model/ListOfUser.dart';
import 'package:tcb/app_theme.dart';
import 'package:tcb/loading_widget.dart';
import 'package:tcb/search_beneficiary.dart';

class BeneficaryListView extends StatefulWidget {
  final bool isBeneficiaryList;
  final String title;
  const BeneficaryListView({Key? key,required this.isBeneficiaryList,required this.title}) : super(key: key);

  @override
  _BeneficaryListViewState createState() => _BeneficaryListViewState();
}

class _BeneficaryListViewState extends State<BeneficaryListView> {

  ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();

  bool isLoading = false;

  ListOfUser? listOfUser;
  List<BeneficiaryData> dataList = [];
  List<BeneficiaryData> filterDataList = [];
  ApiResponse notifyData = ApiResponse(isWorking: true);

  int pageNo = 1;

  bool isSearchStart = false;


  @override
  void initState() {
    scrollController.addListener(() {
      scrollListener();
    });

    if(widget.isBeneficiaryList){
      beneficieryList();
    }else{
      beneficieryReceiveList();
    }
    super.initState();
  }


  void scrollListener() {

    if (scrollController.position.maxScrollExtent == scrollController.position.extentBefore) {
      setState(() {
        pageNo=pageNo+1;
      });
      if(widget.isBeneficiaryList){
        setState(() {
          isLoading = true;
        });
        beneficieryList();
      }else{
        setState(() {
          isLoading = true;
        });
        beneficieryReceiveList();
      }
    }
  }

  void beneficieryReceiveList(){

    ApiController().postRequest(token: GetStorage().read('token'), endPoint: '${ApiEndPoints().beneficiaryReceiveList}?page=$pageNo').then((value){
      print(value.responseCode);
      setState(() {
        if(value.responseCode==200){
          try{

            listOfUser = listOfUserFromJson(value.response.toString());
            dataList.addAll(listOfUser!.data!.data!);
            notifyData = ApiResponse(
              isWorking: false,
              responseError: false,
            );
            setState(() {
              isLoading = false;
            });
          }
          catch(e){
            notifyData = ApiResponse(
              isWorking: false,
              responseError: true,
            );
            setState(() {
              isLoading = false;
            });
          }
        }else{
          notifyData = ApiResponse(
            isWorking: false,
            responseError: true,
          );
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  void beneficieryList(){
    ApiController().postRequest(token: GetStorage().read('token'), endPoint: "${ApiEndPoints().beneficiaryList}?page=$pageNo").then((value){
      setState(() {
        if(value.responseCode==200){
          try{
            listOfUser = listOfUserFromJson(value.response.toString());
            dataList.addAll(listOfUser!.data!.data!);
            notifyData = ApiResponse(
              isWorking: false,
              responseError: false,
            );
            setState(() {
              isLoading = false;
            });
          }
          catch(e){
            notifyData = ApiResponse(
              isWorking: false,
              responseError: true,
            );
            setState(() {
              isLoading = false;
            });
          }
        }else{
          notifyData = ApiResponse(
            isWorking: false,
            responseError: true,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) {
          if(notifyData.isWorking!){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
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
                                setState(() {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserDetailsViewByAdmin(userId: searchController.text,isScan: true,)));
                                });
                                // if(isSearchStart){
                                //   setState(() {
                                //     dataList = filterDataList;
                                //     isSearchStart = false;
                                //     searchController.clear();
                                //   });
                                // }
                              },
                              //icon: isSearchStart?const Icon(Icons.close,color: Colors.grey,):const Icon(Icons.search,color: Colors.grey,),
                              icon: const Icon(Icons.send,color: Colors.grey,),
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
                          // setState(() {
                          //   isSearchStart = true;
                          //   dataList = dataList.where((element) => element.beneficiaryMobile.contains(value.toString())||
                          //       element.nidNumber.contains(value.toString())||
                          //       element.beneficiaryNameBangla.contains(value.toString())||
                          //       element.beneficiaryNameEnglish.contains(value.toString())
                          //   ).toList();
                          // });
                          // print(dataList.length);
                        },
                        onTap: (){
                          // setState(() {
                          //   filterDataList = dataList;
                          // });
                        },
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,position){

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                        child: ListTile(
                          title: Text(dataList[position].beneficiaryNameBangla,),
                          leading: SizedBox(
                            width: 60,
                            height: 80,
                            child: FadeInImage(
                              image: NetworkImage(ApiEndPoints().imageBaseUrl+dataList[position].beneficiaryImageFile,),
                              width: 60,
                              height: 80,
                              placeholder: const AssetImage("asstes/emptyProfile.jpg",),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ফ্যামিলি কার্ডঃ ${dataList[position].familyCardNumber}"),
                              Text("মোবাইল নম্বরঃ ${dataList[position].beneficiaryMobile}"),
                              Text("ঠিকানাঃ ${dataList[position].upazilaNameBangla}, ${dataList[position].unionNameBangla}, ${dataList[position].wordNameBangla}"),
                              !widget.isBeneficiaryList?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("তারিখঃ ${HelperClass.convertAsMonthDayYear(dataList[position].receiveDate)}, ধাপঃ ${dataList[position].stepName}"),
                                  Text("ডিলারঃ ${dataList[position].dealerName}"),
                                ],
                              ):Container(),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserDetailsViewByAdmin(userId: dataList[position].beneficiaryId,isScan: false,)));

                          },
                        ),
                      );
                    },
                  ),
                ],
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
      ),
    );
  }
}
