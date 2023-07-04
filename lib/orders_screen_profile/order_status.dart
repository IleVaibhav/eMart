import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon,color,title,showDone}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
    leading: Icon(icon,color: color).box.size(35, 35).border(color: color).roundedSM.make(),
    title: Column(
      children: const [Divider(color: Colors.grey,thickness: 1)],
    ),
    trailing: SizedBox(
      height: 30,
      width: title.toString().length.toDouble() * 10 + 30 - (showDone ? 0 : 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title,style: const TextStyle(color: darkFontGrey,fontSize: 16,fontFamily: bold)),
          10.widthBox,
          showDone ? const Icon(Icons.done_all,color: Colors.red) : Container(),
          2.widthBox,
        ],
      ),
    ),
  );
}