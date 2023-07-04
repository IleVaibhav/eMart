import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget applogoWidget() {
  //using velocity_x
  return Image.asset(icAppLogo).box.white.size(80, 80).padding(const EdgeInsets.all(10)).rounded.make();
}