import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_selectable.dart';
import 'package:tcb/BeneficeryDashboard/Widget/google_map_view.dart';
import 'package:tcb/BeneficeryDashboard/Widget/t_c_b_card_with_google_map.dart';
import 'package:tcb/BeneficeryDashboard/Widget/view_nid_card.dart';

class BeneficeryDashboard extends StatefulWidget {
  const BeneficeryDashboard({Key? key}) : super(key: key);

  @override
  _BeneficeryDashboardState createState() => _BeneficeryDashboardState();
}

class _BeneficeryDashboardState extends State<BeneficeryDashboard> {

  int selectableMenu = 0;
  List<String> menuLiar = [
    "টিসিবি কার্ড",
    // "এনআইডি"
  ];

  List<Widget> myWidget = [
    TCBCardWithGoogleMap(),
    ViewNidCard(),
  ];



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 24,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menuLiar.length,
              itemBuilder: (context,position){
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: selectableMenu==position?Colors.indigoAccent:Colors.grey[300],
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: (){
                        setState(() {
                          selectableMenu = position;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,

                        child: Text(menuLiar[position],style: TextStyle(color: selectableMenu==position?Colors.white:Colors.black,fontWeight: FontWeight.bold,fontSize: 12)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 24,),
        Builder(
          builder: (context){
            return myWidget[selectableMenu];
          },
        ),
      ],
    );
  }
}
