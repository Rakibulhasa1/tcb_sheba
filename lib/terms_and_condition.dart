import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcb/HelperClass.dart';
import 'package:tcb/MasterApiController.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
      ),
      body: Consumer<MasterApiController>(
        builder: (context,data,child) {
          return ListView(
            children: [
              Container(
                color: Colors.green,
                alignment: Alignment.center,
                height: 200,
                child: const Text('Terms And Condition\nPolicy Context',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
              ),
              SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Terms And Condition',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(data.masterData!.temsCondition.length<50?HelperClass().terms:'${data.masterData!.temsCondition}'),
              ),
              SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Policy Context',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(data.masterData!.policyContext.length<50?'':'${data.masterData!.policyContext}'),
              ),
            ],
          );
        }
      ),
    );
  }
}
