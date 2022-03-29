import 'package:flutter/material.dart';
import 'package:tcb/SqfliteDataBase/DarabaseHelper.dart';
import 'package:tcb/SqfliteDataBase/Model/SaveBenificaryDataModel.dart';

class CreateDatabaseView extends StatefulWidget {
  const CreateDatabaseView({Key? key}) : super(key: key);

  @override
  _CreateDatabaseViewState createState() => _CreateDatabaseViewState();
}

class _CreateDatabaseViewState extends State<CreateDatabaseView> {

  DatabaseHelper? databaseHelper;
  late Future<List<SaveBenificaryDataModel>> myReceiveDataList;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    loadData();

    super.initState();
  }


  loadData()async{
    myReceiveDataList = databaseHelper!.getData();
    print(myReceiveDataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('এ সেবাটি অচিরেই চালু হবে।',style: TextStyle(color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      
    );
  }
}
