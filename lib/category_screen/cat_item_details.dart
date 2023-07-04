import 'package:e_commerce_user/chat_screen/chat_screen.dart';
import 'package:e_commerce_user/common_widgets/custom_button.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/lists.dart';
import 'package:e_commerce_user/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Itemdetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const Itemdetails({super.key, required this.title,this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async {
        controller.reset_values();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: (){
          //       controller.reset_values();
          //       Get.back();
          //     },
          //     icon: const Icon(Icons.arrow_back)
          // ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('$title',style: TextStyle(color: Colors.grey.shade800,fontFamily: semibold),),
          actions: [
            IconButton(onPressed: (){},icon: const Icon(Icons.share,color: Colors.blue,)),
            Obx(
              () => IconButton(onPressed: (){
                if(controller.isFav.value) {
                  controller.removeWishList(data.id);
                  controller.isFav(false);
                  VxToast.show(context, msg: "Product removed from WishList ...");
                }
                else {
                  controller.addWishList(data.id);
                  controller.isFav(true);
                  VxToast.show(context, msg: "Product added to WishList ...");
                }
              },icon: Icon(Icons.favorite_outlined,color: controller.isFav.value ? Colors.red : Colors.grey,)),
            )
          ],
        ),

        body: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VxSwiper.builder(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            height: 350,
                            aspectRatio: 16/9,
                            itemCount: data["p_imgs"].length,
                            itemBuilder: (context,index){
                              return Image.network(data["p_imgs"][index],width: double.infinity,fit: BoxFit.contain).box.padding(const EdgeInsets.symmetric(horizontal: 5)).make();
                            }
                        ),

                        15.heightBox,

                        Text('$title',style: TextStyle(fontFamily: semibold,fontSize: 17,color: Colors.grey.shade700)),

                        8.heightBox,

                        VxRating(
                          isSelectable: false,
                          value: double.parse(data['p_rating']),
                          onRatingUpdate: (value){},
                          normalColor: Colors.grey,
                          selectionColor: Colors.deepOrangeAccent,
                          count: 5,
                          size: 25,
                          maxRating: 5,
                        ),

                        8.heightBox,

                        Text('₹${data["p_prize"]}',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.red)),

                        10.heightBox,

                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Seller :',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey.shade600)),
                                    5.heightBox,
                                    Text('${data["p_seller"]}',style: TextStyle(fontFamily: semibold,fontWeight: FontWeight.w400,fontSize: 17,color: Colors.grey.shade700),),
                                  ],
                                )
                            ),

                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded,color: Colors.grey),
                            ).onTap(() {
                                Get.to(() => const ChatScreen(),
                                arguments: [data['p_seller'],data['vendor_id']],
                              );
                            })

                          ],
                        ).box.height(60).shadowSm.roundedSM.padding(const EdgeInsets.symmetric(horizontal: 10)).color(Colors.grey.shade300).make(),

                        7.heightBox,

                        //color , quantity and total
                        Obx(
                          () => Column(
                            children: [
                              //color
                              5.heightBox,
                              Row(
                                children: [
                                  3.widthBox,
                                  SizedBox(
                                    width: 100,
                                    child: Text('Color',style: TextStyle(color: Colors.grey.shade700,fontSize: 15,fontFamily: semibold),),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox().roundedFull.color(Color(data['p_colors'][index])).margin(EdgeInsets.symmetric(horizontal: 5)).size(35, 35).make().onTap(() {controller.changeColorIndex(index);}),
                                            Visibility(
                                              visible: index == controller.color_index.value,
                                              child: Icon(Icons.done,color: Colors.white)
                                            )
                                          ],
                                        )
                                    )
                                  )
                                ],
                              ).box.padding(const EdgeInsets.all(5)).make(),

                              //Quantity
                              Row(
                                children: [
                                  3.widthBox,
                                  SizedBox(
                                    width: 100,
                                    child: Text('Quantity',style: TextStyle(color: Colors.grey.shade700,fontSize: 15,fontFamily: semibold),),
                                  ),

                                  Obx(
                                    () => Row(
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                controller.decreaseQuantity();
                                                controller.calculateTotalPrice(int.parse(data["p_prize"]));
                                              },
                                              icon: Icon(Icons.remove,color: Colors.grey.shade700,size: 16),
                                          ),

                                          Text('${controller.quantity.value}',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontFamily: bold)),

                                          IconButton(
                                            onPressed: (){
                                              controller.increaseQuantity(int.parse(data['p_quantity']));
                                              controller.calculateTotalPrice(int.parse(data["p_prize"]));
                                            },
                                            icon: Icon(Icons.add,color: Colors.grey.shade700,size: 16,),
                                          ),

                                          10.widthBox,

                                          Text('${data['p_quantity']} available',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontFamily: semibold)),
                                        ]
                                    ),
                                  ),

                                ],
                              ).box.padding(const EdgeInsets.all(5)).make(),

                              //total
                              Row(
                                children: [
                                  3.widthBox,
                                  SizedBox(
                                    width: 100,
                                    child: Text('Total',style: TextStyle(color: Colors.grey.shade700,fontSize: 15,fontFamily: semibold)),
                                  ),

                                  Text('₹${controller.totalPrice.value}',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontFamily: semibold))
                                ],
                              ).box.padding(const EdgeInsets.all(5)).make(),

                              5.heightBox

                            ],
                          ).box.white.roundedSM.shadowSm.make(),
                        ),

                        7.heightBox,

                        //description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description :',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontFamily: semibold)),
                            5.heightBox,
                            Text('Description Line 0 : ${data['p_desc']}',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                            2.heightBox,
                            Text('Description Line 1',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                            2.heightBox,
                            Text('Description Line 2',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                            2.heightBox,
                            Text('Description Line 3',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                            2.heightBox,
                            Text('Description Line 4',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                            2.heightBox,
                            Text('Description Line 5',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                            2.heightBox,
                            Text('Description Line 5 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z',style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
                          ],
                        ).box.padding(EdgeInsets.all(8)).white.roundedSM.shadowSm.make(),

                        7.heightBox,

                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(Item_detail.length, (index) => ListTile(
                            title: Text('${Item_detail[index]}',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontFamily: semibold)),
                            trailing: Icon(Icons.arrow_forward),
                          )),
                        ).box.white.roundedSM.shadowSm.make(),

                        10.heightBox,

                        Column(
                          children: [
                            Text('$product_also_like',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontFamily: semibold)).box.padding(EdgeInsets.symmetric(vertical: 10,horizontal: 5)).alignCenterLeft.make(),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(6, (index) =>
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                                          5.heightBox,
                                          const Text('Title : Laptop',style: TextStyle(fontFamily: semibold),),
                                          5.heightBox,
                                          const Text('Spec. : 8GB/1TB'),
                                          5.heightBox,
                                          const Text('Prize : \$500'),
                                        ],
                                      ).box.white.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 3)).padding(EdgeInsets.all(10)).make())
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: customButton(
                  color: Colors.red,
                  onPress: (){
                    if(controller.quantity > 0) {
                      controller.addToCart(
                          color: data['p_colors'][controller.color_index.value],
                          title: data['p_name'],
                          context: context,
                          img: data['p_imgs'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          t_price: controller.totalPrice.value,
                          vendorID: data['vendor_id']
                      );
                      VxToast.show(context, msg: "Added to Cart");
                    }
                    else {
                      VxToast.show(context, msg: "Add minimum one product");
                    }
                  },
                  textColor: Colors.white,
                  title: 'Add to Cart'
                ),
              ),
            )
          ],
        )

      ),
    );
  }
}