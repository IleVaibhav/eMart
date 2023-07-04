import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/auth_screen/login_screen.dart';
import 'package:e_commerce_user/common_widgets/bg_widget.dart';
import 'package:e_commerce_user/common_widgets/acc_details_cart.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/consts/lists.dart';
import 'package:e_commerce_user/controller/auth_controller.dart';
import 'package:e_commerce_user/controller/profile_controller.dart';
import 'package:e_commerce_user/messages_screen_profile/msg_screen.dart';
import 'package:e_commerce_user/orders_screen_profile/my_orders.dart';
import 'package:e_commerce_user/profile_screen/edit_profile.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:e_commerce_user/wishlist_screen_profile/my_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccScreen extends StatelessWidget {
  const AccScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(Profile_Controller());
    Firestore_Services.getItemCount();

    return bgWidget(
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill)
            ),

            child: StreamBuilder(
              stream: Firestore_Services.getUser(currentUser!.uid),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red)
                    ),
                  );
                }
                else {

                  var data = snapshot.data!.docs[0];

                  return SafeArea(
                      child: Column(
                        children: [
                          20.heightBox,
                          //user profile image
                          data['imageUrl'] == '' ? Image.asset(profile_img_default,width: 100,fit: BoxFit.cover).box.rounded.clip(Clip.antiAlias).make() : Image.network(data['imageUrl'],width: 150,height: 110,fit: BoxFit.fitWidth).box.rounded.clip(Clip.antiAlias).make(),
                          10.heightBox,
                          //user profile
                          Text('${data['name']}',style: const TextStyle(color: Colors.white,fontFamily: semibold,fontSize: 20)),
                          5.heightBox,
                          Text('${data['email']}',style: const TextStyle(color: Colors.white,fontFamily: semibold,fontSize: 17)),
                          10.heightBox,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        fixedSize: Size.fromWidth(150),
                                        side: const BorderSide(
                                            color: Colors.white
                                        )
                                    ),
                                    onPressed: () async {
                                      controller.nameController.text = data['name'];
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => Edit_Profile(data: data)));
                                    },
                                    child: const Text('Edit profile',style: TextStyle(color: Colors.white,fontFamily: semibold,fontSize: 15))
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        fixedSize: Size.fromWidth(150),
                                        side: const BorderSide(
                                            color: Colors.white
                                        )
                                    ),
                                    onPressed: () async {
                                      await Get.put(AuthController()).signOutMethod(context);
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const login_screen()));
                                    },
                                    child: const Text('logOut',style: TextStyle(color: Colors.white,fontFamily: semibold,fontSize: 15))
                                )
                              ],
                          ),

                          5.heightBox,

                          FutureBuilder(
                            future: Firestore_Services.getItemCount(),
                            builder: (BuildContext context,AsyncSnapshot snapshot) {
                              if(!snapshot.hasData) {
                                return const Center(child: CircularProgressIndicator(color: Colors.red));
                              }
                              else {
                                var countData = snapshot.data;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCart(count: countData[0].toString(),title: "In your Cart",width: context.screenWidth/3.2),
                                    detailsCart(count: countData[1].toString(),title: "In your WishList",width: context.screenWidth/3.2),
                                    detailsCart(count: countData[2].toString(),title: "Your Orders",width: context.screenWidth/3.2)
                                  ],
                                );
                              }
                            }
                          ),

                          1.heightBox,

                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (BuildContext context, int index) {
                              return const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              );
                            },
                            itemCount: AccItemButtonList.length,
                            itemBuilder: (BuildContext context,int index) {
                              return ListTile(
                                onTap: () {
                                  switch(index) {
                                    case 0:
                                      Get.to(() => const OrderScreen());
                                      break;
                                    case 1:
                                      Get.to(() => const MyWishlistScreen());
                                      break;
                                    case 2:
                                      Get.to(() => const MsgScreen());
                                      break;
                                  }
                                },
                                leading: Image.asset(AccItemButtonList[index],width: 20,color: Colors.black54),
                                title: Text(AccItemList[index],style: const TextStyle(fontFamily: bold)),
                              );
                            },
                          ).box.white.shadow.roundedSM.margin(const EdgeInsets.all(6)).padding(const EdgeInsets.symmetric(horizontal: 10)).make(),

                        ],
                      )
                  );
                }

              },
            )
          ),
        )
    );
  }
}