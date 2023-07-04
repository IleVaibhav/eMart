import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/chat_screen/chat_screen.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MsgScreen extends StatelessWidget {
  const MsgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Text("My Messages ...",style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
      ),

      body: StreamBuilder(
        stream: Firestore_Services.getAllMsg(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          else if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Messages yet ....",style: TextStyle(color: darkFontGrey,fontSize: 20)));
          }
          else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                          child: ListTile(
                            tileColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            leading: const Icon(Icons.account_circle,color: Colors.red,size: 40),
                            title: Text(data[index]['friend_name'],style: const TextStyle(fontFamily: bold,fontSize: 18)),
                            subtitle: Text("${data[index]['last_msg']}",style: TextStyle(color: Colors.grey.shade800)),
                            onTap: () {
                              Get.to(
                                      () => const ChatScreen(),
                                      arguments: [data[index]['friend_name'],data[index]['toID']]
                              );
                            },
                          ),
                        );
                      },
                    )
                )
              ],
            );
          }
        },
      ),
    );
  }
}