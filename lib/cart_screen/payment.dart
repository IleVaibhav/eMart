import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/consts/lists.dart';
import 'package:e_commerce_user/consts/styles.dart';
import 'package:e_commerce_user/controller/cart_controller.dart';
import 'package:e_commerce_user/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        title: const Text('Payment ...',style: TextStyle(fontFamily: semibold,color: Colors.grey)),
      ),

      bottomNavigationBar: Obx(
        () => Row(
          children: [
            5.widthBox,
            SizedBox(
              width: context.screenWidth-10,
              child: controller.placingOrder.value
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
                : customButton(
                    onPress: () async {
                      await controller.PlaceMyOrder(
                        order_payment_method: PaymentMethodList[controller.paymentIndex.value],
                        totalPrice: controller.totalPrice.value
                      );
                      await controller.clearCart();
                      VxToast.show(context, msg: "Your Order Placed Successfully ... ");
                      Get.offAll(() => const Home());
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    title: 'Place Order ...'
                  ),
            ),
            5.widthBox
          ],
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
              () => Column(
              children: List.generate(
                  PaymentMethodList.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.changePaymentIndex(index);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // border: Border.all(
                            //   color: controller.paymentIndex.value == index ? Colors.grey.shade700 : Colors.transparent,
                            //   width: 2,
                            // )
                        ),
                        child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.asset(
                                  PaymentMethodListIMG[index],
                                  height: 150,
                                  width: context.screenWidth-10,
                                  fit: BoxFit.fitWidth,
                                  colorBlendMode: controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                                  color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.2) : Colors.transparent,
                              ),
                              controller.paymentIndex.value == index ? Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                    activeColor: Colors.green.shade700,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    value: true,
                                    onChanged: (value) {}
                                ),
                              ) : Container(),
                              Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: Text(
                                    "${PaymentMethodList[index]}",
                                    style: TextStyle(color: controller.paymentIndex.value == index ? Colors.black : Colors.grey.shade800,fontFamily: semibold,fontSize: 15),
                                  )
                              )
                            ]
                        ),
                      ),
                    );
                  }
              )
            ),
          ),
        ),
      )

    );
  }
}