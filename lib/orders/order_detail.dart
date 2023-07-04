import 'package:e_commerce_admin/common_widget/buttons.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/controllers/orders_controller.dart';
import 'package:e_commerce_admin/orders/order_place.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class OrderDetail extends StatefulWidget {
  final dynamic data;
  const OrderDetail({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  var controller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade200,
            elevation: 1,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_outlined,color: purpleColor)
            ),
            title: boldText(text: "Order Code",color: purpleColor,size: 18),
          ),

          bottomNavigationBar: Visibility(
            visible: !controller.confirmed.value,
            child: SizedBox(
              height: 50,
              width: context.width*0.95,
              child: ourButton(
                  title: "Confirm Order",
                  color: green,
                  onPress: () {
                    controller.confirmed(true);
                    controller.changeStatus(title: "order_confirmed",status: true,docID: widget.data.id);
                  }
              ).paddingAll(5),
            ),
          ),

          body: Padding(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: controller.confirmed.value,
                      child: Column(
                        children: [
                          10.heightBox,
                          boldText(text: "Order Status",color: purpleColor,size: 18),
                          SwitchListTile(
                            value: true,
                            activeColor: Colors.green,
                            onChanged: (value) {},
                            title: boldText(text: "Placed",color: purpleColor,size: 16),
                          ),
                          SwitchListTile(
                            value: controller.confirmed.value,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              controller.confirmed.value = value;
                            },
                            title: boldText(text: "Confirm",color: purpleColor,size: 16),
                          ),
                          SwitchListTile(
                            value: controller.ondelivery.value,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              controller.ondelivery.value = value;
                              controller.changeStatus(title: "order_on_delivery",status: value,docID: widget.data.id);
                            },
                            title: boldText(text: "On Delivery",color: purpleColor,size: 16),
                          ),
                          SwitchListTile(
                            value: controller.delivered.value,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              controller.delivered.value = value;
                              controller.changeStatus(title: "order_delivered",status: value,docID: widget.data.id);
                            },
                            title: boldText(text: "Delivered",color: purpleColor,size: 16),
                          )
                        ],
                      )
                  ),

                  10.heightBox,
                  const Divider(thickness: 1,color: Colors.grey,height: 1),
                  1.heightBox,
                  const Divider(thickness: 1,color: Colors.grey,height: 1),
                  10.heightBox,

                  orderPlaceDetails(
                      color: null,
                      title1: "Order Code :",
                      detail1: widget.data['order_code'],
                      title2: "Shipping Method :",
                      detail2: widget.data['shipping_method']
                  ),

                  orderPlaceDetails(
                      color: null,
                      title1: "Order Date :",
                      detail1: intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate())),
                      title2: "Payment Method :",
                      detail2: widget.data['payment_method']
                  ),

                  orderPlaceDetails(
                      color: null,
                      title1: "Payment Status :",
                      detail1: "Unpaid",
                      title2: "Delivery Status :",
                      detail2: "Order Placed"
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Shipping Address :",style: TextStyle(color: purpleColor,fontWeight: FontWeight.bold,fontSize: 16)),
                                Text("Name : ${widget.data['order_by_name']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("E-mail : ${widget.data['order_by_email']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("Address : ${widget.data['order_by_address']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("City : ${widget.data['order_by_city']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("State : ${widget.data['order_by_state']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("Contact : ${widget.data['order_by_phone']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("PIN Code : ${widget.data['order_by_pin']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text("State : ${widget.data['order_by_state']}",style: const TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Total Amount :",style: TextStyle(color: purpleColor,fontWeight: FontWeight.w500)),
                            Text("₹${widget.data['total_amount']}",style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16)),
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

                  const Text("Ordered Product",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  2.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        controller.orders.length,
                            (index) => orderPlaceDetails(
                            color: Color(controller.orders[index]['color']),
                            title1: "${controller.orders[index]['title']}",
                            detail1: "${controller.orders[index]['qty']} x",
                            title2: "Total : ₹${controller.orders[index]['tprice']}",
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
            ),
          ),
        )
    );
  }
}
