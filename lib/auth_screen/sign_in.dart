import 'package:e_commerce_admin/common_widget/buttons.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/imgs.dart';
import 'package:e_commerce_admin/bottom_navigation.dart';
import 'package:e_commerce_admin/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              normalText(text: welcome,size: 16,color: lightGrey).box.makeCentered(),
              20.heightBox,
              Image.asset(
                icLogo,
                width: 80,
                height: 80,
              ).box.makeCentered(),
              10.heightBox,
              boldText(text: appname,size: 20,color: lightGrey).box.makeCentered(),
              40.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: purpleColor),
                        hintText: emailHint,
                        border: InputBorder.none
                      ),
                    ),
                    20.heightBox,
                    TextFormField(
                      controller: controller.passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline,color: purpleColor),
                        hintText: passHint,
                        border: InputBorder.none
                      ),
                    ),
                    10.heightBox,
                    TextButton(
                      onPressed: () {},
                      child: normalText(text: forgotPassword,size: 15,color: purpleColor)
                    ).box.alignBottomRight.make(),
                    10.heightBox,
                    SizedBox(
                      width: context.screenWidth,
                      child: controller.isLoading.value ?
                        const Center(
                          child: CircularProgressIndicator(color: purpleColor),
                        )
                        : ourButton(
                          title: login,
                          onPress: () async {
                            controller.isLoading(true);
                            await controller.loginMethod(context: context).then((value) {
                              if(value != null) {
                                VxToast.show(context, msg: "Logged In Successfully");
                                Get.offAll(() => const BottomNav());
                                controller.isLoading(false);
                              }
                              else {
                                controller.isLoading(false);
                              }
                            });
                          }
                       ),
                    )
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(10)).outerShadowMd.make()
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  normalText(text: "In case of any difficulty,",size: 15,color: lightGrey).box.makeCentered(),
                  TextButton(
                      onPressed: () async {
                        await launchUrl(
                            Uri.parse('https://wa.me/+918999756974'),
                            mode: LaunchMode.externalApplication
                        );
                      },
                      child: boldText(text: "Contact administration",size: 15,color: Colors.yellow.shade700),
                  )
                ],
              ),
              // normalText(text: anyProblem,size: 15,color: lightGrey).box.makeCentered(),
              const Spacer(),
              boldText(text: credit).box.makeCentered(),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
