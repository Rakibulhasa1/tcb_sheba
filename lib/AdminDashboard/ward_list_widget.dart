import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Model/district_list_model.dart';
import 'package:tcb/AdminDashboard/Model/division_list_model.dart';
import 'package:tcb/AdminDashboard/Model/union_list_model.dart';
import 'package:tcb/AdminDashboard/Model/upazila_list_model.dart';
import 'package:tcb/AdminDashboard/Model/word_list_model.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/Model/UserInfo.dart';
import 'package:tcb/show_toast.dart';

class WardListWidget extends StatefulWidget {
  const WardListWidget({Key? key}) : super(key: key);

  @override
  _WardListWidgetState createState() => _WardListWidgetState();
}

class _WardListWidgetState extends State<WardListWidget> {


  List<WordModel> wardList = [];
  List<UnionModel> unionList = [];
  List<UpazilaModel> upozilaList = [];
  List<DistrictName> zilaList = [];
  List<DivisionName> divisionList = [];



  WordModel selectedWard= WordModel(wordNameBangla: "Select Road", isRoad: "");
  UnionModel selectedUnion= UnionModel(unionNameBangla: "Select Ward", unionId: "",);
  UpazilaModel selectedUpozila= UpazilaModel(upazilaNameBangla: "", upazilaId: " ");
  DistrictName selectedZila= DistrictName(districtNameBangla: "", districtId: " ");
  DivisionName selectedDivision= DivisionName(divisionName: "", divisionId: " ");


  WordModel selectedRoad = WordModel(wordNameBangla: "", isRoad: "");


  ApiResponse response = ApiResponse(isWorking: false);


  @override
  void initState(){
    super.initState();

    UserAreaInfo useerAreaInfo = Provider.of<UserInfoController>(context,listen: false).userInfoModel!.data!.userAreaInfo!;
    UserInfo userInfo = Provider.of<UserInfoController>(context,listen: false).userInfoModel!.data!.userInfo!;
    setState(() {
      // selectedWard = WordModel(wordNameBangla: useerAreaInfo.wordNameBangla);
      if(userInfo.userAreaType=="R"){
        selectedUnion= UnionModel(unionNameBangla: useerAreaInfo.unionNameBangla);
      }
      selectedUpozila= UpazilaModel(upazilaNameBangla: useerAreaInfo.upazilaNameBangla);
      selectedZila= DistrictName(districtNameBangla: useerAreaInfo.districtNameBangla);
      selectedDivision = DivisionName(divisionName: useerAreaInfo.divisionName);
    });

    printf(userInfo.userAreaType);

    switch (userInfo.userAreaType){
      case "DI":
        getDataList(endPoint: 'district-list',areaType: userInfo.userAreaType,id: useerAreaInfo.divisionId);
        break;
      case "U":
        getDataList(endPoint: 'upazila-list',areaType: userInfo.userAreaType,id: useerAreaInfo.districtId);

        break;
      case "UI":
        getDataList(endPoint: 'union-list',areaType: userInfo.userAreaType,id: useerAreaInfo.upazilaId);

        break;
      case "W":
        getDataList(endPoint: 'word-list',areaType: userInfo.userAreaType,id: useerAreaInfo.unionId);

        break;
      case "A":
        getDataList(endPoint: 'union-list',areaType: userInfo.userAreaType,id: useerAreaInfo.upazilaId);

        break;

      case "R":
        getDataList(endPoint: 'word-list',areaType: userInfo.userAreaType,id: useerAreaInfo.unionId);

        break;
    }
  }


  void getDataList({required String endPoint,required areaType,required id,genderStatus}){
    var body;

    setState(() {
      response = ApiResponse(
        isWorking: true,
      );
    });

    switch (areaType){
      case "DI":
        body = {
          "division_id" : id,
        };
        break;
      case "U":
        body = {
          "district_id" : id,
        };
        break;
      case "UI":
        body = {
          "upazila_id" : id,
        };
        break;
      case "W":
        body = {
          "union_id" : id,
        };
        break;

      case "A":
        body = {
          "upazila_id" : id,
        };
        break;

      case "R":
        body = {
          "union_id" : id,
        };
        break;
    }

    printf(body);

    ApiController().postRequest(endPoint: endPoint,body: body).then((value) {
      switch (areaType){
        case "DI":
          try{
            DistrictListModel districtListModel = districtListModelFromJson(value.response.toString());
            setState((){
              zilaList = districtListModel.districtName!;
              response = ApiResponse(
                isWorking: false,
              );
            });
          }catch (e){
            setState(() {
              response = ApiResponse(
                isWorking: false,
              );
              zilaList.clear();
              upozilaList.clear();
              unionList.clear();
              wardList.clear();
            });
          }
          break;
        case "U":

          try{
            UpazilaListModel upazilaListModel = upazilaListModelFromJson(value.response.toString());
            setState((){
              upozilaList = upazilaListModel.data!;
              response = ApiResponse(
                isWorking: false,
              );
            });
          }catch(e){
            setState(() {
              response = ApiResponse(
                isWorking: false,
              );
              upozilaList.clear();
              unionList.clear();
              wardList.clear();
            });
          }

          break;
        case "UI":
          try{
            UnionListModel unionListModel = unionListModelFromJson(value.response.toString());
            setState((){
              unionList = unionListModel.union!;
              response = ApiResponse(
                isWorking: false,
              );
            });
          }catch(e){
            setState(() {
              response = ApiResponse(
                isWorking: false,
              );
              unionList.clear();
              wardList.clear();
            });
          }
          break;
        case "W":
          try{
            WordListModel wordListModel = wordListModelFromJson(value.response.toString());
            setState((){
              response = ApiResponse(
                isWorking: false,
              );
              wardList = wordListModel.data!;
            });
          }catch(e){
            response = ApiResponse(
              isWorking: false,
            );
            wardList.clear();
          }
          break;

        case "A":
          try{
            UnionListModel unionListModel = unionListModelFromJson(value.response.toString());
            setState((){
              response = ApiResponse(
                isWorking: false,
              );
              unionList = unionListModel.union!;
            });
          }catch(e){
            setState(() {
              response = ApiResponse(
                isWorking: false,
              );
              unionList.clear();
              wardList.clear();
            });
          }
          break;
        case "R":
          try{
            WordListModel wordListModel = wordListModelFromJson(value.response.toString());
            setState((){
              response = ApiResponse(
                isWorking: false,
              );
              wardList = wordListModel.data!;
            });
          }catch(e){
            response = ApiResponse(
              isWorking: false,
            );
            wardList.clear();
          }
          break;

      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("প্রয়োজনীয় ফিল্ড পূরণ করুন")),
      body: Consumer<UserInfoController>(
        builder: (context,data,child) {
          switch (data.userInfoModel!.data!.userAreaInfo!.isCitycorporation){
            case "0":
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedDivision.divisionName),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: divisionList.map((DivisionName items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.divisionName),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDivision = newValue as DivisionName;
                                  getDataList(endPoint: 'district-list',areaType: data.userInfoModel!.data!.userInfo!.userAreaType,id: data.userInfoModel!.data!.userAreaInfo!.districtId);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedZila.districtNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: zilaList.map((DistrictName items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.districtNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedZila = newValue as DistrictName;
                                  getDataList(endPoint: 'district_id',areaType: data.userInfoModel!.data!.userInfo!.userAreaType,id: data.userInfoModel!.data!.userAreaInfo!.districtId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  উপজেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedUpozila.upazilaNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: upozilaList.map((UpazilaModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.upazilaNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedUpozila = newValue as UpazilaModel;
                                  getDataList(endPoint: 'upazila_id',areaType: data.userInfoModel!.data!.userInfo!.userAreaType,id: data.userInfoModel!.data!.userAreaInfo!.districtId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  data.userInfoModel!.data!.userAreaInfo!.isMunicipality=="0"?Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  ইউনিয়ন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedUnion.unionNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: unionList.map((UnionModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.unionNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedUnion = newValue as UnionModel;
                                  getDataList(endPoint: 'union_id',areaType: data.userInfoModel!.data!.userInfo!.userAreaType,id: data.userInfoModel!.data!.userAreaInfo!.districtId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ):Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  পৌরসভা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                        width: MediaQuery.of(context).size.width,
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text(selectedUnion.unionNameBangla),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            items: unionList.map((UnionModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items.unionNameBangla),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedUnion = newValue as UnionModel;
                                getDataList(endPoint: 'union_id',areaType: data.userInfoModel!.data!.userInfo!.userAreaType,id: data.userInfoModel!.data!.userAreaInfo!.districtId);

                              });
                            },
                          ),
                        ),
                      ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedWard.wordNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: wardList.map((WordModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.wordNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedWard = newValue as WordModel;
                                  GetStorage().write("regV", "আপনি বর্র্তমানে ${selectedUpozila.upazilaNameBangla}, ${selectedUnion.unionNameBangla}, ${selectedWard.wordNameBangla} এলাকার রেজিস্ট্রেশন করছেন");
                                  GetStorage().write("regR", "আপনি বর্তমানে ${selectedUpozila.upazilaNameBangla}, ${selectedUnion.unionNameBangla}, ${selectedWard.wordNameBangla} এলাকার রেজিস্ট্রেশন ইউজার তৈরী করছেন");
                                  GetStorage().write("regF", selectedWard.wordId);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),

                ],
              );
            case "1":
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green.withOpacity(0.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedDivision.divisionName),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: divisionList.map((DivisionName items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.divisionName),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDivision = newValue as DivisionName;
                                  getDataList(endPoint: 'district-list',areaType: "D",id: data.userInfoModel!.data!.userAreaInfo!.divisionId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green.withOpacity(0.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedZila.districtNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: zilaList.map((DistrictName items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.districtNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedZila = newValue as DistrictName;
                                  getDataList(endPoint: 'upazila-list',areaType: "DI",id: data.userInfoModel!.data!.userAreaInfo!.districtId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  সিটি কর্পোরেশন নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green.withOpacity(0.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedUpozila.upazilaNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: upozilaList.map((UpazilaModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.upazilaNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedUpozila = newValue as UpazilaModel;
                                  //getDataList(endPoint: 'union-list',areaType: "UI",id: data.userInfoModel!.data!.userAreaInfo!.upazilaId);
                                  getDataList(endPoint: 'union-list',areaType: "UI",id: selectedUpozila.upazilaId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedUnion.unionNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: unionList.map((UnionModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.unionNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {

                                  selectedUnion = newValue as UnionModel;
                                  print(selectedUnion.unionId);
                                  GetStorage().write("refU", selectedUnion.unionId);
                                  getDataList(endPoint: 'word-list',areaType: "W",id: selectedUnion.unionId);

                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  রাস্তা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(selectedWard.wordNameBangla),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: wardList.map((WordModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.wordNameBangla),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedWard = newValue as WordModel;
                                  GetStorage().write("regF", selectedWard.wordId);
                                  print(selectedWard.wordId);
                                  GetStorage().write("regV", "আপনি বর্তমানে ${selectedUpozila.upazilaNameBangla}, ${selectedUnion.unionNameBangla}, ${selectedWard.wordNameBangla} এলাকা নির্বাচন করা অবস্থায় আছেন");
                                  GetStorage().write("regR", "আপনি বর্তমানে ${selectedUpozila.upazilaNameBangla}, ${selectedUnion.unionNameBangla}, ${selectedWard.wordNameBangla} এলাকার রেজিস্ট্রেশন ইউজার তৈরী করছেন");
                                  ShowToast.myToast("নির্বাচন করা সম্পূর্ণ হয়েছে", Colors.black, 2);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  SizedBox(height: 36),
                  AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height : 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(width: 12),
                          Text("লোডিং হচ্ছে...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    crossFadeState: response.isWorking==true?CrossFadeState.showSecond:CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 250),
                  ),
                ],
              );
            default :
              return Container();
          }
        }
      ),
    );
  }
}
