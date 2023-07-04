import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/styles.dart';
import 'package:flutter/material.dart';

Widget orderPlaceDetails({color,title1,detail1,title2,detail2})
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1,style: const TextStyle(fontFamily: semibold)),
            Row(
              children: [
                Text(detail1,style: const TextStyle(color: Colors.red,fontFamily: bold,fontSize: 16)),
                2.widthBox,
                CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: color != null ? color : Colors.transparent
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title2,style: const TextStyle(fontFamily: semibold)),
            Text(detail2,style: const TextStyle(fontFamily: bold,fontSize: 16)),
          ],
        )
      ],
    ),
  );
}