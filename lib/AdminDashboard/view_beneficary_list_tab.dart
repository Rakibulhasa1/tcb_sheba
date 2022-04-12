import 'package:flutter/material.dart';
import 'package:tcb/AdminDashboard/beneficary_list_view.dart';
import 'package:tcb/AdminDashboard/list_of_beneficiry_query.dart';
import 'package:tcb/AdminDashboard/list_of_receive_beneficiry_query.dart';

class ViewBeneficaryListTab extends StatefulWidget {
  final bool isCity;
  final String wordId;
  const ViewBeneficaryListTab({Key? key,required this.wordId,required this.isCity}) : super(key: key);

  @override
  _ViewBeneficaryListTabState createState() => _ViewBeneficaryListTabState();
}

class _ViewBeneficaryListTabState extends State<ViewBeneficaryListTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beneficiary'),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 6,
            tabs: [
              Tab(text: 'নিবন্ধিত উপকারভোগী',),
              Tab(text: 'সুবিধাপ্রাপ্ত উপকারভোগী',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListOfBeneficiryQuery(wordId: widget.wordId,isCity: widget.isCity),
            ListOfReceiveBeneficiryQuery(wordId: widget.wordId,isCity: widget.isCity),
          ],
        ),
      ),
    );
  }
}
