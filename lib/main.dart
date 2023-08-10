import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/AdminDashboard/Controller/DialogDataController.dart';
import 'package:tcb/AdminDashboard/Controller/PramsController.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/MasterApiController.dart';
import 'package:tcb/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DashboardController()),
        ChangeNotifierProvider(create: (context)=>DealerInfoController()),
        ChangeNotifierProvider(create: (context)=>BeneficiaryInfoController()),
        ChangeNotifierProvider(create: (context)=>MasterApiController()),
        ChangeNotifierProvider(create: (context)=>DialogDataController()),
        ChangeNotifierProvider(create: (context)=>UserInfoController()),
        ChangeNotifierProvider(create: (context)=>PramsController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Upokari',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.green, elevation: 0.0,),
        ),
        home: SplashScreen(),
      ),
    );
  }
}