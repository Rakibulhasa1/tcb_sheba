import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateBeneficeryCard extends StatefulWidget {
  const CreateBeneficeryCard({Key? key}) : super(key: key);

  @override
  _CreateBeneficeryCardState createState() => _CreateBeneficeryCardState();
}

class _CreateBeneficeryCardState extends State<CreateBeneficeryCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 24,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,)
                ),
                width: 550,
                height: 340,
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('asstes/freedom50.png',height: 50,),
                        Column(
                          children: [
                            Image.asset('asstes/govLogo.png',height: 30,),
                            Text('পরিবার পরিচিতি কার্ড',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                        Image.asset('asstes/mujib100.png',height: 50,),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.network('https://media-exp1.licdn.com/dms/image/C5603AQFQWkZJ2tzc9w/profile-displayphoto-shrink_200_200/0/1641876126491?e=1654128000&v=beta&t=Vopwx3JS6yT9QoBu2t9oKcy_EkEqsRAP8iN6EOqF2Gs',
                                height: 130,
                                width: 130,
                              ),
                              SizedBox(height: 36,),
                              Text('বরিশাল সদর',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
                              Text('উজিরপুর ইউনিয়ন ',style:  TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(width: 24,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('নাম',style: TextStyle(fontSize: 14),),
                              Text('মোঃ আলঙ্গীর বেপারী',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 16,),
                              Text('পরিচয় পত্র নম্বর ',style: TextStyle(fontSize: 14,),),
                              Text('00036256898522',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 16,),
                              Text('পরিবার কার্ড ',style: TextStyle(fontSize: 14),),
                              Text('00036256898522',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 16,),
                              Text('মোবাইল',style: TextStyle(fontSize: 14),),
                              Text('01747744874',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(height: 24,),
                              QrImage(
                                data: "1234567890",
                                version: QrVersions.auto,
                                size: 140.0,
                              ),
                              SizedBox(height: 16,),
                              Text('পেশা \nগার্মেন্টস',textAlign: TextAlign.center,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('জেলা প্রশাসন নারায়নগঞ্জ',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 24,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('Share',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
