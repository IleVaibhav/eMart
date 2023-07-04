import 'package:e_commerce_user/auth_screen/login_screen.dart';
import 'package:e_commerce_user/common_widgets/app_logo_widget.dart';
import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/common_widgets/textfield_custom.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/controller/auth_controller.dart';
import 'package:e_commerce_user/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var Sign_UP_ = false;

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}): super(key: key);

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {

  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill)
        ),

        child: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,

              applogoWidget(),

              10.heightBox,

              const Text(
                  'SignUP to $appname',
                  style: TextStyle(
                      fontFamily: bold,
                      color: Colors.white,
                      fontSize: 20
                  )
              ),

              50.heightBox,

              Obx(
                () => Column(
                  children: [
                    customTextField(hint: nameHint,title: name,controller: nameController,isPass: false),

                    20.heightBox,

                    customTextField(hint: emailHint,title: email,controller: emailController,isPass: false),

                    20.heightBox,

                    customTextField(hint: passwordHint,title: password,controller: passController,isPass: true),

                    20.heightBox,

                    customTextField(hint: passwordHint,title: retype_pass,controller: passRetypeController,isPass: true),

                    10.heightBox,

                    Row(
                      children: [
                          Checkbox(
                              activeColor: Colors.red,
                              checkColor: Colors.white,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue!;
                                });
                              }
                          ),
                          // 5.widthBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(text: 'I agree to the ',style: TextStyle(fontFamily: bold,color: Colors.grey)),
                                    TextSpan(text: '$TermsandCond',style: TextStyle(fontFamily: bold,color: Colors.red)),
                                    TextSpan(text: ' & ',style: TextStyle(fontFamily: bold,color: Colors.grey)),
                                    TextSpan(text: '$PrivacyPolicy',style: TextStyle(fontFamily: bold,color: Colors.red))
                                  ]
                                )
                            ),
                          )
                      ],
                    ),

                    15.heightBox,

                    controller.isLoading.value? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red),strokeWidth: 3) : customButton(
                        color: isCheck == true? Colors.red : Colors.grey,
                        title: signup,
                        textColor: Colors.white,
                        onPress: () async {
                          if(isCheck == true)
                          {
                            controller.isLoading(true);
                            try{
                              await controller.signupMethod(
                                  context: context,
                                  email: emailController.text,
                                  password: passController.text).then((value) {
                                    return controller.storeUserData(
                                        email: emailController.text,
                                        password: passController.text,
                                        name: nameController.text,
                                    );
                                  }).then((value) {
                                      VxToast.show(context,msg: loggedin);
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const Home()));
                                    });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context,msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        }
                    ).box.width(context.screenWidth-50).make(),

                    10.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$alreadyAcc',style: TextStyle(fontFamily: bold,color: Colors.grey)),
                        TextButton(
                            onPressed: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => login_screen()));},
                            child: Text('$login',style: TextStyle(fontFamily: bold,color: Colors.red))
                        ),
                      ],
                    ),

                  ],
                ).box.white.rounded.padding(EdgeInsets.all(15)).width(context.screenWidth-70).shadowSm.make(),
              ),

            ],
          ),
        ),

      ),
    );
  }
}