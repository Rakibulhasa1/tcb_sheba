import 'package:flutter/material.dart';

class UserInbox extends StatefulWidget {
  const UserInbox({Key? key}) : super(key: key);

  @override
  _UserInboxState createState() => _UserInboxState();
}

class _UserInboxState extends State<UserInbox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('দুঃখিত!\nএই সেবাটি এখনো চালু হয়নি ',textAlign: TextAlign.center),
    );
  }
}
