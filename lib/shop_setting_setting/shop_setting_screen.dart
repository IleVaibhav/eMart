import 'package:e_commerce_admin/common_widget/custom_textfield.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../const/const.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: purpleColor,
        title: boldText(text: "Shop Settings",size: 18),
      ),

      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            20.heightBox,
            customTextField(label: shopName,hint: shopNameHint,controller: controller.shopNameController).paddingSymmetric(horizontal: 10),
            10.heightBox,
            customTextField(label: shopAddress,hint: shopAddressHint,isDesc: true,controller: controller.shopAddressController).paddingSymmetric(horizontal: 10),
            10.heightBox,
            customTextField(label: shopMobile,hint: shopMobHint,controller: controller.shopMobileController).paddingSymmetric(horizontal: 10),
            10.heightBox,
            customTextField(label: shopWebsite,hint: shopWebSiteHint,controller: controller.shopWebsiteController).paddingSymmetric(horizontal: 10),
            10.heightBox,
            customTextField(label: shopDesc,hint: shopDescHint,isDesc: true,controller: controller.shopDescController).paddingSymmetric(horizontal: 10),
            20.heightBox,
            SizedBox(
              width: context.screenWidth*0.48,
              child: Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white)
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            print("1"+controller.shopNameController.text);
                              controller.isLoading(true);
                              await controller.updateShop(
                                shopadd: controller.shopAddressController.text,
                                shopdesc: controller.shopDescController.text,
                                shopmobile: controller.shopMobileController.text,
                                shopname: controller.shopNameController.text,
                                shopweb: controller.shopWebsiteController.text
                              );
                              VxToast.show(context, msg: "Shop Updated Successfully");
                              Get.back();
                              controller.shopAddressController.clear();
                              controller.shopNameController.clear();
                              controller.shopDescController.clear();
                              controller.shopMobileController.clear();
                              controller.shopWebsiteController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(context.screenWidth*0.5, 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.white
                          ),
                          child: normalText(text: "Save",size: 15,color: purpleColor),
                      )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
