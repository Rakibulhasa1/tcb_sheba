import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/BeneficeryDashboard/Controller/GetBeneficeryController.dart';
import 'package:tcb/BeneficeryDashboard/View/view_full_card_and_deliver_list.dart';
import 'package:tcb/BeneficeryDashboard/Widget/google_map_view.dart';
import 'package:tcb/BeneficeryDashboard/Widget/view_map_in_full_screen.dart';
import 'package:tcb/QrScan/UserInformationModel.dart';
import 'package:tcb/show_error.dart';

class TCBCardWithGoogleMap extends StatefulWidget {
  const TCBCardWithGoogleMap({Key? key}) : super(key: key);

  @override
  _TCBCardWithGoogleMapState createState() => _TCBCardWithGoogleMapState();
}

class _TCBCardWithGoogleMapState extends State<TCBCardWithGoogleMap> {




  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetBeneficeryController>(
      builder: (context,userData,child) {
        if(userData.getUserDataResponse.isWorking!){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(userData.getUserDataResponse.responseError!){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                Text('Something is wrong',style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold)),
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: (){
                    GetStorage().remove('b_token');
                    GetStorage().remove('userType');
                    GetStorage().remove('user_id');
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                  },
                  child: Text('Go Back'),
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                elevation: 5.0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewFullCardAndDeliverList()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,)
                    ),
                    width: MediaQuery.of(context).size.width-32,
                    height: 190,
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Image.asset('asstes/freedom50.png',height: 20,),
                            ),
                            Column(
                              children: [
                                Image.asset('asstes/govLogo.png',height: 12,),
                                Text('পরিবার পরিচিতি কার্ড',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 10),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset('asstes/mujib100.png',height: 20,),
                            ),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 65,
                                        width: 65,
                                        child: FadeInImage(
                                          image: NetworkImage('${ApiEndPoints().imageBaseUrl}${userData.myUserInfo!.beneficiaryImageFile}'),
                                          height: 65,
                                          width: 65,
                                          placeholder: const AssetImage("asstes/emptyProfile.jpg"),
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 24,),
                                      SizedBox(width: 80,child: Text(userData.myUserInfo!.upazilaNameBangla,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,)),
                                      SizedBox(width: 80,child: Text(userData.myUserInfo!.unionNameBangla,style:  TextStyle(fontSize: 8,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                                    ],
                                  ),
                                  SizedBox(width: 12,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('নাম',style: TextStyle(fontSize: 8),),
                                      Text(userData.myUserInfo!.beneficiaryNameBangla,style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 8,),
                                      Text('পরিচয় পত্র নম্বর ',style: TextStyle(fontSize: 8,),),
                                      Text(userData.myUserInfo!.nidNumber,style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 8,),
                                      Text('পরিবার কার্ড ',style: TextStyle(fontSize: 8),),
                                      Text(userData.myUserInfo!.familyCardNumber,style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 8,),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width-175,
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('মোবাইল',style: TextStyle(fontSize: 8),),
                                                Text(userData.myUserInfo!.beneficiaryMobile,style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 25),
                                              child: Column(
                                                children: [
                                                  Text("পেশা",style: TextStyle(fontSize: 8),textAlign: TextAlign.center,),
                                                  Text(userData.myUserInfo!.beneficiaryOccupationName,style: TextStyle(fontSize: 8),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 10,
                                right: 0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    QrImage(
                                      data: "Mobile : ${userData.myUserInfo!.beneficiaryMobile},NID :-${userData.myUserInfo!.nidNumber}",
                                      version: QrVersions.auto,
                                      size: 80.0,
                                    ),
                                    SizedBox(height: 8,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Builder(
                            builder: (context) {
                              switch(userData.myUserInfo!.addressType){
                                case 'U' :
                                  return Text('জেলা প্রশাসন, ${userData.myUserInfo!.districtNameBangla}',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.green),);
                                case 'C' :
                                  return Text('${userData.myUserInfo!.upazilaNameBangla}',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.green),);
                                case 'P' :
                                  return Text('${userData.myUserInfo!.unionNameBangla}',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.green),);
                              }
                              return Text('',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.green),);
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Center(child: Text('ডাউনলোড বা শেয়ার করতে কার্ডের উপর ক্লিক করুন',style:  TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.red),)),

            SizedBox(height: 24,),
            Stack(

              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMapView(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),borderRadius: BorderRadius.circular(20)),
                    child: Text('ট্রাকসেল লোকেশন',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewMapInFullScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                        child: Icon(Icons.launch),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}
