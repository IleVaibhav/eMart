import 'package:e_commerce_user/common_widgets/exit_app.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/controller/home_controller.dart';
import 'package:e_commerce_user/profile_screen/acc_screen.dart';
import 'package:e_commerce_user/cart_screen/cart_screen.dart';
import 'package:e_commerce_user/category_screen/category_screen.dart';
import 'package:e_commerce_user/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = HomeController();

    var NavBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 25),label: '$home'),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 25),label: '$category'),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 25),label: '$cart'),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 25),label: '$acc'),
    ];

    var NavBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const AccScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: NavBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),

        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            backgroundColor: Colors.white60,
            selectedItemColor: Colors.red,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            items: NavBarItem,
            onTap: (value){
              controller.currentNavIndex.value = value;
            },
          ),
        ),

      ),
    );
  }

}