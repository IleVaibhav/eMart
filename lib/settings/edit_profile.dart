import 'dart:io';

import 'package:e_commerce_admin/common_widget/custom_textfield.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../const/const.dart';
import '../const/imgs.dart';

class EditProfile extends StatefulWidget {
  final String? username;
  const EditProfile({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: purpleColor,
        title: boldText(text: "Edit Profile",size: 18),
      ),

      body: Obx(
        () => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              20.heightBox,
              controller.snapshotData['imgUrl'] =='' && controller.ProfileImgPath.isEmpty
                  ? Image.asset(user,width: 150,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imgUrl'] != '' && controller.ProfileImgPath.isEmpty
                      ? Image.network(controller.snapshotData['imgUrl'],width: 150,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(File(controller.ProfileImgPath.value),width: 150,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => controller.changeImg(context),
                  child: normalText(text: "Change Image",color: purpleColor)
              ),
              const Divider(color: Colors.white,thickness: 0.5).paddingSymmetric(horizontal: 10),
              10.heightBox,
              customTextField(label: controller.snapshotData['vendor_name'],hint: nameHint,controller: controller.nameController).paddingSymmetric(horizontal: 10),
              10.heightBox,
              Align(
                alignment: Alignment.centerLeft,
                child: boldText(text: "Change Password",size: 16),
              ).paddingOnly(left: 15),
              10.heightBox,
              customTextField(label: password,hint: passHint,controller: controller.oldpassController).paddingSymmetric(horizontal: 10),
              10.heightBox,
              customTextField(label: confirmPassword,hint: passHint,controller: controller.newpassController).paddingSymmetric(horizontal: 10),
              20.heightBox,
              SizedBox(
                width: context.screenWidth*0.48,
                child: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white)
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        controller.isLoading(true);
                        //if profile image not changed
                        if(controller.ProfileImgPath.value.isNotEmpty){
                          await controller.uploadProfileImg();
                        } else {
                          controller.ProfileImgLink = controller.snapshotData['imgUrl'];
                          VxToast.show(context, msg: "Profile Image Updated Successfully");
                        }
                        //if old password matches to database
                        if(controller.oldpassController.text == controller.snapshotData['password']){
                          await controller.changeAuthPass(email: controller.snapshotData['email'],password: controller.oldpassController.text,newpassword: controller.newpassController.text);
                          await controller.UpdateProfile(
                            imgUrl: controller.ProfileImgLink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text
                          );
                          VxToast.show(context, msg: "Profile Updated Successfully");
                          Get.back();
                        } else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull) {
                          await controller.UpdateProfile(
                            imgUrl: controller.ProfileImgLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']
                          );
                        } else {
                          VxToast.show(context, msg: 'Please enter correct OLD PASSWORD');
                          controller.isLoading(false);
                        }
                        controller.newpassController.clear();
                        controller.oldpassController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(context.screenWidth*0.5, 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.white
                      ),
                      child: normalText(text: "Save",size: 16,color: purpleColor)
                  ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
