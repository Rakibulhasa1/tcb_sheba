
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast{
  static void myToast(String message,Color colorCode,int length){
    Fluttertoast.showToast(
        msg: message,
        textColor: Color(0xFFFFFFFF),
        backgroundColor: colorCode,
        fontSize: 12,
        toastLength: (length>0)?Toast.LENGTH_LONG:Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
    );
  }
  static void toastDialog(BuildContext context,String title){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('$title'),
        actions: [
          MaterialButton(onPressed: (){Navigator.pop(context);},child: Text('Ok'),),
        ],
      );
    },);
  }
}
