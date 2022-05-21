import 'package:flutter/material.dart';
import 'package:tcb/AdminDashboard/Widget/custom_button_with_paid_unpaid.dart';
import 'package:tcb/ApiConfig/ApiEndPoints.dart';
import 'package:tcb/Model/ListOfUser.dart';

class BeneficaryUserTile extends StatefulWidget {
  final BeneficiaryData beneficiaryData;
  final bool isReceived;
  const BeneficaryUserTile({Key? key,required this.beneficiaryData,required this.isReceived}) : super(key: key);

  @override
  _BeneficaryUserTileState createState() => _BeneficaryUserTileState();
}

class _BeneficaryUserTileState extends State<BeneficaryUserTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
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
                  image: NetworkImage('${ApiEndPoints().imageBaseUrl}${widget.beneficiaryData.beneficiaryImageFile}'),
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
                      Text(widget.beneficiaryData.beneficiaryNameBangla,style: TextStyle(fontSize: 16),),
                      Text('NID : ${widget.beneficiaryData.nidNumber}',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                      Text('মোবাইল  ${widget.beneficiaryData.beneficiaryMobile}',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                      Text('${widget.beneficiaryData.upazilaNameBangla}, ${widget.beneficiaryData.unionNameBangla}, ${widget.beneficiaryData.wordNameBangla}',style: TextStyle(fontSize: 12,color: Colors.grey[700]),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //SizedBox(height: 12,),
          // widget.isReceived?Wrap(
          //   runSpacing: 12,
          //   spacing: 12,
          //   children: [
          //     CustomButtonWithPaidUnPaid(
          //       title: 'ধাপ - 1',
          //       isSelectable: true,
          //       onTab: (){
          //
          //       },
          //     ),
          //     CustomButtonWithPaidUnPaid(
          //       title: 'ধাপ - 2',
          //       isSelectable: false,
          //       onTab: (){
          //
          //       },
          //     ),
          //   ],
          // ):Container(),
        ],
      ),
    );
  }
}
