import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/common_widget/appbar.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/firebase_const.dart';
import 'package:e_commerce_admin/controllers/products_controller.dart';
import 'package:e_commerce_admin/products/add_product.dart';
import 'package:e_commerce_admin/products/product_details.dart';
import 'package:e_commerce_admin/services/store_services.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.put(ProductController());
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: appBar(title: products),

      floatingActionButton: SizedBox(
        height: 45,
        width: 45,
        child: FloatingActionButton(
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => const AddProduct());
          },
          elevation: 10,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.add,
            size: 40,
            color: purpleColor,
          ),
        ),
      ),

      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          else {
            var data = snapshot.data!.docs;
            return Padding(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                          color: Colors.grey.shade200,
                          child: ListTile(
                            onTap: () => Get.to(() => ProductDetail(data: data[index])),
                            leading: Image.network(data[index]['p_imgs'][0],width: 100,height: 100,fit: BoxFit.cover,),
                            title: boldText(text: data[index]['p_name'],color: fontGrey,size: 16),
                            subtitle: Row(
                              children: [
                                normalText(text: "₹ ${data[index]['p_prize']}",color: darkGrey,size: 15),
                                10.widthBox,
                                boldText(text: data[index]['is_featured'] ? "Featured" : "",color: green)
                              ],
                            ),
                            trailing: VxPopupMenu(
                                arrowSize: 0,
                                menuBuilder: () => Column(
                                  children: List.generate(
                                      popUpMenuIconList.length,
                                      (i) => Row(
                                        children: [
                                          5.widthBox,
                                          Icon(
                                              popUpMenuIconList[i],
                                              color: data[index]['featured_id'] == currentUser!.uid && i == 0
                                                  ? Colors.green.shade600 : purpleColor
                                          ),
                                          10.widthBox,
                                          normalText(
                                              text: data[index]['featured_id'] == currentUser!.uid && i == 0 ? "Remove Featured" : popUpMenuItems[i],
                                              color: purpleColor)
                                        ],
                                      ).paddingAll(5).onTap(() {
                                        switch(i) {
                                          case 0 :
                                            if(data[index]['is_featured'] == true) {
                                              controller.removeFeatured(data[index].id);
                                              VxToast.show(context, msg: "Product removed from Featured");
                                            } else {
                                              controller.addFeatured(data[index].id);
                                              VxToast.show(context, msg: "Product added as Featured");
                                            }
                                            break ;
                                          case 1 :
                                            break ;
                                          case 2 :
                                            controller.removeProduct(data[index].id);
                                            VxToast.show(context, msg: "Product removed");
                                            break ;
                                        }
                                      })
                                  ),
                                ).box.roundedSM.white.width(170).padding(const EdgeInsets.symmetric(vertical: 2)).make(),
                                clickType: VxClickType.singleClick,
                                child: const Icon(Icons.more_vert_rounded)
                            ),
                          ),
                        )
                    ),
                  ),
                )
            );
          }
        },
      ),
      
    );
  }
}