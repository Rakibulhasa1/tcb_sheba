
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Controller/UserInfoController.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserInfoController,DealerInfoController>(
      builder: (context,profileData,dealerData,child) {
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.bottomCenter,
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(profileData.userInfoModel!.data!.userInfo!.userFullName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(profileData.userInfoModel!.data!.userInfo!.userMobile,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(ApiEndPoints().imageBaseUrl+profileData.userInfoModel!.data!.userInfo!.userImage,),
              ),
            ),
            Positioned(
              top: 300,
              child: Builder(
                builder: (context) {
                  if(dealerData.apiResponse.isWorking!){
                    return Container();
                  }
                  if(dealerData.apiResponse.responseError!){
                    return Container();
                  }
                  return Text('${dealerData.dealerInfoModels!.dealerAddress}');
                }
              ),
            ),
            Positioned(
              top: 350,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 24),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  child: Consumer<DashboardController>(
                      builder: (context,data,child) {
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text("বরাদ্দকৃত এলাকা সমূহ",style: TextStyle(color: Colors.grey[700],fontSize: 20)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Wrap(
                                runSpacing: 4.0,
                                spacing: 4.0,
                                direction: Axis.horizontal,
                                children: [
                                  for(int i=0;i<data.data!.dealerAssignInfo!.length;i++)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: Text("${data.data!.dealerAssignInfo![i].assignUnionName}, ${data.data!.dealerAssignInfo![i].stepName}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      padding: EdgeInsets.all(8),
                                    ),
                                ],
                              ),
                            ),

                          ],
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
