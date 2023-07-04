import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/imgs.dart';
import 'package:e_commerce_admin/controllers/navigation_controller.dart';
import 'package:e_commerce_admin/home/home_screen.dart';
import 'package:e_commerce_admin/orders/order_screen.dart';
import 'package:e_commerce_admin/products/product_screen.dart';
import 'package:e_commerce_admin/settings/settings_screen.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(NavController());

    var navScreens = [
      const DashBoardScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const SettingScreen()
    ];

    var bottomNavBar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size: 30),label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProducts,color: darkGrey,width: 25),label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders,color: darkGrey,width: 25),label: orders),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSetting,color: darkGrey,width: 25),label: settings)
    ];

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldText(text: dashboard,color: fontGrey,size: 18),
      // ),

      bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              onTap: (index) {
                controller.navIndex.value = index;
              },
              backgroundColor: Colors.grey.shade200,
              currentIndex: controller.navIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: purpleColor,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedItemColor: darkGrey,
              items: bottomNavBar
          )
      ),

      body: Column(
        children: [
          Obx(() => Expanded(
              child: navScreens.elementAt(controller.navIndex.value)
          ))
        ],
      ),

    );
  }
}
