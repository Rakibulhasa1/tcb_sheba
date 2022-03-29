import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/admin_dashboard.dart';
import 'package:tcb/AdminDashboard/admin_user_navigation.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/Authrization/Controller/LoginDataController.dart';
import 'package:tcb/Authrization/Model/UserProfileModel.dart';
import 'package:tcb/GeneralDashboard/general_user_navigation.dart';
import 'package:tcb/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool seePassword = false;
  bool isWorking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text('Login',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 3.0,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 0),
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.6),
                                spreadRadius: 0,
                                blurRadius: 7,
                                offset: const Offset(2, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.person,size: 20,color: Colors.grey[600],),
                              ),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.name,
                                  autofocus: true,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(
                                      height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                                      hintText: 'User Name',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12)
                                  ),
                                  controller: userNameController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 3.0,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 0),
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.6),
                                spreadRadius: 0,
                                blurRadius: 7,
                                offset: const Offset(2, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.lock,size: 20,color: Colors.grey[600],),
                              ),
                              Expanded(
                                child: TextField(
                                  obscureText: (seePassword)?false:true,
                                  textAlign: TextAlign.start,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.name,
                                  autofocus: true,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(
                                      height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                                  decoration: InputDecoration(
                                      suffixIcon: (seePassword)?IconButton(
                                        onPressed: (){
                                          setState(() {
                                            seePassword = false;
                                          });
                                        },
                                        icon: const Icon(Icons.remove_red_eye),
                                      ):IconButton(
                                        onPressed: (){
                                          setState(() {
                                            seePassword = true;
                                          });
                                        },
                                        icon: const Icon(Icons.visibility_off_sharp),
                                      ),
                                      hintStyle: const TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                                      hintText: 'Password',
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12)
                                  ),
                                  controller: passwordController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isWorking?const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ):Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: (){

                        setState(() {
                          isWorking = true;
                        });

                        var body = {
                          'email' : userNameController.text,
                          'password' : passwordController.text,
                        };

                        ApiController().loginResponse(endPoint: ApiEndPoints().login,body: body).then((value){
                          print(value.responseCode);
                          if(value.responseCode==200){

                            try{
                              UserProfileModel userData = userProfileModelFromJson(value.response.toString());
                              Provider.of<LoginDataController>(context,listen: false).getUserData(userData);
                              GetStorage().write('token', 'Bearer ${userData.token}');
                              GetStorage().write('email', userNameController.text);
                              GetStorage().write('password', passwordController.text);
                              GetStorage().write('userType', userData.data!.userAreaType);

                              if(userData.token!=null){
                                if(userData.data!.userAreaType=='DD'||userData.data!.userAreaType=='DE'){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GeneralUserNavigation()), (Route<dynamic> route) => false);
                                }else{
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AdminUserNavigation()), (Route<dynamic> route) => false);
                                }

                              }else{
                                ShowToast.myToast('Something is wrong', Colors.black, 2);
                              }
                              setState(() {
                                isWorking = false;
                              });
                            }
                            catch(e){
                              ShowToast.myToast('Something is wrong', Colors.black, 2);
                              setState(() {
                                isWorking = false;
                              });
                            }

                          }else{
                            ShowToast.myToast('Something is wrong', Colors.black, 2);
                            setState(() {
                              isWorking = false;
                            });
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                        width: MediaQuery.of(context).size.width,
                        child: const Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32.0,
            left: 0.0,
            child: Image.asset('asstes/freedom50.png',height: 40,width: 70,),
          ),
          Positioned(
            top: 32.0,
            right: 0.0,
            child: Image.asset('asstes/mujib100.png',height: 40,width: 70,),
          ),
          Positioned(
            top: 65.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              children: [
                Image.asset('asstes/mainLogo.png',height: 70,width: 70,),
                SizedBox(height: 12,),
                Text('হাতের মুঠোয় টিসিবি পণ্য',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: ()async{
                const url = "http://spectrum.com.bd/";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw "Could not launch $url";
                }
              },
              child: Text('কারিগরি সহায়তাঃ স্পেকট্রাম আইটি সলিউশনস লিঃ',style: TextStyle(fontSize: 12,color: Colors.grey[700]),textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    );
  }
}
