import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/orders_screen_profile/order_place_details.dart';
import 'package:e_commerce_user/orders_screen_profile/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetail extends StatelessWidget {
  final dynamic data;
  const OrderDetail({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: Text("Order Details",style: TextStyle(color: Colors.grey.shade700)),
      ),


      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //Order Status
              orderStatus(
                  color: Colors.red.shade700,
                  icon: Icons.shopping_bag_rounded,
                  title: "Placed",
                  showDone: data['order_placed']
              ),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed']
              ),
              orderStatus(
                  color: Colors.orange.shade500,
                  icon: Icons.delivery_dining_outlined,
                  title: "On Delivery",
                  showDone: data['order_on_delivery']
              ),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all,
                  title: "Delivered",
                  showDone: data['order_delivered']
              ),

              10.heightBox,
              const Divider(thickness: 1,color: Colors.grey,height: 1),
              1.heightBox,
              const Divider(thickness: 1,color: Colors.grey,height: 1),
              10.heightBox,

              orderPlaceDetails(color: null,title1: "Order Code :",detail1: data['order_code'],title2: "Shipping Method :",detail2: data['shipping_method']),

              orderPlaceDetails(color: null,title1: "Order Date :",detail1: intl.DateFormat("EEEEEEEEE, MMM d, yyyy").format(data['order_date'].toDate()),title2: "Payment Method :",detail2: data['payment_method']),

              orderPlaceDetails(color: null,title1: "Payment Status :",detail1: "Unpaid",title2: "Delivery Status :",detail2: "Order Placed"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Shipping Address :",style: TextStyle(fontFamily: bold,fontSize: 16)),
                        Text("Name : ${data['order_by_name']}",style: const TextStyle(fontFamily: semibold)),
                        Text("E-mail : ${data['order_by_email']}",style: const TextStyle(fontFamily: semibold)),
                        Text("Address : ${data['order_by_address']}",style: const TextStyle(fontFamily: semibold)),
                        Text("City : ${data['order_by_city']}",style: const TextStyle(fontFamily: semibold)),
                        Text("State : ${data['order_by_state']}",style: const TextStyle(fontFamily: semibold)),
                        Text("Contact : ${data['order_by_phone']}",style: const TextStyle(fontFamily: semibold)),
                        Text("PIN Code : ${data['order_by_pin']}",style: const TextStyle(fontFamily: semibold)),
                        Text("State : ${data['order_by_state']}",style: const TextStyle(fontFamily: semibold)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Total Amount :",style: TextStyle(fontFamily: semibold)),
                        Text("₹${data['total_amount']}",style: const TextStyle(color: Colors.red,fontFamily: bold,fontSize: 16)),
                        const Text(""),
                      ],
                    )
                  ],
                ),
              ),

              10.heightBox,
              const Divider(thickness: 1,color: Colors.grey,height: 1),
              1.heightBox,
              const Divider(thickness: 1,color: Colors.grey,height: 1),
              10.heightBox,

              const Text("Ordered Product",style: TextStyle(fontSize: 18,fontFamily: bold)),
              2.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                    data['orders'].length,
                        (index) => orderPlaceDetails(
                        color: Color(data['orders'][index]['color']),
                        title1: data['orders'][index]['title'],
                        detail1: "${data['orders'][index]['qty']} x",
                        title2: "Total : ₹${data['orders'][index]['tprice']}",
                        detail2: "Refundable"
                    )
                ),
              ),

              10.heightBox,
              const Divider(thickness: 1,color: Colors.grey,height: 1),
              1.heightBox,
              const Divider(thickness: 1,color: Colors.grey,height: 1)
            ],
          ),
        )
      ),
    );
  }
}
