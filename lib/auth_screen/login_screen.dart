import 'package:e_commerce_user/auth_screen/signup_screen.dart';
import 'package:e_commerce_user/common_widgets/app_logo_widget.dart';
import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/common_widgets/textfield_custom.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/lists.dart';
import 'package:e_commerce_user/controller/auth_controller.dart';
import 'package:e_commerce_user/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login_screen extends StatelessWidget {
  const login_screen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  'Login to $appname',
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
                    customTextField(hint: emailHint,title: email,isPass: false,controller: controller.emailController),

                    20.heightBox,

                    customTextField(hint: passwordHint,title: password,isPass: true,controller: controller.passController),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){},
                          child: Text('$forgetPass')
                      ),
                    ),

                    20.heightBox,

                    controller.isLoading.value? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red),strokeWidth: 3) : customButton(
                        color: Colors.red,
                        title: login,
                        textColor: Colors.white,
                        onPress: () async {
                          controller.isLoading(true);
                          await controller.loginMethod(context: context).then((value){
                              if(value != null)
                              {
                                VxToast.show(context, msg: loggedin);
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home()));
                              }
                              else
                              {
                                controller.isLoading(false);
                              }
                              });
                        }
                    ).box.width(context.screenWidth-50).make(),

                    15.heightBox,

                    Text(
                        '$createnewAcc',
                        style: TextStyle(
                            color: Colors.grey.shade500
                        )
                    ),

                    customButton(
                        color: Colors.yellow.shade700,
                        title: signup,
                        textColor: Colors.white,
                        onPress: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => signup_screen()));
                        }
                    ).box.width(context.screenWidth-50).make(),

                    30.heightBox,

                    Text(
                        '$loginwith',
                        style: TextStyle(
                            color: Colors.grey.shade500
                        )
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(Social_Icons[index],width: 30,),
                        ),
                      ))
                    ),

                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(15)).width(context.screenWidth-70).shadowSm.make(),
              ),
              
            ],
          ),
        ),

      ),
    );
  }
}