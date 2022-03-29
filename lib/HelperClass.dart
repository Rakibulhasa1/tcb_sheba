// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HelperClass{

  static String convertAsMonthDayYear(String dateTime){

    String myDateTime;

    try{
      DateTime dateTimes =  DateTime.parse(dateTime);
      myDateTime = DateFormat('dd-MMM-yyyy').format(dateTimes);
    }catch(e){
      myDateTime = 'কোন তারিখ খুঁজে পাওয়া যায়নি';
    }
    return myDateTime;
  }


  List<Color> randomColor = [
    Colors.blueAccent,
    Colors.brown,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.green,
    Colors.deepPurpleAccent,
  ];
}