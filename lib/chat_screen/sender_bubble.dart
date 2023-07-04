import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

Widget SenderBubble(DocumentSnapshot data) {

  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  var date = intl.DateFormat("yMMMMd").format(t);

  return Container(
    padding: const EdgeInsets.all(8),
    margin: data['uid'] == currentUser!.uid ? const EdgeInsets.only(top: 5,left: 50) : const EdgeInsets.only(top: 5,right: 50),
    decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? Colors.red : Colors.grey.shade400,
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: data['uid'] == currentUser!.uid ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight: data['uid'] == currentUser!.uid ? const Radius.circular(0) : const Radius.circular(15)
          )
    ),

    child: Column(
      crossAxisAlignment: data['uid'] == currentUser!.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text("${data['msg']}",style: const TextStyle(color: Colors.black,fontSize: 15)),
        5.heightBox,
        Text("$date $time",style: TextStyle(color: Colors.grey.shade700,fontSize: 10))
      ],
    ),

  );
}