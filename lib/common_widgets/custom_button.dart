import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customButton({onPress,color,textColor,title})
{
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(10)
      ),

      onPressed: onPress,

      child: Text(
          '$title',
          style: TextStyle(
              color: textColor,
              fontFamily: bold
          )
      )
  );
}

