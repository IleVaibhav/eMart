import 'package:e_commerce_admin/const/const.dart';
import 'package:get/get.dart';
import 'text_widget.dart';

Widget dashBoardButton(context,{title,count,icon})
{
  var size = MediaQuery.of(context).size;

  return Row(
    children: [
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              boldText(text: title,size: 16,color: purpleColor),
              const Divider(color: purpleColor,thickness: 0.1,height: 5).box.makeCentered().paddingOnly(left: 10,right: 15),
              boldText(text: count,size: 25,color: purpleColor)
            ],
          )
      ),
      Image.asset(icon,width: 40,color: purpleColor),
      10.widthBox
    ],
  ).box.color(Colors.grey.shade200).rounded.size(size.width*0.45, size.width*0.2).padding(const EdgeInsets.all(10)).make();
}