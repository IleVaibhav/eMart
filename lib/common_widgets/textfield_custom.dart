import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField({String? title,String? hint,controller,isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$title',
        style: TextStyle(
            color: Colors.red,
            fontFamily: bold,
            fontSize: 18
        )
      ),

      5.heightBox,

      TextFormField(
        obscureText: isPass,
        obscuringCharacter: '*',
        controller: controller,
        decoration: InputDecoration(
          hintText: '$hint',
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: Colors.white,
          ),
          isDense: true,
          fillColor: Colors.grey.shade300,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          )
        ),
      ).box.customRounded(BorderRadiusDirectional.circular(5)).clip(Clip.antiAlias).make(),

    ],
  );
}