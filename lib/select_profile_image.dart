import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/BeneficeryDashboard/Model/user_update_data_model.dart';
import 'package:tcb/BeneficeryDashboard/View/beneficery_side_navigation.dart';
import 'package:tcb/show_toast.dart';

class SelectProfileImage extends StatefulWidget {
  SelectProfileImage({Key? key}) : super(key: key);

  @override
  State<SelectProfileImage> createState() => _SelectProfileImageState();
}

class _SelectProfileImageState extends State<SelectProfileImage> {

  final ImagePicker image = ImagePicker();
  File? profileImage;

  bool isWorking = false;

  Future<File> getImage(ImageSource source)async{
    XFile? imageFile;
    imageFile = await image.pickImage(source: source);
    return File(imageFile!.path);
  }

  Future<File> cropImage(File orignalImage)async{
    File? cropImage;
    await ImageCropper().cropImage(
      sourcePath: orignalImage.path,
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false),
    ).then((value){
      cropImage = value!;
    });
    return cropImage!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Your photo'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  getImage(ImageSource.camera).then((value){
                    cropImage(value).then((value){
                      setState(() {
                        profileImage = value;
                      });
                    });
                  });
                },
                child: profileImage!=null?Container(
                  alignment: Alignment.bottomCenter,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(profileImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt,size: 16,color: Colors.grey[100]),
                        Text('পরিবর্তন করুন',style: TextStyle(color: Colors.grey[100],fontSize: 12)),
                      ],
                    ),
                  ),
                ):Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt,size: 32,color: Colors.grey[700]),
                      Text('আপনার ছবি তুলুন',style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
              ),
            ),

            profileImage!=null?AnimatedCrossFade(
              firstChild: InkWell(
                onTap: (){
                  setState(() {
                    isWorking = true;
                  });
                  try{
                    UserUpdateDataModel userData = UserUpdateDataModel(fontNid: profileImage!, beneficeryId: GetStorage().read('beneficiaryId'),);
                    ApiController().updateUserNid(dataModel: userData, endPoint: ApiEndPoints().profileUpdate).then((value){
                      if(value.responseCode==200){
                        ShowToast.myToast('Upload Successfully', Colors.black, 2);
                        GetStorage().write('isHasImage','profilePicUpdate');
                        setState(() {
                          isWorking = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BeneficerySideNavigation()), (Route<dynamic> route) => false);

                      }else{
                        setState(() {
                          isWorking = false;
                        });
                        ShowToast.myToast('Something is wrong', Colors.black, 2);
                      }
                    });
                  }catch(e){
                    setState(() {
                      isWorking = false;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('আপলোড করুন',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                ),
              ),
              secondChild: Container(
                alignment: Alignment.center,
                height: 40,
                child: CircularProgressIndicator(),
              ),
              crossFadeState: isWorking?CrossFadeState.showSecond:CrossFadeState.showFirst,
              duration: Duration(milliseconds: 500),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
