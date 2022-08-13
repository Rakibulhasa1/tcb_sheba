import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'package:tcb/AdminDashboard/Model/RegistrationBeneficeryModel.dart';
import 'package:tcb/AdminDashboard/submit_for_registration.dart';
import 'package:tcb/show_toast.dart';

class BarCodeScanWithRegister extends StatefulWidget {
  BarCodeScanWithRegister({Key? key}) : super(key: key);

  @override
  State<BarCodeScanWithRegister> createState() => _BarCodeScanWithRegisterState();
}

class _BarCodeScanWithRegisterState extends State<BarCodeScanWithRegister> {
  String? value;
  var _formKey = GlobalKey<FormState>();

  List<String> designation = ['কর্মহীন',"দিনমজুর","রিকশাচালক","গৃহিনী","গার্মেন্টস শ্রমিক","অন্যান্য"];
  List<String> road = ['1 no road',"2 no road","3 no road","4 no road","5 no road"];


  String selectedValue = "কর্মহীন";
  String selectedRoad = "1 no road";

  int genderSelectedIndex=1;
  int marriageStatusSelectedIndex=1;
  String marriageStatus = 'বিবাহিত';
  String genderStatus = 'পুরুষ';

  final ImagePicker image = ImagePicker();
  File? nidImage;
  File? nid2Image;
  File? profileImage;

  String phoneNumber='';
  String gardianMane='';

  TextEditingController addressController =  TextEditingController(text: '');
  TextEditingController holdingController =  TextEditingController();
  TextEditingController mobileController =  TextEditingController();
  TextEditingController fatherNameController =  TextEditingController();
  TextEditingController motherNameController =  TextEditingController();
  TextEditingController spouseNameController =  TextEditingController();

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

  bool _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }else{
      return true;
    }
    //_formKey.currentState!.save();
  }




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scan'),
      ),
      body : Builder(
        builder: (context){
          if(value!=null){
            if(value!.contains('<pin>')){
              String nid = '';
              String dateOfBirth = '';
              String fullName = '';

              try{
                nid = value!.substring( value!.indexOf("<pin>")+5,value!.indexOf("</pin>"));
                dateOfBirth = value!.substring( value!.indexOf("<DOB>")+5,value!.indexOf("</DOB>"));
                fullName = value!.substring( value!.indexOf("<name>")+6,value!.indexOf("</name>"));
              }catch(e){

              }


              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  এনআইডি',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.withOpacity(0.3)
                              ),
                              child: TextFormField(
                                enabled: false,
                                initialValue: nid,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  পুরো নাম',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.withOpacity(0.3)
                              ),
                              child: TextFormField(
                                enabled: false,
                                initialValue: fullName,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  জন্ম তারিখ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.withOpacity(0.3)
                              ),
                              child: TextFormField(
                                enabled: false,
                                initialValue: dateOfBirth,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  মোবাইলে নম্বর',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: phoneNumber.length==11?Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),
                              ),
                              child: TextFormField(
                                enabled: true,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    hintText: 'নম্বর লিখুন',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                                controller: mobileController,
                                onChanged: (value){
                                  setState(() {
                                    phoneNumber = value;
                                  });
                                },
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'মোবাইল নম্বর লিখুন';
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24,bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('  লিঙ্গ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                              Wrap(
                                direction: Axis.horizontal,
                                runSpacing: 12,
                                spacing: 12,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        genderSelectedIndex = 1;
                                        genderStatus = 'পুরুষ';
                                      });
                                    },
                                    child: CustomButton(
                                      title: 'পুরুষ',
                                      isSelected: genderSelectedIndex==1?true:false,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        genderSelectedIndex = 2;
                                        genderStatus = 'মহিলা';
                                      });
                                    },
                                    child: CustomButton(
                                      title: "মহিলা",
                                      isSelected: genderSelectedIndex==2?true:false,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        genderSelectedIndex = 3;
                                        genderStatus = 'অন্যান্য';
                                      });
                                    },
                                    child: CustomButton(
                                      title: "অন্যান্য",
                                      isSelected: genderSelectedIndex==3?true:false,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24,bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('  বৈবাহিক অবস্থা',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          marriageStatusSelectedIndex = 1;
                                          marriageStatus = 'বিবাহিত';
                                        });
                                      },
                                      child: CustomButton(
                                        title: 'বিবাহিত',
                                        isSelected: marriageStatusSelectedIndex==1?true:false,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    AnimatedCrossFade(
                                      firstChild: InkWell(
                                        onTap: (){
                                          setState(() {
                                            marriageStatusSelectedIndex = 2;
                                            marriageStatus = 'বিধবা';
                                          });
                                        },
                                        child: CustomButton(
                                          title: "বিধবা",
                                          isSelected: marriageStatusSelectedIndex==2?true:false,
                                        ),
                                      ),
                                      secondChild: Container(),
                                      crossFadeState: genderSelectedIndex!=1?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                    AnimatedCrossFade(
                                      firstChild: InkWell(
                                        onTap: (){
                                          setState(() {
                                            marriageStatusSelectedIndex = 3;
                                            marriageStatus = 'বিপত্নীক';
                                          });
                                        },
                                        child: CustomButton(
                                          title: "বিপত্নীক",
                                          isSelected: marriageStatusSelectedIndex==3?true:false,
                                        ),
                                      ),
                                      secondChild: Container(),
                                      crossFadeState: genderSelectedIndex==1?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          marriageStatusSelectedIndex = 4;
                                          marriageStatus = 'তালাকপ্রাপ্ত';
                                        });
                                      },
                                      child: CustomButton(
                                        title: "তালাকপ্রাপ্ত",
                                        isSelected: marriageStatusSelectedIndex==4?true:false,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          marriageStatusSelectedIndex = 5;
                                          marriageStatus = 'অবিবাহিত';
                                        });
                                      },
                                      child: CustomButton(
                                        title: "অবিবাহিত",
                                        isSelected: marriageStatusSelectedIndex==5?true:false,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        secondChild: Container(),
                        crossFadeState: genderSelectedIndex!=3?CrossFadeState.showFirst:CrossFadeState.showSecond,
                        duration: Duration(milliseconds: 500),
                      ),

                      AnimatedCrossFade(
                        firstChild: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('পিতা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: gardianMane.length>1?Colors.green.withOpacity(0.3):Colors.grey[200]
                                    ),
                                    child: TextFormField(
                                      enabled: true,
                                      decoration: const InputDecoration(
                                          hintText: 'নাম লিখুন',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 4)
                                      ),
                                      controller: fatherNameController,
                                      onChanged: (value){
                                        setState(() {
                                          gardianMane = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('মাতা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: gardianMane.length>1?Colors.green.withOpacity(0.3):Colors.grey[200]
                                    ),
                                    child: TextFormField(
                                      enabled: true,
                                      decoration: const InputDecoration(
                                          hintText: 'নাম লিখুন',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 4)
                                      ),
                                      controller: motherNameController,
                                      onChanged: (value){
                                        setState(() {
                                          gardianMane = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ],
                        ),
                        secondChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(genderSelectedIndex==1?'স্ত্রী':'স্বামী',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: gardianMane.length>1?Colors.green.withOpacity(0.3):Colors.grey[200]
                                ),
                                child: TextFormField(
                                  enabled: true,
                                  decoration: const InputDecoration(
                                      hintText: 'নাম লিখুন',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 4)
                                  ),
                                  controller: spouseNameController,
                                  onChanged: (value){
                                    setState(() {
                                      gardianMane = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                        crossFadeState: genderSelectedIndex==3||marriageStatusSelectedIndex==5?CrossFadeState.showFirst:CrossFadeState.showSecond,
                        duration: Duration(milliseconds: 500),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  পেশা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text('পেশা'),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  value: selectedValue,
                                  items: designation.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedValue = newValue.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  বর্তমান ঠিকানা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200]
                              ),
                              child: TextFormField(
                                maxLines : 3,
                                enabled: true,
                                onChanged: (value){

                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                                controller: addressController,
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  গ্রাম/রাস্তা/পাড়া/মহল্লা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedRoad),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  value: selectedRoad,
                                  items: road.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedRoad = newValue.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  বাড়ি/হোল্ডিং',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200]
                              ),
                              child: TextFormField(
                                maxLines : 1,
                                enabled: true,
                                onChanged: (value){

                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                                controller: holdingController,
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                getImage(ImageSource.camera).then((value){
                                  cropImage(value).then((value){
                                    setState(() {
                                      profileImage = value;
                                    });
                                  });
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: profileImage!=null?Image.file(profileImage!):Image.asset('asstes/emptyProfile.jpg'),
                                    ),
                                  ),
                                  SizedBox(width: 24,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      profileImage!=null?Text('ছবি সংযুক্ত করা হয়েছে'):Text('কোন ছবি সংযুক্ত করা হয়নি'),
                                      SizedBox(height: 12),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green,
                                        ),
                                        child: Text('আপনার মুখমন্ডলের ছবি\nসংযুক্ত করুন',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: (){
                            getImage(ImageSource.camera).then((value){
                              cropImage(value).then((value){
                                setState(() {
                                  nidImage = value;
                                });
                              });
                            });
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              color: Colors.green.withOpacity(0.3),
                            ),
                            child: nidImage!=null?Image.file(nidImage!):Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add,size: 32),
                                Text('আপনার NID কার্ডের সম্মুখ পেইজ\nসংযুক্ত করতে এখানে ক্লিক করুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: (){
                            getImage(ImageSource.camera).then((value){
                              cropImage(value).then((value){
                                setState(() {
                                  nid2Image = value;
                                });
                              });
                            });
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              color: Colors.green.withOpacity(0.3),
                            ),
                            child: nid2Image!=null?Image.file(nid2Image!):Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add,size: 32),
                                Text('আপনার NID কার্ডের পিছনের পেইজ\nসংযুক্ত করতে এখানে ক্লিক করুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GestureDetector(
                          onTap: () {
                            if(_submit()){
                              if(mobileController.text.isNotEmpty&&nidImage!=null&&nidImage!=null){
                                RegistrationBeneficeryModel data = RegistrationBeneficeryModel(
                                  oldNid: nid,
                                  smartCardNid: '',
                                  phone: mobileController.text??'',
                                  dateOfBirth: dateOfBirth,
                                  gender: genderStatus,
                                  marrigialStatus: marriageStatus,
                                  ocupation: selectedValue,
                                  currentAddress: addressController.text??'',
                                  roadNo: selectedRoad,
                                  houseHolding: holdingController.text??'',
                                  profileImage: profileImage!,
                                  nid2Image: nid2Image!,
                                  nidImage: nidImage!,
                                  barthNo: '',
                                  fatherName: fatherNameController.text??'',
                                  fullData: value!,
                                  fulName: fullName,
                                  motherName: motherNameController.text??'',
                                  spouseName: spouseNameController.text??'',
                                );
                                Navigator.push(context, CupertinoPageRoute(builder: (context)=>SubmitForRegistration(data: data,)));
                              }else{
                                if(nidImage==null||nid2Image==null||profileImage==null){
                                  ShowToast.myToast("Please input nid card or profile picture", Colors.black, 2);
                                }
                                if(mobileController.text.length<11){
                                  ShowToast.myToast("Please input phone number", Colors.black, 2);
                                }
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              color: Colors.green,
                            ),
                            child: Text('দেখুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              );


            }else{
              String oldNid = '';
              String newNid = '';
              String dateOfBirth = '';
              String fullName = '';

              try{
                newNid = value!.substring( value!.indexOf("NW")+2, value!.indexOf("OL")-1);
                oldNid = value!.substring( value!.indexOf("OL")+2,value!.indexOf("BR")-1);
                dateOfBirth = value!.substring( value!.indexOf("BR")+2,value!.indexOf("PE")-1);
                fullName = value!.substring( value!.indexOf("NM")+2,value!.indexOf("NW")-1);
              }catch(e){

              }


              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: ListView(
                  children: [
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  স্মার্ট কার্ড নম্বর',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]
                            ),
                            child: TextFormField(
                              enabled: true,
                              initialValue: newNid,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  পুরাতন এনআইডি',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]
                            ),
                            child: TextFormField(
                              enabled: true,
                              initialValue: oldNid,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  পুরো নাম',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green.withOpacity(0.3)
                            ),
                            child: TextFormField(
                              enabled: true,
                              initialValue: fullName,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  জন্ম তারিখ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green.withOpacity(0.3)
                            ),
                            child: TextFormField(
                              enabled: true,
                              initialValue: dateOfBirth,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  মোবাইলে নম্বর',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: phoneNumber.length==11?Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),
                            ),
                            child: TextFormField(
                              enabled: true,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  hintText: 'নম্বর লিখুন',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                              controller: mobileController,
                              onChanged: (value){
                                setState(() {
                                  phoneNumber = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24,bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  লিঙ্গ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            Wrap(
                              direction: Axis.horizontal,
                              runSpacing: 12,
                              spacing: 12,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      genderSelectedIndex = 1;
                                      genderStatus = 'পুরুষ';
                                    });
                                  },
                                  child: CustomButton(
                                    title: 'পুরুষ',
                                    isSelected: genderSelectedIndex==1?true:false,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      genderSelectedIndex = 2;
                                      genderStatus = 'মহিলা';
                                    });
                                  },
                                  child: CustomButton(
                                    title: "মহিলা",
                                    isSelected: genderSelectedIndex==2?true:false,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      genderSelectedIndex = 3;
                                      genderStatus = 'অন্যান্য';
                                    });
                                  },
                                  child: CustomButton(
                                    title: "অন্যান্য",
                                    isSelected: genderSelectedIndex==3?true:false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24,bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('  বৈবাহিক অবস্থা',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        marriageStatusSelectedIndex = 1;
                                        marriageStatus = 'বিবাহিত';
                                      });
                                    },
                                    child: CustomButton(
                                      title: 'বিবাহিত',
                                      isSelected: marriageStatusSelectedIndex==1?true:false,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  AnimatedCrossFade(
                                    firstChild: InkWell(
                                      onTap: (){
                                        setState(() {
                                          marriageStatusSelectedIndex = 2;
                                          marriageStatus = 'বিধবা';
                                        });
                                      },
                                      child: CustomButton(
                                        title: "বিধবা",
                                        isSelected: marriageStatusSelectedIndex==2?true:false,
                                      ),
                                    ),
                                    secondChild: Container(),
                                    crossFadeState: genderSelectedIndex!=1?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                    duration: Duration(milliseconds: 500),
                                  ),
                                  AnimatedCrossFade(
                                    firstChild: InkWell(
                                      onTap: (){
                                        setState(() {
                                          marriageStatusSelectedIndex = 3;
                                          marriageStatus = 'বিপত্নীক';
                                        });
                                      },
                                      child: CustomButton(
                                        title: "বিপত্নীক",
                                        isSelected: marriageStatusSelectedIndex==3?true:false,
                                      ),
                                    ),
                                    secondChild: Container(),
                                    crossFadeState: genderSelectedIndex==1?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                    duration: Duration(milliseconds: 500),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        marriageStatusSelectedIndex = 4;
                                        marriageStatus = 'তালাকপ্রাপ্ত';
                                      });
                                    },
                                    child: CustomButton(
                                      title: "তালাকপ্রাপ্ত",
                                      isSelected: marriageStatusSelectedIndex==4?true:false,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        marriageStatusSelectedIndex = 5;
                                        marriageStatus = 'অবিবাহিত';
                                      });
                                    },
                                    child: CustomButton(
                                      title: "অবিবাহিত",
                                      isSelected: marriageStatusSelectedIndex==5?true:false,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      secondChild: Container(),
                      crossFadeState: genderSelectedIndex!=3?CrossFadeState.showFirst:CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 500),
                    ),

                    AnimatedCrossFade(
                      firstChild: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('পিতা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: gardianMane.length>1?Colors.green.withOpacity(0.3):Colors.grey[200]
                                  ),
                                  child: TextFormField(
                                    enabled: true,
                                    decoration: const InputDecoration(
                                        hintText: 'নাম লিখুন',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                                    ),
                                    controller: fatherNameController,
                                    onChanged: (value){
                                      setState(() {
                                        gardianMane = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 24),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('মাতা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: gardianMane.length>1?Colors.green.withOpacity(0.3):Colors.grey[200]
                                  ),
                                  child: TextFormField(
                                    enabled: true,
                                    decoration: const InputDecoration(
                                        hintText: 'নাম লিখুন',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(vertical: 4)
                                    ),
                                    controller: motherNameController,
                                    onChanged: (value){
                                      setState(() {
                                        gardianMane = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ],
                      ),
                      secondChild: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(genderSelectedIndex==1?'স্ত্রী':'স্বামী',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: gardianMane.length>1?Colors.green.withOpacity(0.3):Colors.grey[200]
                              ),
                              child: TextFormField(
                                enabled: true,
                                decoration: const InputDecoration(
                                    hintText: 'নাম লিখুন',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 4)
                                ),
                                controller: spouseNameController,
                                onChanged: (value){
                                  setState(() {
                                    gardianMane = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      crossFadeState: genderSelectedIndex==3||marriageStatusSelectedIndex==5?CrossFadeState.showFirst:CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 500),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  পেশা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text('পেশা'),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                isExpanded: true,
                                value: selectedValue,
                                items: designation.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedValue = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  বর্তমান ঠিকানা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[200]
                            ),
                            child: TextFormField(
                              maxLines : 3,
                              enabled: true,
                              onChanged: (value){

                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                              controller: addressController,
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  গ্রাম/রাস্তা/পাড়া/মহল্লা',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(selectedRoad),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                isExpanded: true,
                                value: selectedRoad,
                                items: road.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedRoad = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  বাড়ি/হোল্ডিং',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[200]
                            ),
                            child: TextFormField(
                              maxLines : 1,
                              enabled: true,
                              onChanged: (value){

                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4)
                              ),
                              controller: holdingController,
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              getImage(ImageSource.camera).then((value){
                                cropImage(value).then((value){
                                  setState(() {
                                    profileImage = value;
                                  });
                                });
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: profileImage!=null?Image.file(profileImage!):Image.asset('asstes/emptyProfile.jpg'),
                                  ),
                                ),
                                SizedBox(width: 24,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    profileImage!=null?Text('ছবি সংযুক্ত করা হয়েছে'):Text('কোন ছবি সংযুক্ত করা হয়নি'),
                                    SizedBox(height: 12),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: Text('আপনার মুখমন্ডলের ছবি\nসংযুক্ত করুন',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: (){
                          getImage(ImageSource.camera).then((value){
                            cropImage(value).then((value){
                              setState(() {
                                nidImage = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                            color: Colors.grey[200],
                          ),
                          child: nidImage!=null?Image.file(nidImage!):Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add,size: 32),
                              Text('আপনার NID কার্ডের সম্মুখ পেইজা\nসংযুক্ত করতে এখানে ক্লিক করুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: (){
                          getImage(ImageSource.camera).then((value){
                            cropImage(value).then((value){
                              setState(() {
                                nid2Image = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                            color: Colors.green.withOpacity(0.3),
                          ),
                          child: nid2Image!=null?Image.file(nid2Image!):Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add,size: 32),
                              Text('আপনার NID কার্ডের পিছনের পেইজা\nসংযুক্ত করতে এখানে ক্লিক করুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GestureDetector(
                        onTap: (){
                          RegistrationBeneficeryModel data = RegistrationBeneficeryModel(
                            oldNid: oldNid,
                            smartCardNid: newNid,
                            phone: mobileController.text??'',
                            dateOfBirth: dateOfBirth,
                            gender: genderStatus,
                            marrigialStatus: marriageStatus,
                            ocupation: selectedValue,
                            currentAddress: addressController.text??'',
                            roadNo: selectedRoad,
                            houseHolding: holdingController.text??'',
                            profileImage: profileImage!,
                            nid2Image: nid2Image!,
                            nidImage: nidImage!,
                            barthNo: '',
                            fatherName: fatherNameController.text??'',
                            fullData: value!,
                            fulName: fullName,
                            motherName: motherNameController.text??'',
                            spouseName: spouseNameController.text??'',
                          );
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>SubmitForRegistration(data: data,)));                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                            color: Colors.green,
                          ),
                          child: Text('দেখুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              );
            }
          }else{
            return QrCamera(
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2,top: MediaQuery.of(context).size.height/8),
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height/1.5,
                  width: 1,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ),
              ),
              qrCodeCallback: (value){
                setState(() {
                  this.value = value;
                });
              },
              onError: (context, error){
                return Center(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Something is wrong\nTry Again",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                  ),
                );
              },
              formats: const [BarcodeFormats.ALL_FORMATS],
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );
  }
}


class CustomButton extends StatelessWidget {

  final String title;
  bool isSelected;


  CustomButton({Key? key,required this.title, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: isSelected? Colors.green : Colors.grey[200],
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Text(title,style: TextStyle(color: isSelected?Colors.white:Colors.grey[700]),),
      ),
    );
  }
}


