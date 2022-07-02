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
              padding: const EdgeInsets.only(left: 32),
              child: Text("Change Password",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 24),
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
                                  hintText: 'New Password',
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
            SizedBox(height: 24),
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
                              obscureText: (seeConfirmPassword)?false:true,
                              textAlign: TextAlign.start,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              autocorrect: false,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
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
                                  hintStyle: const TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                                  hintText: 'Confirm Password',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12)
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
            SizedBox(height: 24),
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
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: (){


                    var body = {
                      'new_password' : passwordController.text,
                      'verify_password' : confirmPasswordController.text,
                    };

                    if(confirmPasswordController.text==passwordController.text){
                      setState(() {
                        isWorking = true;
                      });

                      ApiController().postRequest(endPoint: ApiEndPoints().changePassword,body: body,token: GetStorage().read('token')).then((value){

                        if(value.responseCode==200){
                          setState(() {
                            isWorking = false;
                          });
                          ShowToast.myToast("Password Changes", Colors.black, 2);
                          Navigator.pop(context);
                        }
                        else{
                          setState(() {
                            isWorking = false;
                          });
                          ShowToast.myToast("Something is wrong", Colors.black, 2);

                        }
                      });

                    }else{
                      setState(() {
                        isWorking = false;
                      });
                      ShowToast.myToast("Password don't match", Colors.black, 2);
                    }


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
    );
  }
}
