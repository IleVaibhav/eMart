import 'package:flutter/material.dart';

Widget normalText({text,color = Colors.white,size = 14})
{
  return Text(text,style: TextStyle(color: color,fontSize: size.toDouble()));
}

Widget boldText({text,color = Colors.white,size = 14})
{
  return Text(text,style: TextStyle(color: color,fontWeight: FontWeight.w600,fontSize: size.toDouble()));
}