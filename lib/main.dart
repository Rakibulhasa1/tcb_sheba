import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/Authrization/Controller/LoginDataController.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
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
        ChangeNotifierProvider(create: (context)=>LoginDataController()),
        ChangeNotifierProvider(create: (context)=>DashboardController()),
        ChangeNotifierProvider(create: (context)=>DealerInfoController()),
        ChangeNotifierProvider(create: (context)=>BeneficiaryInfoController()),
        ChangeNotifierProvider(create: (context)=>MasterApiController()),
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