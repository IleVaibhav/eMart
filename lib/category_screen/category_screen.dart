import 'package:e_commerce_user/common_widgets/bg_widget.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/lists.dart';
import 'package:e_commerce_user/category_screen/category_details.dart';
import 'package:e_commerce_user/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return bgWidget(
      Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Categories',style: TextStyle(fontFamily: bold,color: Colors.white,)),
        ),

        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill)
          ),

          padding: const EdgeInsets.all(10),

          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 200
              ),
              itemBuilder:(context,index) {
                return Column(
                  children: [
                    Image.asset(categoriesImgList[index],height: 150,width: 200,fit: BoxFit.cover,),
                    5.heightBox,
                    Text('${categoriesList[index]}',style: TextStyle(fontFamily: semibold,fontSize: 15,color: Colors.grey.shade700),textAlign: TextAlign.center,)
                  ]
                ).box.white.make().onTap((){controller.getSubCategories(categoriesList[index]);Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryDetails(title: categoriesList[index])));}).box.roundedSM.clip(Clip.antiAlias).size(150,300).shadowSm.white.make();
              }
          ),
        ),

      )
    );
  }
}