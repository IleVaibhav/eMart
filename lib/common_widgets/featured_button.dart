import 'package:e_commerce_user/category_screen/category_details.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title,icon}) {
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      Text('$title',style: TextStyle(fontFamily: semibold,color: Colors.grey),)
    ],
  ).box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 2))
      .white
      .roundedSM
      .outerShadowSm
      .padding(EdgeInsets.all(2))
      .make()
      .onTap(() {Get.to(() => CategoryDetails(title: title.toString()));});
}