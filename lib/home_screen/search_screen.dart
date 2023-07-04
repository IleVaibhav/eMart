import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/category_screen/cat_item_details.dart';
import 'package:e_commerce_user/consts/colors.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/styles.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(title.toString(),style: const TextStyle(fontFamily: semibold,color: darkFontGrey)),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),

      body: FutureBuilder(
        future: Firestore_Services.searchProduct(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          else if(snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Products Found ...",style: TextStyle(fontFamily: semibold,color: darkFontGrey,fontSize: 18)));
          }
          else {
            var searchData = snapshot.data!.docs;
            var filter = searchData.where((element) => element['p_name'].toString().toLowerCase().contains(title!)).toList();
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 2,
                      mainAxisExtent: 300
                  ),
                  children: filter.mapIndexed(
                          (currentValue,index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(filter[index]['p_imgs'][0],width: 200,height: 200,fit: BoxFit.fitWidth),
                              const Spacer(),
                              Text('Title : ${filter[index]['p_name']}',style: const TextStyle(fontFamily: semibold),),
                              5.heightBox,
                              Text('Prize : ₹${filter[index]['p_prize']}'),
                            ],
                          ).box.white.shadowSm.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 3)).padding(const EdgeInsets.all(10)).make().onTap(() {Get.to(() => Itemdetails(title: filter[index]['p_name'],data: filter[index]));})).toList(),
                )
            );
          }
        },
      ),

    );
  }
}
