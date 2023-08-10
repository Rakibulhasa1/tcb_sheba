import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DialogDataController.dart';
import 'package:tcb/AdminDashboard/bar_code_scan_registration.dart';
import 'package:tcb/AdminDashboard/ward_list_widget.dart';
import 'package:tcb/show_toast.dart';

class CustomDialogs{

  void showRegDialog(BuildContext context){
    showDialog(context: context, builder: (context){

      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        insetPadding: const EdgeInsets.all(48),
        child: StatefulBuilder(
            builder: (context,setState) {

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Consumer<DialogDataController>(
                    builder: (context,data,child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('নোটিশ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                          SizedBox(height: 24),
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                            child: InkWell(
                              onTap: (){
                                if(GetStorage().read("regF")!=null){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>BarCodeScanWithRegister()));
                                }else{
                                  ShowToast.myToast("রাস্তা নির্বাচন করুন।", Colors.black, 2);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                                child: Row(
                                  children: const [
                                    Icon(FontAwesomeIcons.barcode,color: Colors.white),
                                    SizedBox(width: 10),
                                    Expanded(child: Text('NID কার্ডের পিছনের পৃষ্ঠার বারকোড স্ক্যান করুন',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14))),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 54),
                          GetStorage().read("regF")==null?const Text("কোন এলাকা নির্বাচন করা হয়নি । রেজিস্ট্রেশন করার পুর্বে অবশ্যই একটি নির্দিষ্ট এলাকা নির্বাচন করতে হবে",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,fontSize: 12)):Text(GetStorage().read("regV"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.left),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>WardListWidget()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              alignment : Alignment.centerLeft,
                              child: GetStorage().read("regF")==null?Text('এলাকা নির্বাচন করতে এখানে ক্লিক করুন',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black,decoration: TextDecoration.underline)):Text('রেজিস্ট্রেশনের এলাকা পরিবর্তন করতে এখানে ক্লিক করুন',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black,decoration: TextDecoration.underline)),
                            ),
                          ),
                        ],
                      );
                    }
                ),
              );
            }
        ),
      );
    });
  }
}