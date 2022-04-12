import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Authrization/Controller/LoginDataController.dart';
import 'package:tcb/Authrization/View/login_page.dart';
import 'package:tcb/SqfliteDataBase/View/create_database_view.dart';
import 'package:tcb/GeneralDashboard/dashboard.dart';
import 'package:tcb/GeneralDashboard/profile.dart';

class GeneralUserNavigation extends StatefulWidget {
  const GeneralUserNavigation({Key? key}) : super(key: key);

  @override
  _GeneralUserNavigationState createState() => _GeneralUserNavigationState();
}

class _GeneralUserNavigationState extends State<GeneralUserNavigation> {


  List<Widget> widgetList = [
    Dashboard(),
    CreateDatabaseView(),
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          bottomNavigatonIndex==2?IconButton(
            onPressed: (){

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
                    GetStorage().remove('token');
                    GetStorage().remove('email');
                    GetStorage().remove('password');
                    GetStorage().remove('userType');
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                  },
                  btnCancelOnPress: (){

                  }
              ).show();

            },
            icon: const Icon(Icons.power_settings_new),
          ):Container(),
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
    );
  }
}
