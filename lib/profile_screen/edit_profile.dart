import 'dart:io';

import 'package:e_commerce_user/common_widgets/bg_widget.dart';
import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/common_widgets/textfield_custom.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit_Profile extends StatelessWidget {

  final dynamic data;

  const Edit_Profile({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<Profile_Controller>();

    return bgWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.heightBox,
                data['imageUrl']=='' && controller.ProfileImgPath.isEmpty ? Image.asset(profile_img_default,width: 150,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make() : data['imageUrl'] != '' && controller.ProfileImgPath.isEmpty ? Image.network(data['imageUrl'],width: 150,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make() : Image.file(File(controller.ProfileImgPath.value),width: 150,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                customButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  title: "Change Photo",
                  onPress: (){
                    controller.changeImg(context);
                  }
                ),
                Divider(thickness: 1,color: Colors.grey.shade300),
                5.heightBox,
                customTextField(controller: controller.nameController,hint: nameHint,title: name, isPass: false),
                15.heightBox,
                customTextField(controller: controller.oldpassController,hint: password,title: oldpass, isPass: false),
                15.heightBox,
                customTextField(controller: controller.newpassController,hint: password,title: newpass, isPass: false),
                20.heightBox,
                controller.isLoading.value ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)) : SizedBox(
                  width: context.screenWidth-35,
                  child: customButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      title: "Save",
                      onPress: () async {
                        controller.isLoading(true);
                        //if profile image not changed
                        if(controller.ProfileImgPath.value.isNotEmpty){
                          await controller.uploadProfileImg();
                        } else {
                          controller.ProfileImgLink = data['imageUrl'];
                        }
                        //if old password matches to database
                        if(controller.oldpassController.text == data['password']){
                          await controller.changeAuthPass(email: data['email'],password: controller.oldpassController.text,newpassword: controller.newpassController.text);
                          await controller.UpdateProfile(
                              imgUrl: controller.ProfileImgLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text
                          );
                          VxToast.show(context, msg: "Profile Updated Successfully");
                        } else {
                          VxToast.show(context, msg: 'Please enter correct OLD PASSWORD');
                          controller.isLoading(false);
                        }
                      }
                  ),
                ),
              ],
            ).box.color(Colors.white.withOpacity(0.95)).roundedSM.shadowSm.padding(EdgeInsets.all(15)).margin(EdgeInsets.only(top: 50)).make(),
          ),
        ),
      ).box.padding(EdgeInsets.all(10)).make()
    );
  }
}