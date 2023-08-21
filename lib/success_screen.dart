import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:tcb/Authrization/View/login_page.dart';

class SuccessScreen extends StatelessWidget {
  final String? orderNumber;
  const SuccessScreen({
    Key? key,
    this.orderNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
              child: Container(
                height: 120.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/logo.png",
                        ))),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Lottie.network(
            //       "https://assets8.lottiefiles.com/packages/lf20_jz2wa00k.json",
            //       height: 300, //SizeConfig.screenHeight!/2.28,    /// 300
            //       width: 300, //SizeConfig.screenWidth!/1.37,      /// 300
            //       repeat: true),
            // ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //  Icon (
                        //      Icons.call,
                        //      size: 35,
                        //      color: Colors.redAccent
                        //  ),
                        Text(
                          'Password changed successfully',
                          // 'shipper_SucessSuport'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ), //"Thank you for your cooperation \n our support team will be contact  \n you shortly within 24 hrs.")
                      ],
                    )),
              ],
            ),
            const Spacer(
              flex: 8,
            ),
            const Spacer(
              flex: 2,
            ),
            SizedBox(height: 20 * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                ModalRoute.withName("/mainlogin"));
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
