import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/category_screen/cat_item_details.dart';
import 'package:e_commerce_user/common_widgets/featured_button.dart';
import 'package:e_commerce_user/common_widgets/home_buttons.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/lists.dart';
import 'package:e_commerce_user/controller/home_controller.dart';
import 'package:e_commerce_user/controller/product_controller.dart';
import 'package:e_commerce_user/home_screen/search_screen.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.grey.shade200,
      width: context.screenWidth,
      height: context.screenHeight,

      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: Colors.grey.shade200,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: searchProduct,
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(Icons.search,color: Colors.red).onTap(
                                                        () {
                                                          if(controller.searchController.text.isNotEmptyAndNotNull) {
                                                            Get.to(() =>SearchScreen(title: controller.searchController.text.toLowerCase()));
                                                          }
                                                        })
                ),
              ),
            ),

            3.heightBox,

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderlist1.length,
                        itemBuilder: (context,index) {
                          return Container(
                            child: Image.asset(sliderlist1[index],fit: BoxFit.fill).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 3)).make(),
                          );
                        }
                    ),

                    15.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => HomeButton(
                        height: context.screenHeight*0.13,
                        width: context.screenWidth/2.5,
                        icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        title: index == 0 ? todayDeal : flashSale,
                        // onPress:
                      )),
                    ),

                    15.heightBox,

                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderlist2.length,
                        itemBuilder: (context,index) {
                          return Container(
                            child: Image.asset(sliderlist2[index],fit: BoxFit.fill).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 3)).make(),
                          );
                        }
                    ),

                    15.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) => HomeButton(
                        height: context.screenHeight*0.13,
                        width: context.screenWidth/3.3,
                        icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                        title: index == 0 ? topCategory : index == 1 ? Brand : topSeller,
                        // onPress:
                      )),
                    ),

                    10.heightBox,

                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(featuredCategory,style: TextStyle(color: Colors.grey.shade800,fontSize: 20,fontFamily: semibold))
                    ),

                    5.heightBox,

                    //featured categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(3, (index) => Column(
                          children: [
                            featuredButton(icon: featuredList1img[index],title: featuredList1title[index]),
                            5.heightBox,
                            featuredButton(icon: featuredList2img[index],title: featuredList2title[index])
                          ],
                        )).toList(),
                      ),
                    ),

                    10.heightBox,

                    //featured products
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.red),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.heightBox,
                          const Text(
                            featuredproduct,
                            style: TextStyle(color: Colors.white,fontFamily: bold,fontSize: 20)
                          ),

                          10.heightBox,
                          
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: Firestore_Services.getFeaturedProduct(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(!snapshot.hasData) {
                                    return const CircularProgressIndicator(color: Colors.red);
                                  }
                                  else if(snapshot.data!.docs.isEmpty) {
                                    return const Text("No Featured Products ...",style: TextStyle(fontFamily: semibold,color: darkFontGrey,fontSize: 18));
                                  }
                                  else {
                                    var featuredProduct = snapshot.data!.docs;
                                    return Row(
                                        children: List.generate(
                                            featuredProduct.length,
                                            (index) =>Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(child: Container()),
                                                Image.network(featuredProduct[index]['p_imgs'][0],width: 150,height: 170,fit: BoxFit.fitHeight),
                                                5.heightBox,
                                                Expanded(child: Container()),
                                                Text('Title : ${featuredProduct[index]['p_name']}',style: const TextStyle(fontFamily: semibold),),
                                                5.heightBox,
                                                Text('Prize : ₹${featuredProduct[index]['p_prize']}'),
                                              ],
                                            ).box.white.size(150, 250).roundedSM.margin(const EdgeInsets.symmetric(horizontal: 3)).padding(const EdgeInsets.symmetric(horizontal: 10,vertical: 10)).make().onTap(() => Get.to(() => Itemdetails(title: featuredProduct[index]['p_name'].toString(),data: featuredProduct[index])) )
                                        )
                                    );
                                  }
                              }
                            )
                          ).box.height(250).make()

                        ],
                      ),
                    ),

                    20.heightBox,

                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderlist2.length,
                        itemBuilder: (context,index) {
                          return Container(
                            child: Image.asset(sliderlist2[index],fit: BoxFit.fill).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 3)).make(),
                          );
                        }
                    ),

                    20.heightBox,

                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Top Products',style: TextStyle(color: Colors.grey.shade800,fontSize: 20,fontFamily: semibold))
                    ).box.padding(const EdgeInsets.symmetric(horizontal: 10)).make(),

                    8.heightBox,

                    //All products
                    StreamBuilder(
                      stream: Firestore_Services.getAllProduct(),
                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData) {
                          return const  CircularProgressIndicator(color: Colors.red);
                        }
                        else {
                          Get.put(ProductController());
                          var allProductData = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allProductData.length > 10 ? 10 : allProductData.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 2,
                                  mainAxisExtent: 300
                              ),
                              itemBuilder: (context,index) =>
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(allProductData[index]['p_imgs'][0],width: 200,height: 200,fit: BoxFit.fitWidth),
                                      const Spacer(),
                                      Text('Title : ${allProductData[index]['p_name']}',style: const TextStyle(fontFamily: semibold),),
                                      5.heightBox,
                                      Text('Prize : ₹${allProductData[index]['p_prize']}'),
                                    ],
                                  ).box.white.shadowSm.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 3)).padding(const EdgeInsets.all(10)).make().onTap(() {Get.to(() => Itemdetails(title: allProductData[index]['p_name'].toString(),data: allProductData[index]));})
                          );
                        }
                      }
                    ),
                    
                  ],
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}