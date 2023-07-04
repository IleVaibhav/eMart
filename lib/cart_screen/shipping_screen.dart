import 'package:e_commerce_user/cart_screen/payment.dart';
import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/common_widgets/textfield_custom.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        title: const Text('Shipping Info ...',style: TextStyle(fontFamily: semibold,color: Colors.grey)),
      ),

      bottomNavigationBar: Row(
        children: [
          5.widthBox,
          SizedBox(
            width: context.screenWidth-10,
            child: customButton(
              onPress: (){
                if(controller.addressController.text.length < 10 || controller.pincodeController.text.length != 6 || controller.phoneController.text.length != 10)
                {
                  VxToast.show(context, msg: "Please enter correct inputs ...");
                }
                else
                {
                  Get.to(() => PaymentMethod());
                }
              },
              color: Colors.red,
              textColor: Colors.white,
              title: 'Continue ...'
            ),
          ),
          5.widthBox
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            customTextField(hint: "Enter Address here ...",isPass: false,title: "Address",controller: controller.addressController),
            10.heightBox,
            customTextField(hint: "Enter City here ...",isPass: false,title: "City",controller: controller.cityController),
            10.heightBox,
            customTextField(hint: "Enter State here ...",isPass: false,title: "State",controller: controller.stateController),
            10.heightBox,
            customTextField(hint: "Enter Pin Code here ...",isPass: false,title: "Pin Code",controller: controller.pincodeController),
            10.heightBox,
            customTextField(hint: "Enter Phone number here ...",isPass: false,title: "Phone Number :",controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}