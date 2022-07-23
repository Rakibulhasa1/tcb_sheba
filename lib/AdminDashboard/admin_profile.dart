import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          GetStorage().erase();
        },
        child: Text('Logout'),
      ),
    );
  }
}
