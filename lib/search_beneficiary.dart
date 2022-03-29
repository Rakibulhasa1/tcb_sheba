import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/QrScan/UserInformationModel.dart';
import 'package:tcb/custom_loader.dart';
import 'package:tcb/show_error_message.dart';

class SearchBeneficiary extends StatefulWidget {
  final String nid;
  const SearchBeneficiary({Key? key,required this.nid}) : super(key: key);

  @override
  _SearchBeneficiaryState createState() => _SearchBeneficiaryState();
}

class _SearchBeneficiaryState extends State<SearchBeneficiary> {

  ApiResponse myApiResponse = ApiResponse(isWorking: false);

  ApiResponse getDataResponse = ApiResponse(isWorking: true);
  UserInformationModel? userInformationModel;

  String totalCurrentAddress = '';
  String sebarQuantity = '';
  int qntIndex = 0;

  @override
  void initState() {
    var body = {'nid_number' : widget.nid};
    ApiController().postRequest(endPoint: ApiEndPoints().qrCodeSearch,body: body,token: GetStorage().read('token')).then((value){
      print(value.response);
      if(value.responseCode==200){
        setState(() {
          getDataResponse = ApiResponse(
            isWorking: false,
            responseCode: value.responseCode,
            responseError: false,
          );
          userInformationModel = userInformationModelFromJson(value.response.toString());
        });
      }else{
        setState(() {
          getDataResponse = ApiResponse(
            isWorking: false,
            responseCode: value.responseCode,
            responseError: true,
          );
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Builder(
          builder: (context) {
            if(getDataResponse.isWorking!){
              return const CustomLoader();
            }
            if(getDataResponse.responseError!){
              return const ErrorMessage();
            }
            if(!getDataResponse.responseError!){
              if(userInformationModel!.member!.benificiaryInfo!.addressType=='U'){
                totalCurrentAddress = userInformationModel!.member!.benificiaryInfo!.upazilaNameBangla! + ',  ' + userInformationModel!.member!.benificiaryInfo!.unionNameBangla! + ', ' + userInformationModel!.member!.benificiaryInfo!.wordNameBangla! ;
              }

              if(userInformationModel!.member!.benificiaryInfo!.addressType=='P'){
                totalCurrentAddress = userInformationModel!.member!.benificiaryInfo!.upazilaNameBangla! + ',  ' + userInformationModel!.member!.benificiaryInfo!.unionNameBangla! + ', ' + userInformationModel!.member!.benificiaryInfo!.wordNameBangla! ;
              }

              if(userInformationModel!.member!.benificiaryInfo!.addressType=='C'){
                totalCurrentAddress = userInformationModel!.member!.benificiaryInfo!.upazilaNameBangla! + ',  ' + userInformationModel!.member!.benificiaryInfo!.unionNameBangla! + ', ' + userInformationModel!.member!.benificiaryInfo!.wordNameBangla! ;
              }

            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.4),
                          ),
                          child: const Text('উপকারভোগীর তথ্য',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: FadeInImage(
                                      image: NetworkImage(ApiEndPoints().imageBaseUrl+userInformationModel!.member!.benificiaryInfo!.beneficiaryImageFile!,),
                                      height: 120,
                                      width: 100,
                                      placeholder: const AssetImage("asstes/emptyProfile.jpg"),
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12,),
                                  Expanded(
                                    flex: 70,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text('নাম             :  ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.beneficiaryNameBangla!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        const SizedBox(height: 7,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text('মোবাইল      :  ',style: TextStyle(fontSize: 16),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.beneficiaryMobile!,style: const TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                        const SizedBox(height: 7,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text('পরিচয়পত্র   :  ',style: TextStyle(fontSize: 16),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.nidNumber.toString(),style: const TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                        const SizedBox(height: 7,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text('কার্ড নম্বর     :  ',style: TextStyle(fontSize: 16),),
                                            Text(userInformationModel!.member!.benificiaryInfo!.familyCardNumber.toString(),style: const TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16,),
                              Text(totalCurrentAddress,style: const TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
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
