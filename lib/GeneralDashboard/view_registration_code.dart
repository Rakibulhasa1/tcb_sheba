import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/AdminDashboard/Controller/DashboardController.dart';

class ViewRegistrationCode extends StatefulWidget {

  final String otp;

  const ViewRegistrationCode({Key? key,required this.otp}) : super(key: key);

  @override
  _ViewRegistrationCodeState createState() => _ViewRegistrationCodeState();
}

class _ViewRegistrationCodeState extends State<ViewRegistrationCode> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value){
      Provider.of<DashboardController>(context,listen: false).getDashboardData(prams: '?start=${DateTime(2022,03,01)}&end=${DateTime.now()}');
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green,),

                      ),
                      child: Text(widget.otp=='-'?'-':widget.otp[0],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green,),

                      ),
                      child: Text(widget.otp=='-'?'-':widget.otp[1],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green,),

                      ),
                      child: Text(widget.otp=='-'?'-':widget.otp[2],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green,),

                      ),
                      child: Text(widget.otp=='-'?'-':widget.otp[3],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Icon(Icons.check_circle,size: 62,color: Colors.green,),
                SizedBox(height: 20,),
                Text('পণ্য প্রদান কার্যক্রম সফলভাবে সম্পন্ন হয়েছে',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                SizedBox(height: 100,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.withOpacity(0.5),
                    elevation : 0.0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32,vertical: 10),
                        child: Text('শেষ করুন',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                    ),

                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
