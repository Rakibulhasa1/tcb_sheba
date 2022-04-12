import 'package:flutter/material.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_paid_unpaid.dart';

class ReceiveProduct extends StatefulWidget {
  const ReceiveProduct({Key? key}) : super(key: key);

  @override
  _ReceiveProductState createState() => _ReceiveProductState();
}

class _ReceiveProductState extends State<ReceiveProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ধাপ - ১'),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
            child: Text('মোট ২ বার টিসিবি পণ্য গ্রহণ করেছেন'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context,position){
              return Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: FadeInImage(
                            image: NetworkImage(''),
                            height: 70,
                            width: 70,
                            placeholder: const AssetImage("asstes/emptyProfile.jpg"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset('asstes/emptyProfile.jpg', fit: BoxFit.cover);
                            },
                            fit: BoxFit.cover,
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('',style: TextStyle(fontSize: 16),),
                                Text('NID : 12547899665547',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                Text('মোবাইল  01478856985',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                                Text('uzirpur, barishal,satla',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Wrap(
                      runSpacing: 12,
                      spacing: 12,
                      children: [
                        CustomButtonWithPaidUnPaid(
                          title: 'ধাপ - 1',
                          isSelectable: true,
                          onTab: (){

                          },
                        ),
                        CustomButtonWithPaidUnPaid(
                          title: 'ধাপ - 2',
                          isSelectable: false,
                          onTab: (){

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
