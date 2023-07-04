import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/auth_screen/sign_in.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/firebase_const.dart';
import 'package:e_commerce_admin/const/imgs.dart';
import 'package:e_commerce_admin/controllers/auth_controller.dart';
import 'package:e_commerce_admin/controllers/profile_controller.dart';
import 'package:e_commerce_admin/msg_screen_setting/msg_screen.dart';
import 'package:e_commerce_admin/services/store_services.dart';
import 'package:e_commerce_admin/settings/edit_profile.dart';
import 'package:e_commerce_admin/shop_setting_setting/shop_setting_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: purpleColor,
        automaticallyImplyLeading: false,
        title: boldText(text: settings,size: 18),
        actions: [
          Center(child: normalText(text: intl.DateFormat('EEEEEEEEE, MMM d, y').format(DateTime.now()),size: 15),),
          10.widthBox
        ],
      ),

      body: FutureBuilder(
            future: StoreServices.getProfile(currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(purpleColor)
                  ),
                );
              }
              else {
                var data = snapshot.data!.docs;
                controller.snapshotData = snapshot.data!.docs[0];
                return SafeArea(
                    child: Column(
                      children: [
                        20.heightBox,
                        Image.network(controller.snapshotData['imgUrl'],width: 150,fit: BoxFit.fill).box.clip(Clip.antiAlias).rounded.make(),
                        10.heightBox,
                        boldText(text: "${controller.snapshotData['vendor_name']}",size: 25),
                        const Divider(color: Colors.white,thickness: 0.3,height: 8).paddingSymmetric(horizontal: 100),
                        normalText(text: "${controller.snapshotData['email']}",size: 17),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: context.screenWidth*0.4,
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => EditProfile(username: controller.snapshotData['vendor_name'])),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.white
                                ),
                                child: normalText(text: edit,size: 15,color: purpleColor),
                              ),
                            ),
                            SizedBox(
                              width: context.screenWidth*0.48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Get.find<AuthController>().signOutMethod(context);
                                  Get.offAll(() => const SignInScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.white
                                ),
                                child: normalText(text: logout,size: 15,color: purpleColor),
                              ),
                            )
                          ],
                        ),
                        5.heightBox,
                        const Divider(color: Colors.white,thickness: 0.5).paddingSymmetric(horizontal: 15),
                        Column(
                            children: List.generate(
                                profileButtonIcons.length,
                                (index) => ListTile(
                                  onTap: () {
                                    switch(index) {
                                      case 0:
                                        Get.to(() => const ShopSettings());
                                        break;
                                      case 1:
                                        Get.to(() => const MsgScreen());
                                        break;
                                    }
                                  },
                                  title: boldText(text: profileButtonTitles[index],size: 16),
                                  leading: Icon(profileButtonIcons[index],color: Colors.white),
                                )
                            )
                        ).paddingSymmetric(horizontal: 20)
                      ],
                    )
                );
              }
            },
          ),
    );
  }
}