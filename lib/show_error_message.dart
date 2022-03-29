import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('সুবিধা গ্রহণ কারীর ডাটা খুঁজে পাওয়া যায়নি',style: TextStyle(fontSize: 18,color: Colors.grey),),
    );
  }
}
