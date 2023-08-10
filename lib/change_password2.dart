
import 'package:flutter/material.dart';

class ChangePassword2 extends StatefulWidget {
  const ChangePassword2({Key? key, }) : super(key: key);

  @override
  State<ChangePassword2> createState() => _ChangePassword2State();
}

class _ChangePassword2State extends State<ChangePassword2> {
  int selectableUser = 0;
  bool isWorking = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool seeConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('asstes/mainLogo.png',height: 100,width: 100,),
            ),
            SizedBox(height: 40,),
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


                            hintStyle:TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                            hintText: 'New Password',
                            border:OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding:EdgeInsets.symmetric(horizontal: 12)
                        ),
                        controller: userNameController,
                      ),

                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
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
                        obscureText: (seeConfirmPassword)?false:true,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                        decoration: const InputDecoration(


                            hintStyle:TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                            hintText: 'Confirm Password',
                            border:OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding:EdgeInsets.symmetric(horizontal: 12)
                        ),
                        controller: passwordController,
                      ),

                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  // var body = {
                  //   'new_password' : passwordController.text,
                  //   'verify_password' : confirmPasswordController.text,
                  // };
                  //
                  // if(confirmPasswordController.text==passwordController.text){
                  //   setState(() {
                  //     isWorking = true;
                  //   });
                  //
                  //   ApiController().postRequest(endPoint: ApiEndPoints().changePassword,body: body).then((value){
                  //
                  //     if(value.responseCode==199){
                  //       setState(() {
                  //         isWorking = false;
                  //       });
                  //       ShowToast.myToast("Password Changes", Colors.black, 1);
                  //       Navigator.pop(context);
                  //     }
                  //     else{
                  //       setState(() {
                  //         isWorking = false;
                  //       });
                  //       ShowToast.myToast("Something is wrong", Colors.black, 1);
                  //
                  //     }
                  //   });
                  //
                  // }else{
                  //   setState(() {
                  //     isWorking = false;
                  //   });
                  //   ShowToast.myToast("Password don't match", Colors.black, 1);
                  // }

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(userAreaType: '',)));
                },
                child: const Text('Verify',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}
