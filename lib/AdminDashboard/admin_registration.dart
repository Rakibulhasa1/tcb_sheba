import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcb/AdminDashboard/send_otp_by_register.dart';

import 'bar_code_scan_for_beneficery_details.dart';

class AdminRegistration extends StatefulWidget {

  String beneficeryValue;
  AdminRegistration({Key? key,required this.beneficeryValue}) : super(key: key);

  @override
  _AdminRegistrationState createState() => _AdminRegistrationState();
}

class _AdminRegistrationState extends State<AdminRegistration> {


  String nid = '';
  String dateOfBirth = '';
  String fullName = '';
  String newNid = '';


  List<UserTypeModel> selectedWardList = [];

  List<UserTypeModel> userTypeList = [
    UserTypeModel(type: "প্রশাসনিক", id: "1"),
    UserTypeModel(type: "জনপ্রতিনিধি", id: "2"),
    UserTypeModel(type: "ডিলার", id: "3"),
    UserTypeModel(type: "টেকনিক্যাল", id: "4"),
  ];

  List<UserTypeModel> representativesTypeList = [
    UserTypeModel(type: "কাউন্সিলর", id: "1"),
    UserTypeModel(type: "মহিলা কাউন্সিলর", id: "2"),
    UserTypeModel(type: "চেয়ারম্যান", id: "3"),
    UserTypeModel(type: "উপজেলা চেয়ারম্যান", id: "4"),
    UserTypeModel(type: "সংসদ সদস্য", id: "5"),
  ];

  List<UserTypeModel> addressTypeList = [
    UserTypeModel(type: "ইউনিয়ন", id: "1"),
    UserTypeModel(type: "পৌরসভা", id: "2"),
    UserTypeModel(type: "সিটি কর্পোর্রেশন", id: "3"),
  ];

  List<UserTypeModel> areaTypeList = [
    UserTypeModel(type: "বিভাগ", id: "1"),
    UserTypeModel(type: "জেলা", id: "2"),
    UserTypeModel(type: "সিটি কর্পোরেশন", id: "3"),
    UserTypeModel(type: "উপজেলা", id: "4"),
    UserTypeModel(type: "পৌরসভা", id: "5"),
    UserTypeModel(type: "অঞ্চল", id: "6"),
  ];

  List<UserTypeModel> designationList = [
    UserTypeModel(type: "সিভিল সার্বিস", id: "1"),
    UserTypeModel(type: "টিসিবি চেয়ারম্যান", id: "2"),
  ];

  List<UserTypeModel> wardList = [
    UserTypeModel(type: "ward 1", id: "1"),
    UserTypeModel(type: "ward 2", id: "2"),
    UserTypeModel(type: "ward 3", id: "3"),
    UserTypeModel(type: "ward 4", id: "4"),
    UserTypeModel(type: "ward 5", id: "5"),
    UserTypeModel(type: "ward 6", id: "6"),
  ];


  List<UserTypeModel> unionList = [];
  List<UserTypeModel> upozilaList = [];
  List<UserTypeModel> zilaList = [];
  List<UserTypeModel> powrosovaList = [];
  List<UserTypeModel> cityCorpList = [];
  List<UserTypeModel> divisionList = [];
  List<UserTypeModel> vilageList = [];

  UserTypeModel selectedUserType = UserTypeModel(type: "প্রশাসনিক", id: "1");
  UserTypeModel selectedRepresentativesTypeList = UserTypeModel(type: "মেম্বর", id: "1");
  UserTypeModel selectedAddress = UserTypeModel(type: "ঠিকানার ধরণ সিলেক্ট করুন", id: " ");


  UserTypeModel selectedWard= UserTypeModel(type: "ওয়ার্ড সিলেক্ট করুন", id: " ");
  UserTypeModel selectedUnion= UserTypeModel(type: "ইউনিয়ন সিলেক্ট করুন", id: " ");
  UserTypeModel selectedUpozila= UserTypeModel(type: "উপজেলা সিলেক্ট করুন", id: " ");
  UserTypeModel selectedZila= UserTypeModel(type: "জেলা সিলেক্ট করুন", id: " ");
  UserTypeModel selectedPowrosova= UserTypeModel(type: "পৌরসভা সিলেক্ট করুন", id: " ");
  UserTypeModel selectedcityCorp= UserTypeModel(type: "সিটি কর্পোর্রেশন সিলেক্ট করুন", id: " ");
  UserTypeModel selectedArea= UserTypeModel(type: "এরিয়া সিলেক্ট করুন", id: " ");
  UserTypeModel selectedDivision= UserTypeModel(type: "বিভাগ সিলেক্ট করুন", id: " ");


  UserTypeModel selectedDesignation= UserTypeModel(type: "পদবী সিলেক্ট করুন", id: " ");
  UserTypeModel selectedVillage= UserTypeModel(type: "অঞ্চল সিলেক্ট করুন", id: " ");

  String phoneNumber ="";
  bool isCurrentPhone = false;
  int genderSelectedIndex = 1;

  TextEditingController nidController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController confirmMobileController = TextEditingController();
  TextEditingController currentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration")),
      body: Builder(
        builder: (context) {
          if(widget.beneficeryValue.contains('<pin>')){

            nid = widget.beneficeryValue.substring( widget.beneficeryValue.indexOf("<pin>")+5,widget.beneficeryValue.indexOf("</pin>"));
            dateOfBirth = widget.beneficeryValue.substring( widget.beneficeryValue.indexOf("<DOB>")+5,widget.beneficeryValue.indexOf("</DOB>"));
            fullName = widget.beneficeryValue.substring( widget.beneficeryValue.indexOf("<name>")+6,widget.beneficeryValue.indexOf("</name>"));

          }else{
            newNid = widget.beneficeryValue.substring(widget.beneficeryValue.indexOf("NW")+2, widget.beneficeryValue.indexOf("OL")-1);
            nid = widget.beneficeryValue.substring( widget.beneficeryValue.indexOf("OL")+2,widget.beneficeryValue.indexOf("BR")-1);
            dateOfBirth = widget.beneficeryValue.substring( widget.beneficeryValue.indexOf("BR")+2,widget.beneficeryValue.indexOf("PE")-1);
            fullName = widget.beneficeryValue.substring( widget.beneficeryValue.indexOf("NM")+2,widget.beneficeryValue.indexOf("NW")-1);
          }

          return ListView(
            children: [
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  পুরো নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
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
                    Text('  এনআইডি *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
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
                    Text('  জন্ম তারিখ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
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
                    Text('  মোবাইলে নম্বর *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
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
                            hintText: '01X XXXXXXXX',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isCurrentPhone?Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),
                      ),
                      child: TextFormField(
                        enabled: true,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            hintText: 'মোবাইল নম্বর পুনরায় লিখুন *',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 4)
                        ),
                        controller: confirmMobileController,
                        onChanged: (value){
                          setState(() {
                            if(mobileController.text==value){
                              isCurrentPhone = true;
                            }else{
                              isCurrentPhone = false;
                            }
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
                      Text('  লিঙ্গ *',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      Wrap(
                        direction: Axis.horizontal,
                        runSpacing: 12,
                        spacing: 12,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                genderSelectedIndex = 1;
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
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  ব্যবহারকারীর ধরণ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(selectedUserType.type),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          items: userTypeList.map((UserTypeModel items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.type),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedUserType = newValue as UserTypeModel;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              Builder(builder: (context){
                if(selectedUserType.id=="2"){
                  return Column(
                    children: [
                      AnimatedCrossFade(
                        firstChild: Container(),
                        secondChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('  জনপ্রতিনিদির ধরণ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 38,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text(selectedRepresentativesTypeList.type),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    items: representativesTypeList.map((UserTypeModel items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items.type),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedRepresentativesTypeList = newValue as UserTypeModel;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                        crossFadeState: selectedUserType.id=="2"?CrossFadeState.showSecond:CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 250),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  ঠিকানার ধরণ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedAddress.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: addressTypeList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedAddress = newValue as UserTypeModel;
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
                            Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedZila.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: zilaList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedZila = newValue as UserTypeModel;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Builder(builder: (context){
                        switch(selectedAddress.id){
                          case "1" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  উপজেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUpozila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: upozilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUpozila = newValue as UserTypeModel;
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
                                      Text('  ইউনিয়ন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUnion.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: unionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUnion = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "2" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  পৌরসভা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedPowrosova.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: powrosovaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedPowrosova = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "3" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  সিটি কর্পোর্রেশন নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedcityCorp.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: cityCorpList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedcityCorp = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          default :
                            return Container();
                        }
                      }),
                    ],
                  );
                } else if(selectedUserType.id=="1"){
                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  এলাকার ধরণ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedArea.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: areaTypeList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedArea = newValue as UserTypeModel;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Builder(builder: (context){
                        switch (selectedArea.id){
                          case "1" :
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 38,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text(selectedDivision.type),
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        isExpanded: true,
                                        items: divisionList.map((UserTypeModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.type),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedDivision = newValue as UserTypeModel;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            );

                          case "2" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedDivision.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: divisionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedDivision = newValue as UserTypeModel;
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
                                      Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedZila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: zilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedZila = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "3" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedDivision.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: divisionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedDivision = newValue as UserTypeModel;
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
                                      Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedZila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: zilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedZila = newValue as UserTypeModel;
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
                                      Text('  সিটি কর্পোর্রেশন নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedcityCorp.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: cityCorpList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedcityCorp = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "4" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedDivision.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: divisionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedDivision = newValue as UserTypeModel;
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
                                      Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedZila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: zilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedZila = newValue as UserTypeModel;
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
                                      Text('  উপজেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUpozila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: upozilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUpozila = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "5" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedDivision.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: divisionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedDivision = newValue as UserTypeModel;
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
                                      Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedZila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: zilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedZila = newValue as UserTypeModel;
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
                                      Text('  উপজেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUpozila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: upozilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUpozila = newValue as UserTypeModel;
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
                                      Text('  পৌরসভা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedPowrosova.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: powrosovaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedPowrosova = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "6" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  বিভাগ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedDivision.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: divisionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedDivision = newValue as UserTypeModel;
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
                                      Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedZila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: zilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedZila = newValue as UserTypeModel;
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
                                      Text('  সিটি কর্পোর্রেশন নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedcityCorp.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: cityCorpList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedcityCorp = newValue as UserTypeModel;
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
                                      Text('  অঞ্চল *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedVillage.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: vilageList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedVillage = newValue as UserTypeModel;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          default :
                            return Container();
                        }
                      },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  পদবী *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedDesignation.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: designationList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedDesignation = newValue as UserTypeModel;
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
                            Text('  সার্ভিস আইডি *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.3)
                              ),
                              child: TextFormField(
                                enabled: true,
                                controller: nameController,
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
                    ],
                  );
                }else if(selectedUserType.id=="3"){
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  ঠিকানার ধরণ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedAddress.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: addressTypeList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedAddress = newValue as UserTypeModel;
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
                            Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedZila.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: zilaList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedZila = newValue as UserTypeModel;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Builder(builder: (context){
                        switch(selectedAddress.id){
                          case "1" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  উপজেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUpozila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: upozilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUpozila = newValue as UserTypeModel;
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
                                      Text('  ইউনিয়ন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUnion.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: unionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUnion = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                                selectedWardList.add(selectedWard);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "2" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  পৌরসভা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedPowrosova.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: powrosovaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedPowrosova = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                                selectedWardList.add(selectedWard);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "3" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  সিটি কর্পোর্রেশন নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedcityCorp.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: cityCorpList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedcityCorp = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                                selectedWardList.where((element) => element.id==selectedWard.id);

                                                selectedWardList.add(selectedWard);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          default :
                            return Container();
                        }
                      }),
                      Wrap(
                        runSpacing: 4,
                        spacing: 4,
                        children: [

                          for(int i = 0;i<selectedWardList.length;i++)
                            InkWell(
                              onTap : (){
                                setState((){
                                  selectedWardList.removeAt(i);
                                });
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                  child: Row(
                                    children: [
                                      Text("${selectedWardList[i].type}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      SizedBox(width: 10),
                                      Icon(Icons.close,color: Colors.white),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                              ),
                            ),

                        ],
                      ),
                    ],
                  );
                }else if(selectedUserType.id=="4"){
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  ঠিকানার ধরণ *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedAddress.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: addressTypeList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedAddress = newValue as UserTypeModel;
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
                            Text('  জেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(selectedZila.type),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: zilaList.map((UserTypeModel items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.type),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedZila = newValue as UserTypeModel;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Builder(builder: (context){
                        switch(selectedAddress.id){
                          case "1" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  উপজেলা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUpozila.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: upozilaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUpozila = newValue as UserTypeModel;
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
                                      Text('  ইউনিয়ন *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedUnion.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: unionList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedUnion = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                                selectedWardList.add(selectedWard);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "2" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  পৌরসভা *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedPowrosova.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: powrosovaList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedPowrosova = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                                selectedWardList.add(selectedWard);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          case "3" :
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('  সিটি কর্পোর্রেশন নাম *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedcityCorp.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: cityCorpList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedcityCorp = newValue as UserTypeModel;
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
                                      Text('  ওয়ার্ড *',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 38,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(selectedWard.type),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            items: wardList.map((UserTypeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.type),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWard = newValue as UserTypeModel;
                                                selectedWardList.where((element) => element.id==selectedWard.id);

                                                selectedWardList.add(selectedWard);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );

                          default :
                            return Container();
                        }
                      }),
                      Wrap(
                        runSpacing: 4,
                        spacing: 4,
                        children: [

                          for(int i = 0;i<selectedWardList.length;i++)
                            InkWell(
                              onTap : (){
                                setState((){
                                  selectedWardList.removeAt(i);
                                });
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                  child: Row(
                                    children: [
                                      Text("${selectedWardList[i].type}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      SizedBox(width: 10),
                                      Icon(Icons.close,color: Colors.white),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                              ),
                            ),

                        ],
                      ),
                    ],
                  );
                }else{
                  return Container();
                }
              }),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>SendOtpByRegister()));
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Text("সাবমিট করুন",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          );
        }
      ),
    );
  }
}

class UserTypeModel{
  final String type;
  final String id;

  UserTypeModel({required this.type,required this.id});
}
