import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/BeneficiaryInfoController.dart';
import 'package:tcb/AdminDashboard/Controller/DialogDataController.dart';
import 'package:tcb/AdminDashboard/Controller/PramsController.dart';
import 'package:tcb/AdminDashboard/Controller/dealer_data_controller.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';
import 'package:tcb/Controller/UserInfoController.dart';
import 'package:tcb/MasterApiController.dart';
import 'package:tcb/password_reset.dart';
import 'package:tcb/splash_screen.dart';
import 'package:tcb/success_screen.dart';

import 'Controller/network_controller.dart';
import 'app_scaffold.dart';
import 'network_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final networkStatus = NetworkStatus();
  final initialConnectivity = await networkStatus.initialStatus();
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
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Upokari',
          theme: ThemeData(
              appBarTheme: const AppBarTheme(backgroundColor: Colors.green, elevation: 0.0,),
          ),
          home: SplashScreen(

          ),

            routes: {

              "/successScreen": (context) => SuccessScreen(),
              "/SecuResetPassword": (context) => SecuResetPassword(),

            }
        ),
      ),
    );
  }
}
