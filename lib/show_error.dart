import 'package:flutter/material.dart';

class ShowError extends StatefulWidget {
  final String errorMessage;
  const ShowError({Key? key,required this.errorMessage}) : super(key: key);

  @override
  _ShowErrorState createState() => _ShowErrorState();
}

class _ShowErrorState extends State<ShowError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Text(widget.errorMessage,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[600]),textAlign: TextAlign.center,),
      ),
    );
  }
}
