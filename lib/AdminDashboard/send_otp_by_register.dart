import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class SendOtpByRegister extends StatefulWidget {
  const SendOtpByRegister({Key? key}) : super(key: key);

  @override
  _SendOtpByRegisterState createState() => _SendOtpByRegisterState();
}

class _SendOtpByRegisterState extends State<SendOtpByRegister> {

  bool isTimesUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('asstes/mainLogo.png',height: 40,width: 40,),
                    SizedBox(width: 20,),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Text('Please enter the OTP from your registered mobile number +880********98',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.grey[700]),textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isTimesUp ? true:false,
                child: Column(
                  children: [
                    Text('Verification code is expire\nPlease try again',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700]),),
                    SizedBox(height: 10,),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: (){
                      },
                      child: Text('Resend',style: TextStyle(color: Colors.grey[200]),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(fontSize: 24, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            submittedPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(fontSize: 24, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          SizedBox(height: 30,),
          Visibility(
            visible: true,
            replacement: (!isTimesUp)?Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Spacer(),
                  Text('0:0',style: TextStyle(fontSize: 16,color: Colors.grey[600],),),
                  SizedBox(width: 20,),
                  CircularProgressIndicator(strokeWidth: 6,color: Colors.white,value: 60/180,backgroundColor: Colors.grey,),
                  SizedBox(width: 28,),
                ],
              ),
            ):Container(),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width-52,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red.withOpacity(0.1)),
              child: Text('Invalid otp code',style: TextStyle(color: Colors.red),),
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}
