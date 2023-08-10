import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/AdminDashboard/ward_list_widget.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/show_toast.dart';

class RegistrationForBenefRegister extends StatefulWidget {
  const RegistrationForBenefRegister({Key? key}) : super(key: key);

  @override
  State<RegistrationForBenefRegister> createState() => _RegistrationForBenefRegisterState();
}

class _RegistrationForBenefRegisterState extends State<RegistrationForBenefRegister> {

  TextEditingController fullName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController confirmMobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController limit = TextEditingController();
  TextEditingController ward = TextEditingController();


  String? phoneNumber="";
  bool isCurrentPhone = false;
  bool isCurrentPassword = false;

  bool isWorking = false;
  String  myPass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("রেজিস্ট্রেশন"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 24,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  এলাকা নির্বাচন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                InkWell(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>WardListWidget()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.3)
                    ),
                    child: Column(
                      children: [
                        GetStorage().read("regF")!=null?Text(GetStorage().read("regR")??""):Text("এলাকা নির্বাচন করুন"),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          alignment : Alignment.centerLeft,
                          child: Text('নতুন এলাকা নির্বাচন করতে এখানে ক্লিক করুন',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black,decoration: TextDecoration.underline)),
                        ),
                      ],
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
                Text('  রেজিস্ট্রেশন ইউজারের পুরো নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3)
                  ),
                  child: TextFormField(
                    enabled: true,
                    keyboardType: TextInputType.name,
                    controller: fullName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4)
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
                Text('  মোবাইলে নম্বর *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: phoneNumber!.length==11?Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    enabled: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: '01X XXXXXXXX',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                    ),
                    controller: mobile,
                    onChanged: (value){
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'মোবাইল নম্বর লিখুন';
                      }
                    },
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isCurrentPhone?Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    enabled: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'মোবাইল নম্বর পুনরায় লিখুন *',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                    ),
                    controller: confirmMobile,
                    onChanged: (value){
                      setState(() {
                        if(mobile.text==value){
                          isCurrentPhone = true;
                        }else{
                          isCurrentPhone = false;
                        }
                        phoneNumber = value;
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'মোবাইল নম্বর লিখুন';
                      }
                    },
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "Note: ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                  TextSpan(text: "রেজিস্ট্রেশন কারীর এই মোবাইল নম্বরটি লগইন করার সময় ইউসার নাম হিসেবে গণ্য হবে ।",style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  পাসওয়ার্ড সেট করুন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: myPass.length<6?Colors.red.withOpacity(0.3):Colors.green.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    enabled: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                    ),
                    controller: password,
                    onChanged: (value){
                      setState(() {
                        myPass = value;
                      });
                    },
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
                Text('  পুনরায় পাসওয়ার্ড সেট করুন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    enabled: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Enter your confirm password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                    ),
                    controller: confirmPassword,
                    onChanged: (value){
                      setState(() {
                        if(password.text==value){
                          isCurrentPassword = true;
                        }else{
                          isCurrentPassword = false;
                        }
                      });
                    },
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
                Text('  উপকারভোগী রেজিস্ট্রেশন করার সীমা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3)
                  ),
                  child: TextFormField(
                    enabled: true,
                    keyboardType: TextInputType.number,
                    controller: limit,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  firstChild: InkWell(
                    onTap: (){
                      setState(() {
                        isWorking = true;
                      });

                      var body = {
                        "user_full_name" : fullName.text,
                        "user_mobile" : mobile.text,
                        "password" : password.text,
                        "limit_qty" : limit.text,
                        "word_id" : GetStorage().read("regF"),
                        "union_id" : GetStorage().read("refU"),
                      };

                      print(body);

                      if(mobile.text==confirmMobile.text&&password.text==confirmPassword.text&&GetStorage().read("regF")!=null){
                        ApiController().postRequest(endPoint: "user-registration",body: body).then((value){

                          if(value.responseCode==200){
                            showDialog(context: context, builder: (context){
                              return Dialog(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 24,top: 24,bottom: 12,right: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Success",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 12),
                                          Text("Register user successfully created",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                          Text("Your user name : ${mobile.text}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                          Text("Your password : ${password.text}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                          SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Spacer(),
                                              MaterialButton(onPressed: (){Navigator.pop(context);},child: Text("OK")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });

                          }else{
                            try{
                              var response = json.decode(value.response.toString());
                              ShowToast.myToast("${response['data']}", Colors.black, 2);
                            }catch(e){
                              ShowToast.myToast("Something went wrong", Colors.black, 2);
                            }
                          }
                          setState(() {
                            isWorking = false;
                          });
                        });
                      }else{
                        ShowToast.myToast("Something went wrong", Colors.black, 2);
                      }

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green.withOpacity(0.7)
                      ),
                      child: Text('রেজিস্ট্রেশন করুন',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    ),
                  ),
                  secondChild: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  crossFadeState: isWorking?CrossFadeState.showSecond:CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 500),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
