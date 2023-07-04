import 'dart:async';
import 'package:e_commerce_user/auth_screen/login_screen.dart';
import 'package:e_commerce_user/common_widgets/app_logo_widget.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget{
  const Splash_Screen({super.key});

  @override
  State<StatefulWidget> createState() => Splash_Screen_state();
}

class Splash_Screen_state extends State<Splash_Screen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login_screen()));
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted)
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login_screen()));
        else
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,

      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,width: 300,)
            ),

            const SizedBox(height: 20,),

            applogoWidget(),

            const SizedBox(height: 20,),

            const Text(
              '$appname',
              style: TextStyle(
                  fontFamily: bold,
                  fontSize: 20,
                  color: Colors.white
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'version 1.0.0',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),
            ),

            const Spacer(),

            const Text(
              'V.V',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),
            ),

            //const SizedBox(height: 20),
            20.heightBox
          ],
        )
      ),

    );
  }
}