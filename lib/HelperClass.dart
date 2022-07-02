// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:new_version/new_version.dart';


class HelperClass{

  final ImagePicker image = ImagePicker();

  static String convertAsMonthDayYearAndTime(String dateTime){

    String myDateTime;

    try{
      DateTime dateTimes =  DateTime.parse(dateTime);
      myDateTime = DateFormat('dd-MMM-yyyy h:mm a').format(dateTimes);
    }catch(e){
      myDateTime = 'কোন তারিখ খুঁজে পাওয়া যায়নি';
    }
    return myDateTime;
  }



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


  static String convertAsMonthYear(String dateTime){

    String myDateTime;

    try{
      DateTime dateTimes =  DateTime.parse(dateTime);
      myDateTime = DateFormat('MMM-yyyy').format(dateTimes);
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

  void checkVersion(BuildContext context)async{
    final newVersion = NewVersion(
      androidId: "com.spectrum.officers_club_dhaka",
      iOSId: "",
    );

    final status = await newVersion.getVersionStatus();

    if(status!.localVersion!=status.storeVersion){
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: true,
        dialogText: "Please update the app from ${status.storeVersion} to ${status.localVersion}",
        dialogTitle: "Update!",
        updateButtonText: "Let's Update",
      );
    }

    print(status.localVersion);
    print(status.storeVersion);
  }

  Future<File> getImage(ImageSource source)async{
    XFile? imageFile;
    imageFile = await image.pickImage(source: source);
    return File(imageFile!.path);
  }

  Future<File> cropNIDImage(File orignalImage,String title)async{
    File? cropImage;
    await ImageCropper().cropImage(
      sourcePath: orignalImage.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop $title NID card',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: false),
    ).then((value){
      cropImage = value!;
    });
    return cropImage!;
  }

  Future<File> cropProfileImage(File orignalImage,String title)async{
    File? cropImage;
    await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.png,
      compressQuality: 50,
      sourcePath: orignalImage.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop $title NID card',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false),
    ).then((value){
      cropImage = value!;
    });
    return cropImage!;
  }
}