import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/chat_screen/sender_bubble.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/controller/chat_controller.dart';
import 'package:e_commerce_user/controller/home_controller.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Get.put(HomeController());
    Get.lazyPut(()=>HomeController());
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        title: Text("${controller.friendName}",style: TextStyle(fontFamily: semibold,color: Colors.grey.shade800)),
      ),


      bottomSheet: Row(
        children: [
          Expanded(
              child: TextFormField(
                controller: controller.msgController,
                decoration: const InputDecoration(
                  hintText: "Type message here ...",
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
              )
          ),
          IconButton(
              onPressed: () {
                controller.sendMsg(controller.msgController.text);
                controller.msgController.clear();
              },
              icon: const Icon(Icons.send,color: Colors.red)
          )
        ],
      ).box.height(70).color(Colors.grey.shade200).padding(const EdgeInsets.only(bottom: 5,right: 5,left: 5,top: 0)).make(),

      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
            children: [
              Obx(
                () => controller.isLoading.value ?
                    const Center(
                        child: CircularProgressIndicator(color: Colors.red)
                    )
                    : Expanded(
                      child: StreamBuilder(
                        stream: Firestore_Services.getChatMSG(controller.chatDocID.toString()),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.red)
                            );
                          }
                          else if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text("Send a msg ... ",style: TextStyle(color: darkFontGrey))
                            );
                          }
                          else {
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                  alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                                  child: SenderBubble(data)
                                );
                              }).toList(),
                            );
                          }
                        },
                      )
                    ),
              ),
              70.heightBox,
              // Row(
              //   children: [
              //     Expanded(
              //         child: TextFormField(
              //           controller: controller.msgController,
              //           decoration: const InputDecoration(
              //             hintText: "Type message here ...",
              //             border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              //             focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              //           ),
              //         )
              //     ),
              //     5.widthBox,
              //     IconButton(
              //         onPressed: () {
              //           controller.sendMsg(controller.msgController.text);
              //           controller.msgController.clear();
              //         },
              //         icon: const Icon(Icons.send,color: Colors.red)
              //     )
              //   ],
              // ).box.height(60).padding(const EdgeInsets.all(2)).make(),
            ],
          ),
      ),

    );
  }
  
}