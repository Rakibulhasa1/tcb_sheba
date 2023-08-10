import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Controller/UserInfoController.dart';

class RegistrationProfile extends StatefulWidget {
  const RegistrationProfile({Key? key}) : super(key: key);

  @override
  State<RegistrationProfile> createState() => _RegistrationProfileState();
}

class _RegistrationProfileState extends State<RegistrationProfile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoController>(
        builder: (context,profileData,child) {
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.bottomCenter,
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(profileData.userInfoModel!.data!.userInfo!.userFullName,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 20),),
                      Text(profileData.userInfoModel!.data!.userInfo!.userMobile,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 16),),
                      SizedBox(height: 24,),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(ApiEndPoints().imageBaseUrl+profileData.userInfoModel!.data!.userInfo!.userImage,),
                ),
              ),
              Positioned(
                top: 300,
                child: Text('${profileData.userInfoModel!.data!.userAreaInfo!.districtNameBangla}, ${profileData.userInfoModel!.data!.userAreaInfo!.upazilaNameBangla}, ${profileData.userInfoModel!.data!.userAreaInfo!.unionNameBangla}, ${profileData.userInfoModel!.data!.userAreaInfo!.wordNameBangla}'),
              ),
            ],
          );
        }
    );
  }
}
