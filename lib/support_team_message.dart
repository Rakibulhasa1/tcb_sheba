import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcb/ApiConfig/ApiController.dart';
import 'package:tcb/ApiConfig/api_response.dart';
import 'package:tcb/show_toast.dart';

class SupportTeamMessage extends StatefulWidget {
  const SupportTeamMessage({Key? key}) : super(key: key);

  @override
  _SupportTeamMessageState createState() => _SupportTeamMessageState();
}

class _SupportTeamMessageState extends State<SupportTeamMessage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("আমাকে বলুন")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              child: TextField(
                textAlign: TextAlign.start,
                cursorColor: Colors.black,
                keyboardType: TextInputType.name,
                autofocus: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                style: const TextStyle(height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                decoration: const InputDecoration(
                    hintStyle: TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                    hintText: "টাইটেল",
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12)
                ),
                maxLines: 1,
                controller: titleController,
              ),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              child: TextField(
                textAlign: TextAlign.start,
                cursorColor: Colors.black,
                keyboardType: TextInputType.name,
                autofocus: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                style: const TextStyle(height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(height: 0.8,fontSize: 16,fontWeight: FontWeight.w300),
                  hintText: "বিবরণ",
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                maxLines: 6,
                controller: detailsController,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          var body = {
            "title" : titleController.text,
            "details" : detailsController.text,
          };
          ApiController().postRequest(endPoint: "send_feedback",body: body).then((value){
            if(value.responseCode==200){
              ShowToast.myToast("Send Successful", Colors.black, 2);
              titleController.clear();
              detailsController.clear();
            }else{
              ShowToast.myToast("Something is wrong", Colors.black, 2);
            }
          });
        },
        label: Row(
          children: [
            Icon(Icons.send),
            SizedBox(width: 12),
            Text("Send"),
          ],
        ),
      ),
    );
  }
}
