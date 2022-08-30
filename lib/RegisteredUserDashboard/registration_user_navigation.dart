import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Authrization/Controller/LoginDataController.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/RegisteredUserDashboard/registration_dashboard.dart';
import 'package:tcb/SqfliteDataBase/View/create_database_view.dart';
import 'package:tcb/GeneralDashboard/dashboard.dart';
import 'package:tcb/GeneralDashboard/profile.dart';
import 'package:tcb/change_password.dart';
import 'package:tcb/support_team_message.dart';
import 'package:tcb/terms_and_condition.dart';

class RegistrationUserNavigation extends StatefulWidget {
  const RegistrationUserNavigation({Key? key}) : super(key: key);

  @override
  _RegistrationUserNavigationState createState() => _RegistrationUserNavigationState();
}

class _RegistrationUserNavigationState extends State<RegistrationUserNavigation> {


  List<Widget> widgetList = [
    RegistureUserDashboard(),
    CreateReport(),
    Profile(),
  ];

  int bottomNavigatonIndex = 0;

  @override
  void initState() {
    var body = {
      'email' : GetStorage().read('email'),
      'password' : GetStorage().read('password'),
    };
    Future.delayed(Duration.zero).then((value){
      Provider.of<LoginDataController>(context,listen: false).getResponse(body);
      Provider.of<DealerInfoController>(context,listen: false).getDealerData();
    });
    HelperClass().checkVersion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: const Icon(Icons.qr_code),
          ),

          bottomNavigatonIndex==2?Container():Consumer<LoginDataController>(
            builder: (context,data,child) {
              if(data.apiResponse.isWorking!){
                return Container();
              }
              if(data.apiResponse.responseError!){
                return Container();
              }
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(ApiEndPoints().imageBaseUrl+data.userProfileModel!.data!.userImage!),
                ),
              );
            }
          ),

        ],
      ),


      body: widgetList[bottomNavigatonIndex],
      bottomNavigationBar:BottomNavigationBar(
        unselectedItemColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        currentIndex: bottomNavigatonIndex,
        type: BottomNavigationBarType.fixed ,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'হোম',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.segment),
              label: 'রিপোর্টস',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'প্রোফাইল'
          )
        ],
        onTap: (index){
          setState(() {
            bottomNavigatonIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: SafeArea(
          top: true,
          child: Column(
            children: [
              Consumer<LoginDataController>(
                  builder: (context,data,child) {
                    if(data.apiResponse.isWorking!){
                      return Container();
                    }
                    if(data.apiResponse.responseError!){
                      return Container();
                    }
                    return Container(
                      height: 150,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage(ApiEndPoints().imageBaseUrl+data.userProfileModel!.data!.userImage,),
                          ),
                          Text(data.userProfileModel!.data!.userFullName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          Text(data.userProfileModel!.data!.userMobile),
                        ],
                      ),
                    );
                  }
              ),
              SizedBox(height: 24),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  setState(() {
                    bottomNavigatonIndex = 0;
                  });
                },
                leading: Icon(Icons.home),
                title: Text('হোম'),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  setState(() {
                    bottomNavigatonIndex = 1;
                  });
                },
                leading: Icon(Icons.add_chart_outlined),
                title: Text('রিপোর্ট'),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  setState(() {
                    bottomNavigatonIndex = 2;
                  });
                },
                leading: Icon(Icons.person),
                title: Text('প্রোফাইল'),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChangePassword()));
                },
                leading: Icon(Icons.lock),
                title: Text('চেঞ্জ পাসওয়ার্ড'),
              ),
              ListTile(
                onTap: (){

                },
                leading: Icon(Icons.radio_button_checked_outlined),
                title: Text('আমাদের সম্পর্কে'),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsAndCondition()));
                },
                leading: Icon(Icons.account_tree),
                title: Text('Terms and Condition'),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>SupportTeamMessage()));
                },
                leading: Icon(Icons.message),
                title: Text('আমাকে বলুন'),
              ),
              Spacer(),
              ListTile(
                tileColor: Colors.red,
                onTap: (){
                  AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      body: const Center(child: Text(
                        'আপনি কি লগঅউট করতে চাচ্ছেন?',
                        style: TextStyle(fontSize: 12),
                      ),),
                      title: 'Logout',
                      btnOkOnPress: () {
                        GetStorage().erase();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                      },
                      btnCancelOnPress: (){

                      }
                  ).show();
                },
                leading: Icon(Icons.exit_to_app,color: Colors.white,size: 24),
                title: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
