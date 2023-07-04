import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/cart_screen/shipping_screen.dart';
import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/controller/cart_controller.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: Text("Your Cart",style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),

      body: StreamBuilder(
        stream: Firestore_Services.getCartItem(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red,)//Text("Cart is Empty",style: TextStyle(fontFamily: semibold)),
            );
          }
          else if(snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("Cart is EMPTY",style: TextStyle(color: Colors.grey.shade600,fontFamily: semibold,fontSize: 18)),
            );
          }
          else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            tileColor: Colors.grey.shade200,
                            leading: Image.network(data[index]['img'],width: 90,fit: BoxFit.fitWidth),
                            title: Text("${data[index]['title']} (x${data[index]['qty']})",style: const TextStyle(fontFamily: semibold,fontSize: 16)),
                            subtitle: Text("₹${data[index]['t_price']}",style: const TextStyle(fontSize: 14,color: Colors.red)),
                            trailing: const Icon(Icons.delete,color: Colors.red).onTap(() {Firestore_Services.deleteDocument(data[index].id);}),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price : ",style: TextStyle(fontFamily: semibold,color: Colors.grey.shade700,fontSize: 15)),
                      Obx(() => Text("₹${controller.totalPrice.value}",style: const TextStyle(fontFamily: semibold,color: Colors.red,fontSize: 15)))
                    ],
                  ).box.width(context.screenWidth-20).padding(const EdgeInsets.all(10)).color(Colors.amber.shade50).make(),
                  1.heightBox,
                  SizedBox(
                      width: context.screenWidth-20,
                      child: customButton(
                          color: Colors.red,
                          title: "Proceed to Shipping",
                          textColor: Colors.white,
                          onPress: (){Get.to(() => const ShippingDetails());}
                      )
                  ),
                ],
              ),
            );
          }
        }
      )

    );
  }
}