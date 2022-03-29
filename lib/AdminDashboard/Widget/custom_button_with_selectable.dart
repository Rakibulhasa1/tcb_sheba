import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tcb/app_theme.dart';

class CustomButtonWithSelectable extends StatelessWidget {

  final String title;
  final bool isSelectable;
  Callback onTab;
  CustomButtonWithSelectable({Key? key,required this.title,required this.isSelectable,required this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isSelectable?primaryColorGreenLite:Colors.grey),
          color: isSelectable?primaryColorGreenLite:Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelectable?Row(
              children: const [
                Icon(Icons.done,color: Colors.white,size: 16,),
                SizedBox(width: 7,),
              ],
            ):Container(),
            Text(title,style: TextStyle(color: isSelectable?Colors.white:Colors.grey[700],fontSize: 12),),
          ],
        ),
      ),
    );
  }
}
