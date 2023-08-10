import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {

  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Box")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: MessageModel.messageList.length,
              itemBuilder: (context,position){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context){
                      if(MessageModel.messageList[position].isMe){
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(radius: 16),
                            SizedBox(width: 12),
                            Expanded(
                              child: Container(

                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                  child: Text(MessageModel.messageList[position].message),
                                ),
                              ),
                            ),
                            SizedBox(width: 80),
                          ],
                        );
                      }else{
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 80),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                  child: Text(MessageModel.messageList[position].message),
                                ),

                              ),
                            ),
                            SizedBox(width: 12),
                            CircleAvatar(radius: 16),

                          ],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: (){
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a message...',
                      hintStyle: TextStyle(height: 1.8,fontSize: 12),
                    ),
                    autocorrect: true,
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: messageTextController,
                    onChanged: (value){
                      setState(() {

                      });
                    },
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MessageModel{
  final String message;
  final String dateTime;
  final bool isMe;

  MessageModel({required this.message,required this.dateTime,required this.isMe});


  static List<MessageModel> messageList = [
    MessageModel(message: "Hello", dateTime: "1 min ago", isMe: true),
    MessageModel(message: "HI", dateTime: "1 min ago", isMe: false),
    MessageModel(message: "How are you?", dateTime: "1 min ago", isMe: true),
    MessageModel(message: "I Am fine", dateTime: "1 min ago", isMe: false),
    MessageModel(message: "Thanks", dateTime: "1 min ago", isMe: true),
  ];
}
