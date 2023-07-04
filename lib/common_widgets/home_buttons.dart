import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';

Widget HomeButton({width,height,icon,title,onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 50),
      15.heightBox,
      Text('$title',style: TextStyle(fontFamily: semibold,color: Colors.grey))
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}