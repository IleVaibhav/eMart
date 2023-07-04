import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/common_widgets/bg_widget.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/category_screen/cat_item_details.dart';
import 'package:e_commerce_user/controller/product_controller.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String title;
  const CategoryDetails({Key? key,required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)){ ProductMethod = Firestore_Services.getProductSubCategory(title);}
    else { ProductMethod = Firestore_Services.getProduct(title);}
  }

  var controller = Get.find<ProductController>();
  dynamic ProductMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(widget.title,style: const TextStyle(fontFamily: bold,color: Colors.white,)),
        ),

          body: StreamBuilder(
            stream: ProductMethod,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)),
                );
              } else if(snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No Product's Found",style: TextStyle(color: Colors.grey.shade600,fontSize: 15,fontFamily: semibold),textAlign: TextAlign.center),
                );
              } else {

                var data = snapshot.data!.docs;

                return Container(
                  padding: EdgeInsets.only(top: context.screenHeight*0.11,right: 8,left: 3),
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill)
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              controller.subcat.length,
                              (index) => Text('${controller.subcat[index]}',style: const TextStyle(fontFamily: semibold),textAlign: TextAlign.center).box
                                                                                                                    .alignCenter
                                                                                                                    .white
                                                                                                                    .margin(const EdgeInsets.symmetric(horizontal: 3,vertical: 5))
                                                                                                                    .roundedSM
                                                                                                                    .size(140,50)
                                                                                                                    .make().onTap(() {
                                                                                                                      switchCategory(controller.subcat[index]);
                                                                                                                      setState(() {});
                                                                                                                    })
                          ),
                        ),
                      ),

                      Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 300
                              ),
                              itemBuilder: (context,index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(data[index]["p_imgs"][0],width: 200,height: 200,fit: BoxFit.contain),
                                    5.heightBox,
                                    Text('${data[index]['p_name']}',style: const TextStyle(fontFamily: semibold),),
                                    5.heightBox,
                                    Text("Prize : ₹${data[index]['p_prize']}",style: const TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w400))
                                    //"Prize : ${data[index]['p_prize']}".numCurrencyWithLocale(locale: "rupee").text.fontFamily(semibold).color(Colors.red).size(15).make(),
                                  ],
                                ).box.white.shadowSm.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 5,vertical: 5)).padding(const EdgeInsets.all(5)).make().onTap((){controller.checkIfFav(data[index]); Navigator.push(context,MaterialPageRoute(builder: (context) => Itemdetails(title: "${data[index]['p_name']}",data: data[index])));});
                              }
                          )
                      )

                    ],
                  ),

                );
              }
            },
          )
      )
    );
  }
}