import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/common_widget/appbar.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/firebase_const.dart';
import 'package:e_commerce_admin/controllers/orders_controller.dart';
import 'package:e_commerce_admin/orders/order_detail.dart';
import 'package:e_commerce_admin/services/store_services.dart';
import 'package:get/get.dart';
import '../common_widget/text_widget.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(OrderController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: appBar(title: orders),

      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          else {
            var ordersData = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                      ordersData.length,
                      (index) {
                        var time = ordersData[index]['order_date'].toDate();
                        return ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            tileColor: Colors.grey.shade200,
                            title: boldText(text: ordersData[index]['order_code'],color: purpleColor,size: 16).paddingOnly(bottom: 5),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,color: darkGrey,size: 20),
                                    10.widthBox,
                                    boldText(text: intl.DateFormat().add_yMd().format(time).toString(),color: darkGrey,size: 15),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.payments_outlined,color: darkGrey,size: 20),
                                    10.widthBox,
                                    boldText(text: "Unpaid",color: Colors.red.shade700,size: 15),
                                  ],
                                )
                              ],
                            ),
                            trailing: boldText(text: "₹${ordersData[index]['total_amount']}",color: purpleColor,size: 16),
                            onTap: () => Get.to(() => OrderDetail(data: ordersData[index]))
                        ).box.margin(const EdgeInsets.only(bottom: 5)).make();
                      }
                  ),
                ),
              ),
            );
          }
        },

      ),
    );
  }
}