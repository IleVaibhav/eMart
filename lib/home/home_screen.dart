import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/common_widget/appbar.dart';
import 'package:e_commerce_admin/common_widget/dashborad_button.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/firebase_const.dart';
import 'package:e_commerce_admin/const/imgs.dart';
import 'package:e_commerce_admin/products/product_details.dart';
import 'package:e_commerce_admin/services/store_services.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: appBar(title: dashboard),

      body: StreamBuilder(
              stream: StoreServices.getProducts(currentUser!.uid),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if(!snapshot.hasData) {
                   return const Center(
                     child: CircularProgressIndicator(color: Colors.white),
                   );
                 } else {
                   var data = snapshot.data!.docs;
                   data = data.sortedBy((a,b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
                   return Padding(
                     padding: EdgeInsets.all(5),
                     child: Column(
                       children: [
                         10.heightBox,
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             dashBoardButton(context,title: products,count: data.length.toString().toString(),icon: icProducts),
                             dashBoardButton(context,title: orders,count: 5.toString(),icon: icOrders)
                           ],
                         ),
                         10.heightBox,
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             dashBoardButton(context,title: rating,count: 4.5.toString(),icon: icStar),
                             dashBoardButton(context,title: totalSales,count: 15.toString(),icon: icSales)
                           ],
                         ),
                         10.heightBox,
                         const Divider(color: Colors.white,thickness: 0.1,height: 8),
                         10.heightBox,
                         boldText(text: popular,color: white,size: 18),
                         20.heightBox,
                         Expanded(
                             child: ListView(
                               physics: const BouncingScrollPhysics(),
                               scrollDirection: Axis.vertical,
                               shrinkWrap: true,
                               children: List.generate(
                                   data.length,
                                       (index) => data[index]['p_wishlist'].length == 0
                                       ? SizedBox()
                                       : Card(
                                     color: Colors.grey.shade200,
                                     child: ListTile(
                                       onTap: () => Get.to(() => ProductDetail(data: data[index])),
                                       leading: Image.network(data[index]['p_imgs'][0],width: 100,height: 100,fit: BoxFit.cover,),
                                       title: boldText(text: data[index]['p_name'],color: fontGrey,size: 16),
                                       subtitle: normalText(text: "₹ ${data[index]['p_prize']}",color: darkGrey,size: 15),
                                     ),
                                   )
                               ),
                             )
                         )
                       ],
                     ),
                   );
                 }
              }
            )
    );
  }
}
