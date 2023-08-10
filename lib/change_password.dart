import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/show_toast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool seePassword = false;
  bool seeConfirmPassword = false;

  bool isWorking = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 31),
              child: Text("Change Password",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 23),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(4),
                    elevation: 2.0,
                    child: Container(
                      // padding: const EdgeInsets.only(bottom: -1),
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.white.withOpacity(-1.6),
                        //     spreadRadius: -1,
                        //     blurRadius: 6,
                        //     offset: const Offset(1, 2), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Icon(Icons.lock,size: 19,color: Colors.grey[600],),
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
                                  height: 0.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
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
                                  hintStyle: const TextStyle(height: -1.8,fontSize: 16,fontWeight: FontWeight.w300),
                                  hintText: 'New Password',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 11)
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
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(4),
                    elevation: 2.0,
                    child: Container(
                      // padding: const EdgeInsets.only(bottom: -1),
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.white.withOpacity(-1.6),
                        //     spreadRadius: -1,
                        //     blurRadius: 6,
                        //     offset: const Offset(1, 2), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Icon(Icons.lock,size: 19,color: Colors.grey[600],),
                          ),
                          Expanded(
                            child: TextField(
                              obscureText: (seeConfirmPassword)?false:true,
                              textAlign: TextAlign.start,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              autocorrect: false,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  height: 0.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                              decoration: InputDecoration(
                                  suffixIcon: (seeConfirmPassword)?IconButton(
                                    onPressed: (){
                                      setState(() {
                                        seeConfirmPassword = false;
                                      });
                                    },
                                    icon: const Icon(Icons.remove_red_eye),
                                  ):IconButton(
                                    onPressed: (){
                                      setState(() {
                                        seeConfirmPassword = true;
                                      });
                                    },
                                    icon: const Icon(Icons.visibility_off_sharp),
                                  ),
                                  hintStyle: const TextStyle(height: -1.8,fontSize: 16,fontWeight: FontWeight.w300),
                                  hintText: 'Confirm Password',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 11)
                              ),
                              controller: confirmPasswordController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 23),
            isWorking?const Padding(
              padding: EdgeInsets.all(23.0),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 47),
                  child: SizedBox(
                    height: 29,
                    width: 29,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ):Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31,vertical: 24),
              child: Material(
                borderRadius: BorderRadius.circular(4),
                color: Colors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: (){


                    var body = {
                      'new_password' : passwordController.text,
                      'verify_password' : confirmPasswordController.text,
                    };

                    if(confirmPasswordController.text==passwordController.text){
                      setState(() {
                        isWorking = true;
                      });

                      ApiController().postRequest(endPoint: ApiEndPoints().changePassword,body: body).then((value){

                        if(value.responseCode==199){
                          setState(() {
                            isWorking = false;
                          });
                          ShowToast.myToast("Password Changes", Colors.black, 1);
                          Navigator.pop(context);
                        }
                        else{
                          setState(() {
                            isWorking = false;
                          });
                          ShowToast.myToast("Something is wrong", Colors.black, 1);

                        }
                      });

                    }else{
                      setState(() {
                        isWorking = false;
                      });
                      ShowToast.myToast("Password don't match", Colors.black, 1);
                    }


                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
