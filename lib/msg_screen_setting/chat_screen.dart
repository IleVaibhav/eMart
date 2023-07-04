// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_admin/common_widget/text_widget.dart';
// import 'package:e_commerce_admin/const/const.dart';
// import 'package:e_commerce_admin/const/firebase_const.dart';
// import 'package:e_commerce_admin/services/store_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'sender_bubble.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     // Get.put(HomeController());
//     Get.lazyPut(()=>HomeController());
//     var controller = Get.put(ChatController());
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.grey.shade200,
//         elevation: 0,
//         title: normalText(text: "${controller.friendName}",color: Colors.grey.shade800),
//       ),
//
//
//       bottomSheet: Row(
//         children: [
//           Expanded(
//               child: TextFormField(
//                 controller: controller.msgController,
//                 decoration: const InputDecoration(
//                   hintText: "Type message here ...",
//                   border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                 ),
//               )
//           ),
//           IconButton(
//               onPressed: () {
//                 controller.sendMsg(controller.msgController.text);
//                 controller.msgController.clear();
//               },
//               icon: const Icon(Icons.send,color: Colors.red)
//           )
//         ],
//       ).box.height(70).color(Colors.grey.shade200).padding(const EdgeInsets.only(bottom: 5,right: 5,left: 5,top: 0)).make(),
//
//       body: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           children: [
//             Obx(
//                   () => controller.isLoading.value ?
//               const Center(
//                   child: CircularProgressIndicator(color: Colors.red)
//               )
//                   : Expanded(
//                   child: StreamBuilder(
//                     stream: StoreServices.getMessages(controller.chatDocID.toString()),
//                     builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if(!snapshot.hasData) {
//                         return const Center(
//                             child: CircularProgressIndicator(color: Colors.red)
//                         );
//                       }
//                       else if (snapshot.data!.docs.isEmpty) {
//                         return Center(
//                             child: boldText(text: "Send a msg ... ",color: fontGrey),
//                         );
//                       }
//                       else {
//                         return ListView(
//                           children: snapshot.data!.docs.mapIndexed((currentValue, index) {
//                             var data = snapshot.data!.docs[index];
//                             return Align(
//                                 alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
//                                 child: SenderBubble(data)
//                             );
//                           }).toList(),
//                         );
//                       }
//                     },
//                   )
//               ),
//             ),
//             70.heightBox,
//           ],
//         ),
//       ),
//
//     );
//   }
//
// }