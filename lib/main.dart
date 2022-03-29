import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tcb/Authrization/Controller/LoginDataController.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/splash_screen.dart';

void main()async {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TCB',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.green, elevation: 0.0,),
        ),
        home: SplashScreen(),
      ),
    );
  }
}