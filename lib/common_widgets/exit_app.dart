import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Confirm",style: TextStyle(fontFamily: bold,fontSize: 18,color: Colors.grey.shade800)),
        const Divider(),
        Text("Do you want to EXIT application",style: TextStyle(fontFamily: semibold,fontSize: 16,color: Colors.grey.shade700)),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customButton(color: Colors.red,title: 'Yes',onPress: (){SystemNavigator.pop();},textColor: Colors.white),
            customButton(color: Colors.red,title: 'No',onPress: (){Navigator.pop(context);},textColor: Colors.white)
          ],
        )
      ],
    ).box.rounded.color(Colors.grey.shade200).padding(EdgeInsets.all(15)).make(),
  );
}