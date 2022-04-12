import 'package:flutter/material.dart';
import 'package:tcb/BeneficeryDashboard/Widget/google_map_view.dart';

class ViewMapInFullScreen extends StatelessWidget {
  const ViewMapInFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google map')),
      body: GoogleMapView(),
    );
  }
}
