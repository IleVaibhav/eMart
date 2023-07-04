import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/orders_screen_profile/order_details.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Text("My Orders ...",style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
      ),

      body: StreamBuilder(
        stream: Firestore_Services.getAllOrders(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          else if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Orders Placed yet ....",style: TextStyle(color: darkFontGrey,fontSize: 20)));
          }
          else {
            var data = snapshot.data!.docs;
            return ListView.builder(
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
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade700,
                      maxRadius: 20,
                      child: CircleAvatar(
                        maxRadius: 19,
                        backgroundColor: Colors.grey.shade200,
                        child: Text("${index+1}",style: TextStyle(color: Colors.grey.shade800,fontSize: 22)),
                      ),
                    ),
                    title: Text(data[index]['order_code'].toString(),style: const TextStyle(color: Colors.red,fontFamily: bold,fontSize: 18)),
                    subtitle: Text("₹${data[index]['total_amount']}",style: TextStyle(color: Colors.grey.shade800,fontFamily: semibold)),
                    trailing: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right,color: Colors.red),
                        onPressed: () {
                          Get.to(() => OrderDetail(data: data[index]));
                        }
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}