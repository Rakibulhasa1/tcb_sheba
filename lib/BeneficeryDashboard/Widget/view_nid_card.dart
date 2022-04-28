
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/BeneficeryDashboard/Model/user_update_data_model.dart';
import 'package:tcb/show_toast.dart';

class ViewNidCard extends StatefulWidget {
  const ViewNidCard({Key? key}) : super(key: key);

  @override
  _ViewNidCardState createState() => _ViewNidCardState();
}

class _ViewNidCardState extends State<ViewNidCard> {

  final ImagePicker image = ImagePicker();

  File? fontPartImage;
  File? backPartImage;

  Future<File> getImage(ImageSource source)async{
    XFile? imageFile;
    imageFile = await image.pickImage(source: source);
    return File(imageFile!.path);
  }

  Future<File> cropImage(File orignalImage,String title)async{
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.INFO,
                  body: Column(
                    children: [
                      MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                          getImage(ImageSource.camera).then((value){
                            cropImage(value,'font').then((value){
                              setState(() {
                                fontPartImage = value;
                              });
                            });
                          });
                        },
                        child: const Text('Camera'),
                      ),
                      MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                          getImage(ImageSource.gallery).then((value){
                            cropImage(value,'font').then((value){
                              setState(() {
                                fontPartImage = value;
                              });
                            });
                          });
                        },
                        child: const Text('Gallery'),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                  title: 'Choose option',
              ).show();
            },
            child: fontPartImage!=null?Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              child: Image.file(fontPartImage!),
            ):Container(
              alignment: Alignment.center,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('জাতীয় পরিচয়পত্রের\nসামনের পৃষ্ঠা যুক্ত করুন',style: TextStyle(color: Colors.grey[800],fontSize: 12),textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.INFO,
                body: Column(
                  children: [
                    MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                        getImage(ImageSource.camera).then((value){
                          cropImage(value,'back').then((value){
                            setState(() {
                              backPartImage = value;
                            });
                          });
                        });
                      },
                      child: const Text('Camera'),
                    ),
                    MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                        getImage(ImageSource.gallery).then((value){
                          cropImage(value,'back').then((value){
                            setState(() {
                              backPartImage = value;
                            });
                          });
                        });
                      },
                      child: const Text('Gallery'),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
                title: 'Choose option',
              ).show();
            },
            child: backPartImage!=null?Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              child: Image.file(backPartImage!),
            ):Container(
              alignment: Alignment.center,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('জাতীয় পরিচয়পত্রের\nপেছনের পৃষ্ঠা যুক্ত করুন',style: TextStyle(color: Colors.grey[800],fontSize: 12),textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),


          fontPartImage!=null&&backPartImage!=null ?MaterialButton(
            color: Colors.blue,
            onPressed: (){
              // UserUpdateDataModel userData = UserUpdateDataModel(fontNid: fontPartImage!, backNid: backPartImage!, userId: GetStorage().read('user_id'));
              // ApiController().updateUserNid(dataModel: userData, endPoint: ApiEndPoints().saveNid).then((value){
              //   if(!value.responseError!){
              //     ShowToast.myToast('Upload Successfully', Colors.black, 2);
              //   }else{
              //     ShowToast.myToast('Something is wrong', Colors.black, 2);
              //   }
              // });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Save',style: TextStyle(color: Colors.white,fontSize: 12),),
                SizedBox(width: 8,),
                Icon(Icons.done,size: 20,color: Colors.white,),
              ],
            ),
          ):Container(),


          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     MaterialButton(
          //       color: Colors.blue,
          //       onPressed: (){
          //
          //       },
          //       child: Row(
          //         children: [
          //           Text('Download',style: TextStyle(color: Colors.white,fontSize: 12),),
          //           SizedBox(width: 8,),
          //           Icon(Icons.download_rounded,size: 20,color: Colors.white,),
          //         ],
          //       ),
          //     ),
          //     MaterialButton(
          //       color: Colors.blue,
          //       onPressed: (){
          //
          //       },
          //       child: Row(
          //         children: [
          //           Text('Share',style: TextStyle(color: Colors.white,fontSize: 12),),
          //           SizedBox(width: 8,),
          //           Icon(Icons.share,size: 20,color: Colors.white,),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 32,),
        ],
      ),
    );
  }
}
