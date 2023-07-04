import 'package:e_commerce_admin/common_widget/custom_textfield.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/controllers/navigation_controller.dart';
import 'package:e_commerce_admin/controllers/products_controller.dart';
import 'package:get/get.dart';

import 'product_dropdown.dart';
import 'product_imgs.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NavController());
    var controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        elevation: 1,
        title: boldText(text: "Add Product",size: 18),
        actions: [
          Obx(
            () => controller.isLoading.value
                  ? Row(
                      children: [
                        Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                        20.widthBox
                      ],
                  )
                  : TextButton(
                        onPressed: () async {
                          controller.isLoading(true);
                          await controller.uploadImages();
                          await controller.uploadProduct(context);
                          Get.back();
                          controller.isLoading(false);
                        },
                        child: boldText(text: "Add")
                  )
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.heightBox,
            customTextField(hint: "eg. McLaren",label: "Product name",isDesc: false,controller: controller.pNameController),
            10.heightBox,
            customTextField(hint: "Enter Product desc here . . .",label: "Description",isDesc: true,controller: controller.pDescController),
            10.heightBox,
            customTextField(hint: "eg. ₹1000",label: "Price",isDesc: false,controller: controller.pPriceController),
            10.heightBox,
            customTextField(hint: "50",label: "Quantity",isDesc: false,controller: controller.pQuantityController),
            10.heightBox,
            productDropDown("Category",controller.categoryList,controller.categoryValue,controller),
            10.heightBox,
            productDropDown("Sub Category",controller.subcategoryList, controller.subCategoryValue,controller),
            const Divider(color: Colors.white,thickness: 0.5),
            boldText(text: "Choose Product Images"),
            5.heightBox,
            Obx(
                () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImgsList[index] != null
                            ? Image.file(controller.pImgsList[index],width: 100,height: 100,fit: BoxFit.cover).onTap(() {controller.pickImage(index, context);})
                            : productimages(label: index+1).onTap(() {
                          controller.pickImage(index, context);
                        })
                    )
                )
            ),
            5.heightBox,
            normalText(text: "First image will be your display image",size: 12,color: lightGrey).box.makeCentered(),
            const Divider(color: Colors.white,thickness: 0.5),
            boldText(text: "Choose Product Colours"),
            5.heightBox,
            Obx(
                () => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        10,
                            (index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            VxBox().color(Vx.randomPrimaryColor).roundedFull.size(50, 50).make().onTap(() {
                              controller.selectedColorIndex.value = index;
                            }),
                            controller.selectedColorIndex.value == index ?
                            const Icon(Icons.done,color: Colors.white)
                                : SizedBox()
                          ],
                        )
                    )
                )
            ),
          ],
        ).paddingAll(10),
      ),
    );
  }
}
