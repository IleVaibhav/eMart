import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCart({width,String? count,String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('$count',style: TextStyle(fontSize: 24,fontFamily: semibold,color: Colors.grey.shade700)),
      const Divider(thickness: 0.1,color: Colors.grey),
      Text('$title',style: TextStyle(fontSize: 15,fontFamily: semibold,color: Colors.grey.shade700))
    ],
  ).box.white.roundedSM.shadowSm.width(width).height(80).padding(const EdgeInsets.only(left: 7,right: 7,top: 2,bottom: 2)).make();
}