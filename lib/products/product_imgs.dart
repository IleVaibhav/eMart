import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';

Widget productimages({required label, onPress})
{
  return Text(label.toString(),style: TextStyle(color: fontGrey,fontSize: 16)).box.makeCentered().box.roundedSM.color(lightGrey).size(100, 100).make();
}