
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DialogDataController.dart';
import 'package:tcb/AdminDashboard/Model/union_list_model.dart';
import 'package:tcb/AdminDashboard/Model/word_list_model.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_registration.dart';
import 'package:tcb/AdminDashboard/ward_list_widget.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/CustomDialogs.dart';
import 'package:tcb/show_toast.dart';


class RegistureUserDashboard extends StatefulWidget {
  const RegistureUserDashboard({Key? key}) : super(key: key);

  @override
  _RegistureUserDashboardState createState() => _RegistureUserDashboardState();
}

class _RegistureUserDashboardState extends State<RegistureUserDashboard> {


  @override
  void initState() {
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{

        await Future.delayed(Duration(seconds: 2));
      },
      child: ListView(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 24,left: 18,bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('স্বাগতম!',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  Consumer<UserInfoController>(
                      builder: (context,data,child) {
                        return Text(data.userInfoModel!.data!.userInfo!.userFullName,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),);
                      }
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap : (){
                      //Navigator.push(context, CupertinoPageRoute(builder: (context)=>BeneficaryListView(isBeneficiaryList: true,title: 'উপকারভোগীর সংখ্যা',stepId: "1",)));
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child : Text('রেজিস্ট্রেশনকৃত\nউপকারভোগীর সংখ্যা',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Consumer<DashboardController>(
                                builder: (context,notifyData,child) {
                                  if(notifyData.notifyDashboardData.isWorking!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  if(notifyData.notifyDashboardData.responseError!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  return Text("-",style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap : (){
                      //Navigator.push(context, CupertinoPageRoute(builder: (context)=>BeneficaryListView(isBeneficiaryList: true,title: 'সুবিধাপ্রাপ্ত উপকারভোগী',stepId: ,)));
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child: Text('অনুমোদিত উপকারভোগীর\nসংখ্যা',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Consumer<DashboardController>(
                                builder: (context,notifyData,child) {
                                  if(notifyData.notifyDashboardData.isWorking!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  if(notifyData.notifyDashboardData.responseError!){
                                    return Text('-',style: TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                  }
                                  //return Text(notifyData.data!.totalReceiver,style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),);
                                  return Text("-",style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),);
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            child: InkWell(
              onTap: (){
                CustomDialogs().showRegDialog(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.barcode,color: Colors.white,size: 38,),
                    SizedBox(width: 24,),
                    Text('আবেদনকারীর NID স্ক্যান করুন',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
